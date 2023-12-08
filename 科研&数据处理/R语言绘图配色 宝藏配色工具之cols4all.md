各位小伙伴，在使用R的主流配色包绘图时，是不是通常会面临一个问题：在选择特定的调色板之前，很难直观地看到所选调色板的颜色组合。通常情况下，可能需要查看R包的官网文档，或者逐个尝试各种选项，以找到最符合我们预期的效果，这往往会降低工作效率。

**cols4all**通过添加了图形用户界面 **(GUI)页面**，完美解决了上述不便之处。同时，cols4all集成了各大主流调色包，如Color Brewer、Viridis、Kovesi、Paul Tol、Scico、Carto、Tableau、Wes Anderson和Seaborn的热门调色板，涵盖了离散和渐变的各种配色方案，使您可以轻松选择适合您需求的颜色组合。

**一、cols4all包安装、加载及展示**

```R
install.packages("cols4all", dependencies = TRUE)  
# 或者  
install.packages("remotes")  
remotes::install_github("mtennekes/cols4all", dependencies = TRUE)  
library(cols4all)
```
这个包的精华就是这个**GUI页面**，**一句代码**，让我们可以直观浏览所有色板
```R
c4a_gui()
```
在RSudio中会弹出**交互面板**，或者点击**Open in Browser**，可以在浏览器窗口打开该页面进行直观显示。

下面色板的列名含义如下：
 * Series：该配色来自哪个配色包
 * Name：该配色的名称
 * Max number：最大配色数量
 * Colorblind-friendly：是否对色盲友好
 * Intense colors：是否为强烈的色彩组合
 * Harmonic palette：是否为和谐的色彩组合
 * Ranking：根据上述三点进行评分并排序（针对当前类型色板和颜色数）

我们以默认的Number of colors为7展示一下各个部分：  
### **1. Categorical(分类/离散型色板)：**
![[Pasted image 20231203003002.png]]


### **2. Sequential(渐变/顺序型色板)：**

![[Pasted image 20231203003014.png]]

### **3. Diverging(渐变/发散型色板)：**
![[Pasted image 20231203003051.png]]

### **4. Bivariate(多变量型色板)：**

分为四个子类: seq xseq、seq x cat、seq x desaturated和seq x diverging
![[Pasted image 20231203003108.png]]

不管你是什么类型的数据，需要绘制什么样的图表，在这里都能够选择到合适配色！并且结合色盲、强烈色和和谐色的标注方式也能让用户在使用时更便于挑选。使用这个包等于同时在交互式页面自由挑选各大R包的流行配色，同时省去了所有代码。

## **二、配色包cols4all使用**

#### 提取颜色更加简单，一句函数解决！

```R
#通过函数提取配色(色板名称+所需颜色数量)：  
mycol<-c4a("classic20", 15)  
mycol  
#[1] "#1F77B4" "#AEC7E8" "#FF7F0E" "#FFBB78" "#2CA02C" "#98DF8A" "#D62728" "#FF9896" "#9467BD" "#C5B0D5" "#8C564B" "#C49C94"  
#[13] "#E377C2" "#F7B6D2" "#7F7F7F"
```

会显示提取色板对应颜色数的十六进制颜色码，可以在绘图中直接拎出这句函数使用，或者创建一个自定义颜色向量组。
#### 下面结合一个简单的箱线图小案例实操下：

```R
library(ggplot2)  
library(ggpubr)  
  
# 载入内置数据集测试：  
# 简单绘制一个箱线图：  
ggboxplot(data = mpg[1:132,],  
x = 'manufacturer', y = 'hwy', fill = 'manufacturer')
```

![[Pasted image 20231203003256.png]]
#### 更换配色：
```R
mycol <- c4a('classic20',8)  
ggboxplot(data = mpg[1:132,],  
x = 'manufacturer', y = 'hwy', fill = 'manufacturer',  
palette = mycol, alpha = 0.7
```
![[Pasted image 20231203003554.png]]

```R
mycol <- c4a('light',8)  
ggboxplot(data = mpg[1:132,],  
x = 'manufacturer', y = 'hwy', fill = 'manufacturer',  
palette = mycol, alpha = 0.8)
```

![[Pasted image 20231203003711.png]]

#### 更换配色：

```R
mycol <- c4a('20',15)[c(2,3,4,5,6,10,11,12)]
ggboxplot(data = mpg[1:132,],
x = 'manufacturer', y = 'hwy', fill = 'manufacturer',
palette = mycol, alpha = 0.8)
```

#### 更换连续性配色：

1mycol <- c4a('paired',8)  
2ggboxplot(data = mpg[1:132,],  
3x = 'manufacturer', y = 'hwy', fill = 'manufacturer',  
4palette = mycol, alpha = 0.5)
axsx
|||