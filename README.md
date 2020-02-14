# BMQianxi
获取某地图网站迁徙数据，仅作编程方法交流。<br>
<br>
## 用法
```
source("https://raw.githubusercontent.com/zhudeng94/BMQianxi/master/Qianxi.R")
# source("Qianxi.R")
cityList = read.csv("https://raw.githubusercontent.com/zhudeng94/BMQianxi/master/BM_cityCode.csv")
```
## 函数
cityID可从BM_Adcode.csv查找
```
cityRank(cityID)
# 采集每天（自2020年元旦以来）迁入/迁出该城市的各城市人口比例（每天Top100）
```
```
provinceRank(cityID)
# 采集每天（自2020年元旦以来）迁入/迁出该城市的各省份人口比例
```
```
cityMoveIndex(cityID)
# 采集每天（自2020年元旦以来）迁入/迁出该城市的迁徙规模指数
```
```
cityInternalFlow(cityID)
# 采集每天（自2020年元旦以来）该城市内出行强度
```
```
congestDistance(cityID)
# 采集自大年初一以来该城市的拥堵里程
```
## Contact
http://zhudeng.top<br>
zhudeng94@gmail.com
