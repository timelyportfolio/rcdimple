library(rcdimple)

#get data used by dimple for all of its examples as a first test
ex_data <- read.delim(
  "http://pmsi-alignalytics.github.io/dimple/data/example_data.tsv"
)

#eliminate . to avoid confusion in javascript
colnames(ex_data) <- gsub("[.]","", colnames(ex_data))

ex_data %>%
  dimple(x = "PriceTier", y = "PackSize", p = "UnitSales", groups = "Channel", type = "pie", piesRadius = 25) %>%
  yAxis(type = "addCategoryAxis")

ex_data %>%
  dimple(
    x = "Month",
    y = "UnitSales",
    p = "UnitSales",
    groups = "Channel",
    radius = 20,
    type = "pie"
  ) %>%
  xAxis(orderRule = "Date") %>%
  add_series(x = "Month", y = "UnitSales", type = "line")
  

ex_data %>%
  dimple(
    x = c("PriceTier","Channel"),
    y = "UnitSales",
    p = "UnitSales",
    groups = "Owner",
    type = "pie",
    radius = 20
  ) %>%
  add_legend()