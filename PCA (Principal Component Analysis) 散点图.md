PCA (Principal Component Analysis) 散点图，是科研文章中常见的一类散点图。闲言少叙，下面就以PCA散点图为例，为大家介绍如何使用ggplot2绘制好看的散点图。

本文重点介绍如何使用ggh4x包辅助ggplot2实现更多的个性化调整，比如为坐标轴添加小刻度、更改坐标轴线的长度等。

```R
#读入数据；  
dt <- read.csv("PCA_data.csv")  
#预览读入数据；  
head(dt)
```

