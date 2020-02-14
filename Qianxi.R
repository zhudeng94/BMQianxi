### http://zhudeng.top
### zhudeng@gmail.com

library(jsonlite)
library(RCurl)

# tmp = cityRank(184)
# tmp = provinceRank(184)
# tmp = cityMoveIndex(184)
# tmp = cityInternalFlow(184)
# tmp = congestDistance(184)

### 全国各地迁入/迁出城市人口比例（每天Top100）
cityRank = function(cityID) {
  all = c()
  cityCodes <- read.csv("https://raw.githubusercontent.com/zhudeng94/BMQianxi/master/BM_cityCode.csv")
  today = format(Sys.Date(), format="%Y%m%d")
  period <- format(seq(as.Date("2020/01/01"), as.Date(Sys.Date()-1), "day"), format="%Y%m%d")
  moveTypes <- c("move_in", "move_out")
  cityName = cityCodes$Name[which(cityCodes$cityCode==cityID)]
  cityCode = cityCodes$adcode[which(cityCodes$cityCode==cityID)]
  print(paste("=======开始采集迁入/迁出", cityName, "的各城市人口比例（每天Top100）=========="), sep = "")
  if (cityCode=="0") { dt = "country" } else { dt = "city" }
  for (move_type in moveTypes) {
    for (date in period) {
      url <- paste("https://huiyan.baidu.com/migration/cityrank.json?dt=", dt, "&id=", cityCode, "&type=", move_type, "&date=", date, sep = "")
      json <- fromJSON(url)$data$list
      if (length(json)) {
        json <- cbind(cityName, date, move_type, json)
        all <- rbind(all, json)
        print(paste(cityName, ", ", date, ", ", move_type, sep = ""))
      } else {
        print("无数据")
      }
    }
  }
  print(paste("=======完成采集迁入/迁出", cityName, "的各城市人口比例（每天Top100）=========="), sep = "")
  return(all)
}

### 全国各地热门迁入/迁出省份人口比例
provinceRank = function(cityCode) {
  all = c()
  cityCodes <- read.csv("https://raw.githubusercontent.com/zhudeng94/BMQianxi/master/BM_cityCode.csv")
  today = format(Sys.Date(), format="%Y%m%d")
  period <- format(seq(as.Date("2020/01/01"), as.Date(Sys.Date()), "day"), format="%Y%m%d")
  moveTypes <- c("move_in", "move_out")
  cityName = cityCodes$Name[which(cityCodes$cityCode==cityID)]
  cityCode = cityCodes$adcode[which(cityCodes$cityCode==cityID)]
  print(paste("=======开始采集迁入/迁出", cityName, "的各省份人口比例=========="), sep = "")
  if (cityCode=="0") { dt = "country" } else { dt = "city" }
  for (move_type in moveTypes) {
    for (date in period) {
      url <- paste("https://huiyan.baidu.com/migration/provincerank.json?dt=", dt, "&id=", cityCode, "&type=", move_type, "&date=", date, sep = "")
      json <- fromJSON(url)$data$list
      if (length(json)) {
        json <- cbind(cityName, date, move_type, json)
        all <- rbind(all, json)
        print(paste(cityName, ", ", date, ", ", move_type, sep = ""))
      } else {
        print("无数据")
      }
    }
  }
  print(paste("=======完成采集迁入/迁出", cityName, "的各省份人口比例=========="), sep = "")
  return(all)
}

### 各地迁徙规模指数
cityMoveIndex = function(cityCode) {
  all = c()
  cityCodes <- read.csv("https://raw.githubusercontent.com/zhudeng94/BMQianxi/master/BM_cityCode.csv")
  today = format(Sys.Date(), format="%Y%m%d")
  period <- format(seq(as.Date("2020/01/01"), as.Date(Sys.Date()), "day"), format="%Y%m%d")
  moveTypes <- c("move_in", "move_out")
  cityName = cityCodes$Name[which(cityCodes$cityCode==cityID)]
  cityCode = cityCodes$adcode[which(cityCodes$cityCode==cityID)]
  print(paste("=======开始采集", cityName, "的迁徙指数=========="), sep = "")
  if (cityCode=="0") { dt = "country" } else { dt = "city" }
  for (move_type in moveTypes) {
    url <- paste("https://huiyan.baidu.com/migration/historycurve.json?dt=", dt, "&id=", cityCode, "&type=", move_type, sep = "")
    json <- as.data.frame(fromJSON(url)$data$list)
    if (length(json)) {
      json <- cbind(cityName, move_type, json[order(names(json))])
      all <- rbind(all, json)
    } else {
      print("无数据")
    }
  }
  print(paste("=======完成采集", cityName, "的迁徙指数=========="), sep = "")
  return(all)
}

### 各地城内出行强度
cityInternalFlow = function(cityCode) {
  all = c()
  cityCodes <- read.csv("https://raw.githubusercontent.com/zhudeng94/BMQianxi/master/BM_cityCode.csv")
  today = format(Sys.Date(), format="%Y%m%d")
  period <- format(seq(as.Date("2020/01/01"), as.Date(Sys.Date()), "day"), format="%Y%m%d")
  moveTypes <- c("move_in", "move_out")
  cityName = cityCodes$Name[which(cityCodes$cityCode==cityID)]
  cityCode = cityCodes$adcode[which(cityCodes$cityCode==cityID)]
  print(paste("=======开始采集", cityName, "的城市内出行强度=========="), sep = "")
  if (cityCode=="0") { dt = "country" } else { dt = "city" }
  url <- paste("https://huiyan.baidu.com/migration/internalflowhistory.json?dt=", dt, "&id=", cityCode, "&date=", today, sep = "")
  json <- as.data.frame(fromJSON(url)$data$list)
  if (length(json)) {
    json <- cbind(cityName, json[order(names(json))])
    all <- rbind(all, json)
    print(paste(cityName, "已采集", sep = ""))
  } else {
    print("无数据")
  }
  print(paste("=======完成采集", cityName, "的城市内出行强度=========="), sep = "")
  return(all)
}

### 全国各地拥堵里程
congestDistance = function(cityCode) {
  all = c()
  cityCodes <- read.csv("https://raw.githubusercontent.com/zhudeng94/BMQianxi/master/BM_cityCode.csv")
  today = format(Sys.Date(), format="%Y%m%d")
  period <- format(seq(as.Date("2020/01/01"), as.Date(Sys.Date()), "day"), format="%Y%m%d")
  moveTypes <- c("move_in", "move_out")
  cityName = cityCodes$Name[which(cityCodes$cityCode==cityID)]
  cityCode = cityCodes$areaCode[which(cityCodes$cityCode==cityID)]
  print(paste("=======开始采集", cityName, "每半小时拥堵里程=========="), sep = "")
  for (type in c(0, 1)) { 
    url <- paste("https://jiaotong.baidu.com/trafficindex/dashboard/historycurve?areaCode=", cityCode, "&type=", type, sep = "")
    json <- fromJSON(url)$data$curve
    if (length(json)) {
      json <- cbind(cityName, json)
      all <- rbind(all, json)
    } else {
      print("无数据")
    }
  }
  print(paste("=======完成采集", cityName, "每半小时拥堵里程=========="), sep = "")
  return(all)
}
