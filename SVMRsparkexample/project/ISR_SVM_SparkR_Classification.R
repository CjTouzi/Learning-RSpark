## init spark ------------------------------------
source("./spark_init.R")
json.file <- "file:///home/zhicheng/ISR/articles_3364.json"
articles <- Json2SparkRDD(json.file)


## training model--------------------------
# author comments: K.* variables mean global variable

source("./training_source.R")
source("./classifiers.R")
tweets <- ISRDocs()

K.train.size <- nrow(tweets)

K.features <- tweets[, 1]

K.labels <- as.factor(tweets[, 2])

matrix <- create_matrix(K.features, language="english", 
                removeStopwords=FALSE, removeNumbers=TRUE,
                        stemWords=FALSE)

K.terms <- matrix$dimnames$Terms # all terms in training set

train.data <- create_container(matrix, 
                               K.labels, 
                               trainSize=1:nrow(tweets), 
                               testSize=NULL, 
                               virgin=TRUE)

K.SVMmodel <- train_model(train.data, algorithm="SVM")



## model predict---------------------------------------

ClassifyISR <- function(article) {
  
  #  classify article titles using SVM
  #
  # Args:
  #   K.terms: terms in training set
  #   K.labels: lables in training set 
  #   K.SVMmodel: svm model
  #   k.features: features in training set
  # Returns:
  #   lables of test set
  
  
  test.feature <- article$title
  test <- create_matrix(test.feature, language="english", 
                        removeStopwords=FALSE, removeNumbers=TRUE,
                        stemWords=FALSE)
  
  ##　Exclude terms not in training set
  test.feature <- TermFilter(test$dimnames$Terms, K.terms)
  if (test.feature == "") {
    return("non-ISR")
  }
  
  result <- ModelPredict(K.features,K.labels, test.feature, K.SVMmodel)
  
}


results <- lapply(articles, ClassifyISR)
output <- collect(results)

#sparkR.stop()


