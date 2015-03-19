# rcdimple | htmlwidget for [dimple](http://dimplejs.org)

`rcdimple` is the [`htmlwidget`](http://htmlwidgets.org) version of the dimple piece in [`rCharts`](http://rcharts.io).  The goal is beautiful, customizable `d3.js` charts straight from `R` with minimal code and no knowledge of JavaScript.  To get started, it is easy to install using `devtools::install_github`.

```
devtools::install_github("timelyportfolio/rcdimple")
```

### Lots of Examples
Then for a complete replication of the [examples in dimple](http://dimplejs.org/examples_index.html), just do a `demo`.

```
library(rcdimple)
demo(dimple)
```

For additional discussion, see the post [Week 11 | dimple as htmlwidget](www.buildingwidgets.com/blog/2015/3/18/week-11-dimple-as-htmlwidget) announcing this widget at Building Widgets.  Look for many, many more examples in the future.

### Waffle Charts with rcdimple

`rcdimple` already makes waffle charts by collaborating with [`waffle`](https://github.com/hrbrmstr/waffle).
