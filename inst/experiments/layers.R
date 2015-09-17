library(rcdimple)

#get data used by dimple for all of its examples as a first test
ex_data <- read.delim(
  "http://pmsi-alignalytics.github.io/dimple/data/example_data.tsv"
)


#eliminate . to avoid confusion in javascript
colnames(ex_data) <- gsub("[.]","", colnames(ex_data))


#recreate http://dimplejs.org/advanced_examples_viewer.html?id=advanced_price_range_lollipop
