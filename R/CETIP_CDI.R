
ler.CETIP.CDI = function(dt){
  stopifnot(is(dt, "Date"), length(dt) == 1)
  url = format(dt, "ftp://ftp.cetip.com.br/MediaCDI/%Y%m%d.txt")
  txt = try(readLines(url), silent = T)
  if(is(txt, "try-error")){
    stop(paste0("erro ao ler o CDI para a data ", dt))
  }
  txt = gsub(" ", "", txt)
  cdi = as.numeric(txt)/100
  return(cdi)
}

carregar.CETIP.CDI = function(dt){
  cdi = ler.CETIP.CDI(dt)
  dados = data.frame(data = dt, valor = cdi, stringsAsFactors = F)
  
  sql = "INSERT INTO cdi_cetip (data, valor) VALUES (:data, :valor)"
  r = try(dbSendQuery(conn, sql, params=dates.to.string(dados)))
  if(!is(r, "try-error")){
    message("CDI CETIP carregado com sucesso para a data ", format(dt, "%Y-%m-%d"))
    dbClearResult(r)
  } else {
    stop("Erro ao carregar CDI CETIP para a data ", format(dt, "%Y-%m-%d"))
  }
}

ultima.data.CETIP.CDI = function(){
  dbGetQuery(conn, "SELECT max(data) FROM CDI_CETIP")[1,1]
}

atualizar.CETIP.CDI = function(){
  message("Atualizando CDI CETIP...")
  datas = dias.uteis.desde(ultima.data.CETIP.CDI())
  if(length(datas)==0){
    message("Nada a ser feito.")
  } else {
    for(i in 1:length(datas)){
      try(carregar.CETIP.CDI(datas[i]))
    }
  }
  
}
# dt = as.Date("2018-07-17", "%Y-%m-%d")
# 
# ler.CETIP.CDI(dt)
# 
# library(bizdays)
# cal = create.calendar("ANBIMA", holidaysANBIMA, weekdays=c("saturday", "sunday"))
# 
# datas = bizdays::bizseq(as.Date("2018-07-01"), as.Date("2018-07-19"), "ANBIMA")
# 
# for(i in 1:length(datas)){
#   dt = datas[i]
#   cdi = ler.CETIP.CDI(dt)
#   print(dt)
#   print(cdi)
# }



