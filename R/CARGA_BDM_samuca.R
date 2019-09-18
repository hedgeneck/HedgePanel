# PACOTE DE BANCO DE DADOS
library(RSQLite)
# PACOTE DE DIAS UTEIS
library(bizdays)
cal = bizdays::calendars() # CRIANDO CALENDARIO BRAZIL/ANBIMA (PADRAO)
# PACOTE DE LOGS: rlogging
#install.packages("~/BDM/Packages/rlogging_1.1.tar.gz", repos = NULL, type = "win.binary")
library(rlogging)
library(mailR)
setwd("/Users/Rech/Documents/Finanças/BDM")

##################### FUNCOES UTEIS ############################

conectar.bdm = function(){ 
  dbConnect(dbDriver("SQLite"), "BD/BDM.sqlite")
}

desconectar.bdm = function(conn){
  dbDisconnect(conn)
}

dias.uteis.desde = function(date){
  if(is.na(date)) date = as.Date("2019-07-01")
  datas = bizseq(date, Sys.Date()-1, "Brazil/ANBIMA")
  datas[datas != date]
}

generate.log.filename = function(){
  format(Sys.time(), "Logs/Log-BDM-%Y-%m-%d-%H-%M-%S.txt")
}

dates.to.string = function(df){
  for(i in 1:ncol(df)){
    if(class(df[,i]) == "Date") df[,i] = format(df[,i], "%Y-%m-%d")
  }
  return(df)
}

#################### FIM DE FUNCOES UTEIS #####################

######################### MODELO DE ###########################
####### FUNCOES DE ATUALIZACAO PARA CADA FONTE DE DADOS #######

# Ler os dados de XXXX para a data dt
# Deve causar erro se o dado nao estiver disponivel
# ler.XXXX = function(dt){}
  
# Carregar no BDM os dados de XXXX para a data dt
#carregar.XXXX = function(dt){}

# Retornar a ultima data carregada para XXXX
#ultima.data.XXXX = function(){}

# Atualizar no BDM os dados de XXXX a partir da ultima data
#atualizar.XXXX = function(){}

####################### FIM DOS MODELOS ######################


############### FUNCAO DE ATUALIZACAO PRINCIPAL ##############
# Carregar os scripts das fontes 
# e chamar as funcoes atualizar()

source("Scripts/CETIP_CDI.R")
source("Scripts/ANBIMA_CURVAS_CREDITO.R")
source("Scripts/ANBIMA_DEBENTURES.R", encoding = "UTF-8")
source("Scripts/ANBIMA_DEBENTURES_SECUNDARIO.R")
source("Scripts/ANBIMA_ESTRUTURA_TERMO.R")
#source("Scripts/ANBIMA_PROJECAO_INFLACAO.R")
source("Scripts/ANBIMA_TITULOS_PUBLICOS.R")
source("Scripts/ANBIMA_VNA_TITULOS_PUBLICOS.R")
source("Scripts/BACEN_NEGOCIOS_TPF.R")
source("Scripts/BACEN_SGS_VALOR_UNICO.R")
source("Scripts/BMF_BMFINDIC.R")
#source("Scripts/BMF_BVBG.R")
source("Scripts/BMF_COTAHIST.R")
source("Scripts/BMF_TAXASWAP.R")


atualizar.bdm = function(){
  message("INICIANDO ATUALIZACAO DO BDM")
  atualizar.CETIP.CDI()
  atualizar.anbima.curvas.credito()
  atualizar.anbima.debentures()
  atualizar.anbima.debentures.secundario()
  atualizar.anbima.ettj()
  #atualizar.projecoes.igp.anbima()
  atualizar.anbima.titulos.publicos()
  atualizar.anbima.vna()
  atualizar.bacen.negocios.tpf()
  atualizar.bacen.serie()
  atualizar.bmf.indices()
  #atualizar.bmf.bvbg()
  atualizar.bmf.cotahist()
  atualizar.bmf.taxaswap()
  message("FIM DA ATUALIZACAO DO BDM")
}


################################################
#                   EXECUCAO

# Especificar o log
logfile = generate.log.filename()
SetLogFile(logfile)
SetLogLevel("INFO")

# Atualizar BDM
conn = conectar.bdm()
atualizar.bdm()
dbDisconnect(conn)

### ENVIAR RELATORIO:
from = "samuel_rech@hotmail.com"
to = "samuel_rech@hotmail.com"
subject = "[BDM] Relatorio de Atualizacao de Dados"
body = paste(readLines(logfile), collapse = "\n")

message("Enviando relatorios de execucao...")

# # opcao 1: servidor de emails da sua empresa


smtp.config = list(
  host.name = "smtp.live.com",
  port = 587,
  user.name = "samuel_rech@hotmail.com", 
  passwd = "Samuca123#", 
  tls = TRUE)

send.mail(
  from = from,
  to = to,
  subject = subject,
  body = body,
  smtp = smtp.config,
  authenticate = T,
  send = T
)

# opcao 2: via gmail

# gmailr::send_message(gmailr::mime(
#   from = from,
#   to = to,
#   subject = subject,
#   body = body
# ))


# library(sendmailR)
# from <- "<samuel_rech@hotmail.com>"
# to <- "<samuel_rech@hotmail.com>"
# subject <- "Performance Result"
# body <- "This is the result of the test:"                     
# mailControl=list(smtpServer="smtp.live.com")
# sendmail(from=from,to=to,subject=subject,msg=body,control=mailControl)


message("OK!")