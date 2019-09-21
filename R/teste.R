install.packages("httr")
library(httr)
library(stringr)

url = "http://www2.bmf.com.br/pages/portal/bmfbovespa/lumis/lum-ajustes-do-pregao-ptBR.asp"

r = POST(
  url = url,
  body = list(
    dData1 = "opa"
  )
)

r = POST(
  url = "http://www2.bmf.com.br/pages/portal/bmfbovespa/lumis/lum-ajustes-do-pregao-ptBR.asp"
)


txt = content(r, as = "text", encoding = "UTF-8")



r <- GET(url)
content(r, as = "text", encoding = "UTF-8")
content(r)



url = "http://www2.bmf.com.br/pages/portal/bmfbovespa/lumis/lum-ajustes-do-pregao-ptBR.asp"
query = list('form[dData1]'="2014-11-01")
response = POST(url, body = query)
page = content(response, "text", encoding = "iso-8859-1")
cat(page, "outfile.txt")
writeLines(page, "outfile.txt")






url = "http://www2.bmf.com.br/pages/portal/bmfbovespa/lumis/lum-ajustes-do-pregao-ptBR.asp"
response = POST(url, body = list(
  dData1 = "09/09/2019"
))
response = POST(url, body = list(
  dData1 = 11/09/2019
))
page = content(response, "text", encoding = "iso-8859-1")
writeLines(page, "outfile.html")






url = "http://www2.bmf.com.br/pages/portal/bmfbovespa/lumis/lum-ajustes-do-pregao-ptBR.asp"
query = list('form[dData1]'="dData1=11%2F09%2F2019")
response = POST(url, body = query)
page = content(response, "text", encoding = "iso-8859-1")
writeLines(page, "outfile.html")





url = "http://www2.bmf.com.br/pages/portal/bmfbovespa/lumis/lum-ajustes-do-pregao-ptBR.asp"
response = POST(url, 
                body = list(
                            dData1 = "09/09/2019" ),
                encode = "form")
page = content(response, "text", encoding = "iso-8859-1")
writeLines(page, "outfile.html")


strings <- c("Home: 219 733 8965.  Work: 229-293-8753 ",
             "banana pear apple", "595 794 7569 / 387 287 6718")
phone <- "([2-9][0-9]{2})[- .]([0-9]{3})[- .]([0-9]{4})"

a = str_extract_all(strings, phone)
b = str_match_all(strings, phone)
