## CSV 파일 읽어오기
exam <- read.csv("D:\\RStudio\\data\\csv_exam.csv")
exam
str(exam) #20 obs. of  5 variables:

head(exam) #1~6데이터 출력
head(exam, 10) # 1~10 데이터 출력

tail(exam) #20~15
tail(exam, 10)

View(exam) #데이터 뷰창에서 exam 데이터 확인
dim(exam) #[1] 20  5
str(exam)
summary(exam) #요약 통계량(기술통계)
#id            class        math          english        science     
Min.   : 1.00   Min.   :1   Min.   :20.00   Min.   :56.0   Min.   :12.00  
1st Qu.: 5.75   1st Qu.:2   1st Qu.:45.75   1st Qu.:78.0   1st Qu.:45.00  
Median :10.50   Median :3   Median :54.00   Median :86.5   Median :62.50  
Mean   :10.50   Mean   :3   Mean   :57.45   Mean   :84.9   Mean   :59.45  
3rd Qu.:15.25   3rd Qu.:4   3rd Qu.:75.75   3rd Qu.:98.0   3rd Qu.:78.00  
Max.   :20.00   Max.   :5   Max.   :90.00   Max.   :98.0   Max.   :98.00  

#ggplot2를 이용한 데이터 프레임 형태로 불러오기
install.packages("ggplot2")
mpg <- as.data.frame(ggplot2::mpg)
mpg

head(mpg)
tail(mpg)
View(mpg)
dim(mpg) #[1] 234  11
str(mpg) #'data.frame':	234 obs. of  11 variables:
## 'data.frame': 234 obs. of  11 variables:
#  $ manufacturer(제조회사): chr  "audi" "audi" "audi" "audi" ...
#  $ model(모델)       : chr  "a4" "a4" "a4" "a4" ...
#  $ displ(배기량)     : num  1.8 1.8 2 2 2.8 2.8 3.1 1.8 1.8 2 ...
#  $ year(생산연도)    : int  1999 1999 2008 2008 1999 1999 2008 1999 1999 2008 ...
#  $ cyl(실린더 개수)    : int  4 4 4 4 6 6 6 4 4 4 ...
#  $ trans(변속기 종류)  : chr  "auto(l5)" "manual(m5)" "manual(m6)" "auto(av)" ...
#  $ drv(구동 방식)      : chr  "f" "f" "f" "f" ...
#  $ cty(도시 연비)      : int  18 21 20 21 16 18 18 18 16 20 ...
#  $ hwy(고속도로 연비)  : int  29 29 31 30 26 26 27 26 25 28 ...
#  $ fl(연료 종류)       : chr  "p" "p" "p" "p" ...
#  $ class(자동차 종류)  : chr  "compact" "compact" "compact" "compact" ...


##데이터 수정하기

install.packages("dplyr")
library(dplyr)

df_raw <- data.frame(var1 = c(1,2,1), var2=c(2,3,2))
df_raw
# var1 var2
1    1    2
2    2    3
3    1    2

df_new <- df_raw # 복사본 만들기 
df_new

df_new <- rename(df_new, v2 = var2) # var2를 v2로 수정하기
df_new
# var1 v2
1    1  2
2    2  3
3    1  2

#실전연습문제 
mpg 데이터의 변수명은 긴 단어를 짧게 줄인 축약어로 되어있습니다.
cty 변수는 도시 연비, hwy 변수는 고속도로 연비를 의미합니다. 
변수명을 이해하기 쉬운 단어로 바꾸려고 합니다. 
아래 문제를 해결해 보세요.

Q1. ggploy2 패키지의 mpg 데이터를 사용할 수 있도록 불러온 뒤 복사본을 만드세요.
Q2. 복사본 데이터를 이용해서 cty는 city로, hwy는 highway로 변수명을 수정하세요.
Q3. 데이터 일부를 출력해서 변수명이 바뀌었는지 확인해 보세요. 
    아래와 같은 결과물이 출력되어야  합니다.

mpg_new <- as.data.frame(mpg)
mpg_new

mpg_new2 <- mpg_new
mpg_new2

mpg_new2 <- rename(mpg_new2, city = cty)
mpg_new2 <- rename(mpg_new2, highway = hwy)
mpg_new2

head(mpg_new2)
tail(mpg_new2)
str(mpg_new2)
View(mpg_new2)


##파생변수 만들기
df <- data.frame(var1 = c(40,30,80), var2 = c(20,60,10))
df
# var1 var2
1   40   20
2   30   60
3   80   10

df$var_sum <- df$var1 + df$var2
df
#  var1 var2 var_sum
1   40   20      60
2   30   60      90
3   80   10      90

df$var_mean <- df$var_sum / 2
df

df$var_mean <- (df$var1 + df$var2) / 2
df
#  var1 var2 var_sum var_mean
1   40   20      60       30
2   30   60      90       45
3   80   10      90       45

#mpg 통합 연비 변수 만들기
#https://rpubs.com/dododoo/415962

mpg$total <- (mpg$cty + mpg$hwy) / 2
mpg$total

mean(mpg$total) # [1] 20.14957
str(mpg)
summary(mpg$total)
#Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
10.50   15.50   20.50   20.15   23.50   39.50 

hist(mpg$total)  

#조건문을 활용하여 합격 판정 변수 만들기
# 20이상이면, pass, 아니면, fail 부여 하세요.

mpg$test <- ifelse(mpg$total >= 20, "pass", "fail")
mpg$test

head(mpg, 15)

table(mpg$test) #연비 합격 빈도표 생성하기 

#fail pass 
 106  128 
 
library(ggplot2) 
qplot(mpg$test, xlab="성공:실패", ylab="빈도수", colour="red", main="[연비합격빈도 막대 그래프]") #연비합격빈도 막대 그래프 만들기 


#total을 기준으로 연비등급 부여하기
mpg$grade <- ifelse(mpg$total >= 30, "A등급",
                    ifelse(mpg$total >= 20, "B등급", "C등급"))

head(mpg, 15)

table(mpg$grade)
#A등급 B등급 C등급 
  10    118   106 
  
qplot(mpg$grade, xlab="등급", ylab="빈도수", colour="red", main="[등급 빈도 막대 그래프]") # 등급 빈도 막대 그래프 생성  

# A, B, C, D 등급 부여
mpg$grade2 <- ifelse(mpg$total >= 30, "A",
                     ifelse(mpg$total >= 25, "B",
                            ifelse(mpg$total >= 20, "C", "D")))

mpg$grade2


## 도전 문제
#ggplot2 패키지에는 미국 동북중부 437개 지역의 인구통계 정보를 담은  midwest라는 데이터가  포함되어 있습니다. 
#midwest 데이터를 사용해 데이터 분석 문제를 해결해보세요 .
#https://ggplot2.tidyverse.org/reference/midwest.html

#문제 1. ggplot2의 midwest 데이터를 데이터 프레임 형태로 불러와서 데이터의 특성을 파악하세요.
data(midwest)

midwest <- as.data.frame(midwest)
#midwest <- as.data.frame(midwest:ggplot2)

head(midwest)
tail(midwest)
View(midwest)
dim(midwest) #[1] 437  28
str(midwest)
summary(midwest)

#문제2. poptotal(전체 인 )을 total로 , popasian(아시아 인구)을 asian으로 변수명을 수정하세요.
install.packages("dplyr")
library (dplyr)

midwest <-  rename (midwest,  total =  poptotal)
midwest <-  rename (midwest,  asian =  popasian)
midwest

#문제3.total, asian 변수를 이용해 ' 전체 인구 대비 아시아 인구 백분율 '파생변수를 만들고, 히스토그램을 만들어 도시들이 어떻게 분포하는지 살펴보세요.
midwest$ratio <- midwest$asian/midwest$total * 100
hist (midwest$ratio)

#문제4. 아시아 인구 백분율 전체 평균을 구하고, 평균을 초과하면 "large", 그 외에는 "small" 을 부여하는 파생변수를 만들어 보세요.
mean (midwest$ratio) #[1] 0.4872462
midwest$group <-  ifelse (midwest$ratio >  0.4872462 ,  "large" ,  "small" )
midwest$group

#문제5. "large" 와 "small" 에 해당하는 지역이 얼마나 되는지, 빈도표와 빈도 막대 그래프를 만들어 확인해 보세요.
table (midwest$group)
#large small 
  119   318 

qplot(midwest$group, xlab="아시아 등급별", ylab="빈도수", colour="red", main="[아시아 인구 백분율 전체 평균 그래프]") # 아시아 인구 백분율 전체 평균 막대 그래프 생성  
  
