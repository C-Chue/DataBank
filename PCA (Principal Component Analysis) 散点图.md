PCA (Principal Component Analysis) 散点图，是科研文章中常见的一类散点图。闲言少叙，下面就以PCA散点图为例，为大家介绍如何使用ggplot2绘制好看的散点图。

本文重点介绍如何使用ggh4x包辅助ggplot2实现更多的个性化调整，比如为坐标轴添加小刻度、更改坐标轴线的长度等。

```R
#读入数据；  
dt <- read.csv("PCA_data.csv")  
#预览读入数据；  
head(dt)
```

![[Pasted image 20231203114430.png]]

```R
#载入ggplot2绘图包；  
library(ggplot2)  
#安装ggh4x包；  
install.packages("ggh4x")  
library(ggh4x)  
  
#绘制散点图；  
p1 <- ggplot(dt,aes(x=PC1,y=PC2,color=Diagnosis))+  
  geom_point(size=1.5)  
#预览初始绘图效果；  
p1
```

![[Pasted image 20231203114619.png]]

```R
#自定义分组颜色、透明度（对应色号的后两位）、图例标题；  
p2 <- p1+scale_color_manual(name="",  
                            values = c("#e26fffbb","#8e9cffbb"))  
#预览绘图效果；  
p2
```

![[Pasted image 20231203114830.png]]

```R
#自定义坐标轴范围和刻度；  
#通过guide = "axis_minor"添加小刻度；  
p3 <- p2+scale_x_continuous(position = "bottom",  
                            guide = "axis_minor",  
                   expand=expansion(add = c(0.7,0)),  
                   limits=c(-10,5),  
                   breaks = c(-10,-5,0, 5),  
                   label = c("-10","-5", "0", "5"))+  
  scale_y_continuous(position = "left",  
                     guide = "axis_minor",  
                     expand=expansion(add = c(0.5,0)),  
                     limits=c(-7.5,5),  
                     breaks = c(-7.5,-5,-2.5,0,2.5,5),  
                     label = c("-7.5","-5", "-2.5", "0","2.5","5"))  
  
p3
```

![[Pasted image 20231203114857.png]]

```R
#自定义主题；  
#包括添加小刻度、自定义刻度长短等；  
mytheme <- theme(panel.grid = element_blank(),  
                 panel.background = element_blank(),  
                 legend.key = element_blank(),  
                 legend.position = "top",  
                 axis.line = element_line(colour = "grey30"),  
                 axis.ticks.length = unit(1.8, "mm"),  
                 ggh4x.axis.ticks.length.minor = rel(0.6))  
p4 <- p3+mytheme  
p4
```

![[Pasted image 20231203114925.png]]


```R
#调整坐标轴的样式，调整坐标轴线的长度；  
#比较遗憾的是当前版本无法保留小刻度,与guides(x = "axis_minor", y = "axis_minor")冲突；  
#自定义图例分组图形（点）的大小；  
p5 <- p4+guides(x = guide_axis_truncated(trunc_lower = -10,  
                                         trunc_upper = 5),  
                y = guide_axis_truncated(trunc_lower = -7.5,  
                                         trunc_upper = 5),  
                color = guide_legend(override.aes = list(size=4)))  
  
p5
```

![[Pasted image 20231203115015.png]]

```R
#综上技巧，尝试添加质心线；  
p6 <- ggplot(dt,aes(x=PC1,y=PC2,color=Diagnosis))+  
  stat_centroid(aes(xend = PC1, yend = PC2, colour = Diagnosis),  
                geom = "segment", crop_other = F,  
                alpha=0.3,size = 1,show.legend = F)+  
  geom_point(size=2,stroke=1,alpha=1,  
             fill="white",shape = 21,show.legend = T)+  
  scale_color_manual(name="",  
                     values = c("#e26fff","#8e9cff"))+  
  scale_x_continuous(expand=expansion(add = c(0.7,0.7)),  
                     limits=c(-10,5))+  
  scale_y_continuous(expand=expansion(add = c(0.5,0.5)),  
                     limits=c(-7.5,5))+  
  guides(x = "axis_truncated",y = "axis_truncated")+mytheme  
  
p6
```
![[Pasted image 20231203115106.png]]


