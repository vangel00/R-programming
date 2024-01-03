#그래프 만들기
install.packages("ggplot2")
library(ggplot2)

x <- c("a", "a", "b", "c")
x

#빈도 막대 그래프 출력
qplot(x)

?help

#ggplot2의 mpg 데이터로 그래프 만들기
data(mpg) #내장되어있는 mpg dataset loading
str(mpg) # 칼럼과 데이터 갯수 확인 명령어

# https://rpubs.com/shailesh/mpg-exploration 자동차 연비 관련 내용

#data에 mpg, x축에 hwy 변수 지정하여 그래프 생성
qplot(data = mpg, x = hwy)

# x축 drv, y축 hwy
qplot(data = mpg, x = drv, y = hwy)

# x축 drv, y축 hwy, 선 그래프 형태
qplot(data = mpg, x = drv, y = hwy, geom = "line")

# x축 drv, y축 hwy, 상자 그림 형태
qplot(data = mpg, x = drv, y = hwy, geom = "boxplot")

# x축 drv, y축 hwy, 상자 그림 형태, drv별 색 표현
qplot(data = mpg, x = drv, y = hwy, geom = "boxplot", colour = drv) +  coord_flip()


#####################################
#챠트 그리기 : 영업 실적 비교하기
# 부서별 영업 실적을 챠트로 그려보자.
# 영업1팀: 9억원
# 영업2팀: 15억원
# 영업3팀: 20억원
# 영업4팀: 6억원 
#####################################
install.packages("graphics")
library(graphics)

x <- c(9, 15, 20, 6)
x

label <- c("영업1팀", "영업2팀", "영업3팀", "영업4팀")
label

#단순 파이 챠트 
pie(x, labels = label, main = "부서별 영업 실적")

#단순 파이 챠트2, init.angle 각도 조정 
pie(x, init.angle = 180, labels = label, main = "부서별 영업 실적")

#문제> 부서별 파이 챠트를 %를 넣어서 출력하세요.
pect <- round(x / sum(x)*100)
label <- paste(label, pect, "%")
pie(x, labels = label, init.angle = 90, main = "부서별 영업 실적")

#3D 파이 챠트
install.packages("plotrix") 
library(plotrix)

# Simple Pie Chart
slices <- c(10, 12, 4, 16, 8)
lbls <- c("US", "UK", "Australia", "Germany", "France")
pie(slices, labels = lbls, main="Pie Chart of Countries")

# explode: 부채모양의 간격지정
# labelcex: 라벨 문자의 크기 지정(0.81배로 축소)
pie3D(x, labels = label, explode = 0.3, labelcex = 0.8, main="부서별 영업 실적")

# Pie Chart with Percentages
slices <- c(10, 12, 4, 16, 8) 
lbls <- c("US", "UK", "Australia", "Germany", "France")
pct <- round(slices/sum(slices)*100)
lbls <- paste(lbls, pct) # add percents to labels 
lbls <- paste(lbls,"%",sep="") # ad % to labels 
pie(slices,labels = lbls, col=rainbow(length(lbls)),
    main="Pie Chart of Countries")

# bar chart
bar_x <- c(9, 15, 20, 6, 35)
bar_x

label <- c("영업1팀", "영업2팀", "영업3팀", "영업4팀", "영업5팀")
label

barplot(bar_x, names = label, col="red", main="부서별 영업 실적")

barplot(bar_x, names = label, col=rainbow(length(x)), main="부서별 영업 실적")
 
barplot(bar_x, names = label, col=rainbow(length(bar_x)), xlab="부서", ylab="영업실적(억원)", main="부서별 영업 실적")

barplot(bar_x, names = label, col=rainbow(length(bar_x)), xlab="부서", ylab="영업실적(억원)", ylim=c(0, 50), main="부서별 영업 실적")

bp <- barplot(bar_x, names = label, col=rainbow(length(bar_x)), xlab="부서", ylab="영업실적(억원)", ylim=c(0, 50), main="부서별 영업 실적")
text(x=bp, y=bar_x, labels=round(bar_x, 0), pos=3)
plot.new() # 막대 그래프 지우기 

#이미지 저장
setwd("D:\\RStudio")
# savePlot('barplot.png', type='png') : windows에서는 복사만 가능합니다.


#바 챠트의 수평 회전(가로 막대) 그리기
barplot(bar_x, names = label, col=rainbow(length(bar_x)), xlab="영업실적(억원)", ylab="부서", xlim=c(0, 50), horiz = TRUE, width=50, main="부서별 영업 실적")
text(x=bar_x, y=bp, labels=round(bar_x, 0), pos=2)
plot.new() # 막대 그래프 지우기 


#Stacked bar chart(세로 막대형태)
height1 <- c(4, 18, 5, 8)
height2 <- c(9, 15, 20, 6)
height3 <- c(6, 25, 15, 3)
height <- rbind(height1, height2, height3)
height

name <- c("영업1팀", "영업2팀", "영업3팀", "영업4팀")
name

label <- c("2020", "2021", "2022")
label

barplot(height, names = name, col=rainbow(length(height)), xlab="부서", ylab="영업실적(억원)", ylim=c(0, 70), legend.text = label, main="부서별 영업 실적")

barplot(height, names = name, col=c("skyblue", "pink", "red"), xlab="부서", ylab="영업실적(억원)", ylim=c(0, 70), legend.text = label, main="부서별 영업 실적")
   

#Grouped bar Chart(가로막대형태)
# beside=TRUE : TRUE를 지정하면 각각의 값마다 막대를 그림 
# args.legend=list(x='topright'): 범례 표시
barplot(height, names = name, col=rainbow(length(height)), xlab="영업실적(억원)", ylab="부서", xlim=c(0, 40), legend.text = label, beside = TRUE, horiz = TRUE, args.legend=list(x='topright'), main="부서별 영업 실적")


#내장된 women 데이터를 이용하여 그래프로 표시해 봅니다.
data(women)
str(women) # data.frame':	15 obs. of  2 variables:
women

weight <- women$weight
plot(weight)

height <- women$height
height
plot(height)

plot(height, weight, xlab = "키", ylab = "몸무게")

# https://blog.naver.com/1stwook/220670083505 :  type 참조 
# 점이나 문자를 그릴 때 점이나 문자의 굵기를 지정: cex
# 점의 모양을 지정합니다 : pch
plot(height, weight,  xlab = "키", ylab = "몸무게", col="red", bg="yellow", type="o", cex=2, pch=6)

# R에 내장된 데이터세트 읽기
#데이터세트 목록보기 
library(help=datasets)




