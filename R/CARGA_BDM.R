library(RSQLite)
library(bizdays)
cal = bizdays::calendars()


conectar.bdm = function(){ 
  dbConnect(dbDriver("SQLite"), "../HedgePanel/storage.db")
}

desconectar.bdm = function(conn){
  dbDisconnect(conn)
}

dias.uteis.desde = function(date){
  if(is.na(date)) date = as.Date("2012-08-20")
  datas = bizseq(date, Sys.Date()-1, "Brazil/ANBIMA")
  datas[datas != date]
}

dates.to.string = function(df){
  for(i in 1:ncol(df)){
    if(class(df[,i]) == "Date") df[,i] = format(df[,i], "%Y-%m-%d")
  }
  return(df)
}


source("CETIP_CDI.R")


conn = conectar.bdm()
atualizar.CETIP.CDI()
dbDisconnect(conn)
