library(rcdimple)
library(dplyr)

#get data used by dimple for all of its examples as a first test
ex_data <- read.delim(
  "http://pmsi-alignalytics.github.io/dimple/data/example_data.tsv"
)


#eliminate . to avoid confusion in javascript
colnames(ex_data) <- gsub("[.]","", colnames(ex_data))


#recreate http://dimplejs.org/advanced_examples_viewer.html?id=advanced_price_range_lollipop
ex_data %>%
  filter(Channel=="Hypermarkets") %>%
  dimple(
    SalesValue ~ Brand,
    type = "bar",
    storyboard = "Date"
  ) %>%
  xAxis(orderRule = list(ordering = "SalesValue",desc=TRUE)) %>%
  add_series(
    x = "Brand",
    y = "Price",
    type = "bubble",
    aggregate = "dimple.aggregateMethod.avg",
    yAxis = list(hidden = FALSE)
  )  %>%
  add_series(
    x = "Brand",
    y = "Price",
    type = "bubble",
    aggregate = "dimple.aggregateMethod.min"
  ) %>%
  add_series(
    x = "Brand",
    y = "Price",
    type = "bubble",
    aggregate = "dimple.aggregateMethod.max"
  )
  
# more testing
mtcars %>%
  dimple(mpg ~ cyl, type = "bar", groups = "cyl") %>%
  # hidden = FALSE so we can compare
  add_series(x = "cyl", y = "mpg", type = "bubble", groups = "cyl", yAxis = list(hidden=FALSE) ) %>%
  add_series(x = "cyl", y = "mpg", type = "line" )