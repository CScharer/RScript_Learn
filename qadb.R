version
library(RSQLite)
dbVivit <- "C:/Workspace/Github/cjs-app/cjs-app-gui/Data/qadb.sqlite";
con <- dbConnect(RSQLite::SQLite(), dbVivit)
tables <- dbListTables(con)
vtables <- strsplit(tables, " ")
vtables
# library(stringr)
# library(foreach)
# foreach(i=1:length(vtables)) %do%
# {
#   tableName <- vtables[i]
#   # sql <- str_c("SELECT * FROM ", tableName[1])
#   sql <- str_c(tableName[1])
#   rs <- c(dbReadTable(con, sql))
#   # nrow(rs)
#   # ncol(rs)
#   # str(rs)
#   # head(rs)
#   summary(rs)
# }
length(vtables)
dbDisconnect(con)