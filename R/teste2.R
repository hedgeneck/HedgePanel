library(httr)
library(stringr)

url = "http://www2.bmf.com.br/pages/portal/bmfbovespa/lumis/lum-ajustes-do-pregao-ptBR.asp"

response = POST(url, 
                body = list(
                  dData1 = "09/09/2019" ),
                encode = "form")
page = content(response, "text", encoding = "iso-8859-1")

# esse pattern pega toda a parte da tabela referente a DI
pattern = paste0(
  "<tr>\\s*<td>DI1[^<]*</td>\\s*", #primeiro TD com nome do ativo sendo DI
  "<td[^>]*>[A-Z]\\d{2}[^<]</td>\\s*", # segundo TD contendo Vencimento
  "<td[^>]*>[\\d.,-]*</td>\\s*", # terceiro TD com Preço de Ajuste Anterior
  "<td[^>]*>[\\d.,-]*</td>\\s*", # quarto TD contendo Preço de Ajuste Atual
  "<td[^>]*>[\\d.,-]*</td>\\s*", # quinto TD contendo Variação
  "<td[^>]*>[\\d.,-]*</td>\\s*</tr>", # Valor do Ajuste por Contrato
  "(?:\\s*<tr>\\s*<td></td>\\s*", #Começa segunda série de TD, sem nada
  "<td[^>]*>[A-Z]\\d{2}[^<]</td>\\s*", # Vencimento
  "<td[^>]*>[\\d.,-]*</td>\\s*", # TD com Preço de Ajuste Anterior
  "<td[^>]*>[\\d.,-]*</td>\\s*", # TD contendo Preço de Ajuste Atual
  "<td[^>]*>[\\d.,-]*</td>\\s*", # TD contendo Variação
  "<td[^>]*>[\\d.,-]*</td>\\s*</tr>)*" # Valor do Ajuste por Contrato
)

# quando não for extrair nenhum grupo usa str_extract() e str_extract_all()
# quando for extrair grupos, melhor usar str_match() e str_match_all()
total_exp = str_extract(string = page, pattern = pattern)[[1]]

# esse padrão serve para dividir cada table row em parte de um vetor
pattern = paste0(
  "<tr>\\s*<td>[^<]*</td>\\s*", #primeiro TD com nome do ativo sendo DI
  "<td[^>]*>[A-Z]\\d{2}[^<]</td>\\s*", # segundo TD contendo Vencimento
  "<td[^>]*>[\\d.,-]*</td>\\s*", # terceiro TD com Preço de Ajuste Anterior
  "<td[^>]*>[\\d.,-]*</td>\\s*", # quarto TD contendo Preço de Ajuste Atual
  "<td[^>]*>[\\d.,-]*</td>\\s*", # quinto TD contendo Variação
  "<td[^>]*>[\\d.,-]*</td>\\s*</tr>*" # Valor do Ajuste por Contrato
)

parts = as.vector(str_extract_all(string = total_exp, pattern = pattern)[[1]])

# esse padrão serve para extrair os groupings do vetor de table rows
pattern = paste0(
  "<tr>\\s*<td>[^<]*</td>\\s*", #primeiro TD com nome do ativo sendo DI
  "<td[^>]*>([A-Z]\\d{2}[^<])</td>\\s*", # segundo TD contendo Vencimento
  "<td[^>]*>([\\d.,-]*)</td>\\s*", # terceiro TD com Preço de Ajuste Anterior
  "<td[^>]*>([\\d.,-]*)</td>\\s*", # quarto TD contendo Preço de Ajuste Atual
  "<td[^>]*>([\\d.,-]*)</td>\\s*", # quinto TD contendo Variação
  "<td[^>]*>([\\d.,-]*)</td>\\s*</tr>*" # Valor do Ajuste por Contrato
)

matches = str_match_all(string = parts, pattern = pattern)

matriz = matrix(unlist(matches),nrow=length(matches),byrow=T)

dados = data.frame(matriz[,-1], stringsAsFactors = F)

# essa solução para adicionar data adiciona no fim, portanto dá para melhorar
dados['Data'] = dt

# apenas para dar uma olhada e ver que ficou tudo factor
# str(dados)

colnames(dados) = c("Vencimento", "PA_Anterior", "PA_Atual", "Variacao", "VAPC")

dados$Vencimento = gsub(" ","",dados$Vencimento)
# se não escapar o . dá pau. Pode usar [.] tambem
dados$PA_Anterior = gsub("\\.","",dados$PA_Anterior)
dados$PA_Anterior = gsub(",",".",dados$PA_Anterior)
dados$PA_Anterior = as.numeric(dados$PA_Anterior)

dados$PA_Atual = gsub("\\.","",dados$PA_Atual)
dados$PA_Atual = gsub(",",".",dados$PA_Atual)
dados$PA_Atual = as.numeric(dados$PA_Atual)

dados$Variacao = gsub("\\.","",dados$Variacao)
dados$Variacao = gsub(",",".",dados$Variacao)
dados$Variacao = as.numeric(dados$Variacao)

dados$VAPC = gsub("\\.","",dados$VAPC)
dados$VAPC = gsub(",",".",dados$VAPC)
dados$VAPC = as.numeric(dados$VAPC)

# writeLines(total_exp, "outfile.txt")
