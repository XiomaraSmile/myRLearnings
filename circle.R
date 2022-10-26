#rm(list=ls())#clear Global Environment
#setwd('D:\\circle')


#安装包
#if(!requireNamespace("BiocManager", quietly = T))
 install.packages("BiocManager", repos="https://cloud.r-project.org/", lib="myRPackages")  #首次执行需要
 BiocManager::install("ComplexHeatmap", force = TRUE, lib="myRPackages") #首次执行需要
 install.packages("circlize",  repos="https://cloud.r-project.org/", lib="myRPackages") #首次执行需要
#加载包
library(circlize, lib="myRPackages")
library(ComplexHeatmap, lib="myRPackages")

# 读取文件
df <- read.csv(file="data.csv",header=T,check.names=FALSE,row.names = 1)

circos.clear()

# 查看R所有语言数据
#library(scales)
#show_col(colors(),labels=F)


#颜色，即-4 采用blue1颜色 4 采用red1 颜色。其他数据在两个颜色之间。需要修改图形颜色可在此处改
color <- colorRamp2(c(-4,  4), c("blue1",  "yellow2"))
circos.par(gap.after = c(70))#环形剩余角度

#环形图绘制
circos.heatmap(cell.border = "white",   #cell之间边框
  split = NULL,
               df, #数据
               col = color,#颜色
               dend.side = "inside",#确定聚类结果放在圈内还是圈外
               rownames.side = "outside", 
               track.height = 0.52 #层高  
               # clustering.method = "complete",#归一化处理
               # distance.method = "euclidean"#聚类方法，默认为欧氏距离
               
)

# 标签打印
circos.track(track.index = get.current.track.index(), panel.fun = function(x, y) {
  if(CELL_META$sector.numeric.index == 1) {
    A = length(colnames(df))
    circos.text(rep(CELL_META$cell.xlim[2], A) + convert_x(2.4, "mm") - 0.5 , #x坐标
                1-(1:A)*4.0,#y坐标 值越大向量越靠下
                colnames(df), #标签
                cex = 0.5, # 标签大小。值越大字体越大
                adj = c(0.0, -32),  # 位置调整，值越大越靠右下
                facing = "inside")
  }
}, bg.border = NULL)


# 颜色条打印
lgd <- Legend(at = c(-4, 0, 4), col_fun = color, 
              title_position = "leftcenter-rot",title = "")
draw(lgd, x = unit(0.69, "npc"), y = unit(0.69, "npc"))
