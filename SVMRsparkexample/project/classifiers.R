library(RTextTools)

TermFilter <- function (test.term, train.term){
  
  # filter out the terms in test set but not in train set
  #
  # Args:
  #   test.term: char[]
  #   train.term: char[]
  # Returns:
  #   a char[] without terms 
  
  feature <- paste0(intersect(test.term, train.term), collapse=" ")
  
}


ModelPredict <- function(train.docs, train.labels, test.docs, model){
  
  # predict by classification model
  # 
  # Args:
  #   train.docs: char[]
  #   train.labels: factor [] 
  #   test.docs: charp[]
  # Returns:
  #   factor [] 
  
  matrix <- create_matrix(c(train.docs,test.docs), language="english", 
                          removeStopwords=FALSE, removeNumbers=TRUE,
                          stemWords=FALSE)

  train.size <- length(train.docs)
  test.size <- length(test.docs)
  container = create_container(matrix, train.labels, trainSize=1:train.size, 
                               testSize=(train.size+1): (train.size+test.size), virgin=TRUE)
  
  result <- classify_model(container, model)
  result

}
