library(SparkR)
library(rjson)
library(RTextTools)

sc <- sparkR.init("local")

includePackage(sc, rjson)
includePackage(sc, RTextTools)

input <- textFile(sc, "file:///home/zhicheng/ISR/articles_3364.json")
#count(input)

articles <- lapply(input, fromJSON)
#count(articles)
#first(articles)

gov_terms <- rbind(
  c('Audit Committee Independence' , 'governance'),
  c('Compensation Committee Independence' , 'governance'),
  c('Nomination Committee Independence' , 'governance'),
  c('Board Meeting Attendance Average' , 'governance'),
  c('Board Gender Diversity' , 'governance'),
  c('Compensation Policy' , 'governance'),
  c('Sustainability Compensation Incentives' , 'governance'),
  c('Senior Executive Total Compensation' , 'governance'),
  c('Board Member Total Compensation' , 'governance'),
  c('Experienced Board' , 'governance'),
  c('Highest Remuneration Package' , 'governance'),
  c('Anti Takeover Devices' , 'governance'),
  c('Compensation Controversies' , 'governance'),
  c('Non-Executive Board Member Total' , 'governance'),
  c('Board Structure' , 'governance'),
  c('Board Functions' , 'governance'),
  c('Shareholders Rights' , 'governance'),
  c('Vision and Strategy' , 'governance'),
  c('Implementation' , 'governance'),
  c('Quality and consistency' , 'governance'),
  c('corporate disclosure obligations' , 'governance'),
  c('litigation costs' , 'governance'),
  c('independent directors' , 'governance'),
  c('sustainability initiatives and networks' , 'governance'),
  c('employee incentives' , 'governance'),
  c('core business decisions' , 'governance'),
  c('Executive compensation' , 'governance'),
  c('blow-ups' , 'governance'),
  c('financial surprises' , 'governance'),
  c('Poison pills' , 'governance'),
  c('Takeover defenses' , 'governance'),
  c('Staggered Boards' , 'governance'),
  c('Say on pay' , 'governance'),
  c('Majority voting' , 'governance'),
  c('Dual-class' , 'governance'),
  c('Share Structure' , 'governance'),
  c('Cumulative voting' , 'governance'),
  c('pay equity' , 'governance'),
  c('shareholder' , 'governance'),
  c('Audit integrity' , 'governance'),
  c('internal control risks' , 'governance'),
  c('Executive performance' , 'governance'),
  c('Board leadership' , 'governance'),
  c('Business Ethics' , 'governance'),
  c('Reputation' , 'governance'),
  c('ethical risks' , 'governance'),
  c('fundamental risk' , 'governance'),     
  c('Board accountability' , 'governance'),     
  c('Accountability' , 'governance'),     
  c('Stockholders' , 'governance')    
)


soc_terms <- rbind(
  c('% of salary paid during sick leave' , 'social'),
  c('bottom of the pyramid' , 'social'),
  c('Amount of social investment' , 'social'),
  c('adherence to labor standards' , 'social'),
  c('avoiding employee churn' , 'social'),
  c('employee health' , 'social'),
  c('ILO labor standards' , 'social'),
  c('Poverty and community impact' , 'social'),
  c('Supply Chain Management' , 'social'),
  c('fundamental human rights' , 'social'),
  c('Safe Labor practices' , 'social'),
  c('Bio Capacity' , 'social'),
  c('Corporate Social Responibility' , 'social'),
  c('Business relationships' , 'social'),
  c('Gender Equality' , 'social'),
  c('Health Insurance Cards' , 'social'),
  c('Customer satisfaction' , 'social'),
  c('Customer Loyalty' , 'social'),
  c('Business Units' , 'social'),
  c('Human Rights' , 'social'),
  c('Animal Welfare' , 'social'),
  c('Supply chain' , 'social'),
  c('Ethical Investments' , 'social'),
  c('Social Responsibility' , 'social'),
  c('Equal Pay' , 'social'),
  c('Women Rights' , 'social'),
  c('Human capital management' , 'social'),
  c('Labour relations' , 'social'),
  c('Hiring rate trend' , 'social'),
  c('Career develoment training' , 'social'),
  c('Working conditions' , 'social'),
  c('Employee absenteeism' , 'social'),
  c('Emerging technology' , 'social'),
  c('Community relations' , 'social'),
  c('Responsible lending' , 'social'),
  c('Corporate philanthropy' , 'social'),
  c('brand loyalty' , 'social'),
  c('worker rights' , 'social'),
  c('child labor' , 'social'),
  c('community relations' , 'social'),
  c('indigenous rights' , 'social'),
  c('Animal welfare' , 'social'),
  c('social risks' , 'social'),
  c('Genetically modified organisms' , 'social'),
  c('Living wage disputes' , 'social'),
  c('Predatory lending' , 'social'),
  c('Sexual harassment' , 'social'),
  c('Slave labor' , 'social'),
  c('Political risk' , 'social'),
  c('Political contributions' , 'social')  
)


eco_terms <- rbind(
  c('Biodiversity & Ecosystem', 'ecological'),
  c('Electricity Purchased', 'ecological'),
  c('Water Withdrawal Total', 'ecological'),
  c('Water Recycled', 'ecological'),
  c('CO2 Equivalents Emissions', 'ecological'),
  c('NOx Emissions ', 'ecological'),
  c('SOx Emissions ', 'ecological'),
  c('VOC Emissions', 'ecological'),
  c('Waste Total', 'ecological'),
  c('Waste Recycled Total', 'ecological'),
  c('Hazardous Waste', 'ecological'),
  c('Environmental Management System Certified System', 'ecological'),
  c('Spills and Pollution Controversies', 'ecological'),
  c('Resource Reduction', 'ecological'),
  c('Emission Reduction', 'ecological'),
  c('Product Innovation', 'ecological'),
  c('Responsible Investment', 'ecological'),
  c('Energy Efficiency', 'ecological'),
  c('Breakdown of energy costs', 'ecological'),
  c('Breakdown of carbon costs', 'ecological'),
  c('off-grid electricity', 'ecological'),
  c('industrial processes', 'ecological'),
  c('fugitive emissions', 'ecological'),
  c('energy-related R&D', 'ecological'),
  c('% of renewable energy', 'ecological'),
  c('Green House Gas emissions', 'ecological'),
  c('Water Footprint', 'ecological'),
  c('Water Footprint Network', 'ecological'),
  c('Biodiversity Hotspots', 'ecological'),
  c('ecosystem efficient product', 'ecological'),
  c('resource-efficient', 'ecological'),
  c('recyclable products', 'ecological'),
  c('Innovation in environmentfriendly products and services', 'ecological'),
  c('Biodiversity & Ecosystem', 'ecological'),
  c('carbon regulation', 'ecological'),
  c('climate change policy', 'ecological'),
  c('water-stressed area', 'ecological'),
  c('access to sanitation', 'ecological'),
  c('long-term water resource', 'ecological'),
  c('biodiversity losses', 'ecological'),
  c('OECD-level regulation', 'ecological'),
  c('environmental problems', 'ecological'),
  c('Natural resource conservation', 'ecological'),
  c('Animal treatment', 'ecological'),
  c('Environmental risk', 'ecological'),
  c('Biodiversity & Ecosystem', 'ecological'),
  c('Hazardous waste', 'ecological'),
  c('Toxic emissions', 'ecological'),
  c('Biodiversity & Ecosystem', 'ecological'),
  c('Waste Management', 'ecological')  
)

tweets <- rbind(gov_terms, soc_terms, eco_terms)
train.size <- nrow(tweets)
features <- tweets[, 1]
labels <- as.factor(tweets[, 2])

matrix <- create_matrix(features, language="english", 
                        removeStopwords=FALSE, removeNumbers=TRUE,
                        stemWords=FALSE)

terms <- matrix$dimnames$Terms # all terms in training set

train.data <- create_container(matrix, labels, trainSize=1:train.size, 
                             testSize=NULL, virgin=TRUE)

model <- train_model(train.data, algorithm="SVM")

ClassifyISR <- function(article) {
  
  feature <- article$title
  
  test <- create_matrix(feature, language="english", 
                        removeStopwords=FALSE, removeNumbers=TRUE,
                        stemWords=FALSE)
  
  # Exclude terms not in training set
  feature <- paste0(intersect(test$dimnames$Terms, terms), collapse=" ")
  if (feature == "") {
    return("non-ISR")
  }
  matrix <- create_matrix(c(features, feature), language="english", 
                          removeStopwords=FALSE, removeNumbers=TRUE,
                          stemWords=FALSE)
  
  container = create_container(matrix, labels, trainSize=1:train.size, 
                               testSize=train.size+1, virgin=TRUE)
  
  result <- classify_model(container, model)
  result
}

results <- lapply(articles, ClassifyISR)
output <- collect(results)
head(output)