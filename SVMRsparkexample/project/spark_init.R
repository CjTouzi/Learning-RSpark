library(SparkR)
library(RTextTools)
library(rjson)

Json2SparkRDD <- function(json.file,master="local"){
  
  # initilize spark and transform json file into RDD R-object
  # Args:
  #   json.file: json file directory 
  #   master: master
  # Returns:
  #   RDD R-object
  
  sc <- sparkR.init(master)  
  
  includePackage(sc, rjson)
  includePackage(sc, RTextTools)
  
  ## map text source to spark core
  input <- textFile(sc, json.file) 
  articles <- lapply(input, fromJSON)
  

}
