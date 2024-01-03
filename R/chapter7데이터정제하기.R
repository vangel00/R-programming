# 결측치?
# -누락된 값, 비어 있는 값
# - 함수 적용 불가 경우
# - 분석 결과 왜곡을 초래할 여지가 있는 경우에
# - 반드시 제거한 후 분석을 실시 합니다.(신뢰도 문제)

#1.결측치 찾기
df <- data.frame(sex = c("M", "F", NA, "M", "F"), 
                 score = c(50, 40, 30, 40, NA))
df

is.na(df) #결측치 확인
table(is.na(df)) # 결측치 빈도 출력
table(is.na(df$sex)) # sex 결측치 빈도 출력
table (is.na(df$score)) # score 결측치 빈도 출력

mean(df$sex) # 평균 산출
[1] NA
경고메시지(들): 
  mean.default(df$sex)에서:
  인자가 수치형 또는 논리형이 아니므로 NA를 반환합니다


mean(df$score)
# NA


#2.결측치 제거하기
library(dplyr)

df %>% 
  filter(is.na(score))  # NA인 경우 데이터만 출력
#  sex score
1   F    NA  

df %>% 
  filter(is.na(sex)) # NA인 경우 데이터만 출력
# sex score
1 <NA>    30

df %>% 
  filter(!is.na(sex)) #sex에 대한 결측치 제거
#  sex score
1   M    50
2   F    40
3   M    40
4   F    NA

df %>% 
  filter(!is.na(score)) ##sex에 대한 결측치 제거
# sex score
1    M    50
2    F    40
3 <NA>    30
4    M    40

#3.결측치 제거한 후 변수에 임의의 변수에 저장
df_nosex <- df %>% 
  filter(!is.na(sex))
df_nosex

df_noscore <- df %>% 
  filter(!is.na(score))
df_noscore

sum(df_noscore$score) #[1] 160
mean(df_noscore$score) # 40

#둘다 결측치 제거인 경우에 
df_nomiss <- df %>% filter(!is.na(score) & !is.na(sex))  # score, sex 결측치 제거
df_nomiss     

#4.함수의 결측치 제외 기능 이용하기
sum(df$score, na.rm  = T) # 160
mean(df$score, na.rm = T) # 40

#5.데이터 불러오기
library(dplyr)
exam <- read.csv("D:/RStudio/data/csv_exam.csv")
exam

getwd()
setwd("D:/RStudio/")

exam[c(3, 8, 15), "math"] <- NA # # 3, 8, 15행의 math에 NA 할당
exam

exam %>% 
  summarise(mean_math = mean(math)) # NA로 인하여 연산 불가 상태.
#  mean_math
1        NA

exam %>% 
  summarise(mean_math = mean(math, na.rm = T)) # NA 제거후에 평균값 연산후 출력
#mean_math
1  55.23529

exam %>% 
  summarise(mean_math = mean(math, na.rm = T), # NA 제거후에 평균값
            sum_math = sum(math, na.rm = T),  # NA 제거후에 합계 
            median_math = median(math, na.rm = T)) # NA 제거후에 중앙값
# mean_math sum_math median_math
1  55.23529      939          50

#6.평균값으로 결측치 대체하기
# - 결측치가 많은 경우에 모두 제거하면 데이터 손실이 크므로 신뢰도가 낮아짐.
# - 대안책: 다른 값으로 채워넣기
# 대체법: 대표값(평균값, 최빈값 등)으로 일괄 대체 가능
# 통계분석 기법을 적용하여 예측값을 추정해서 대체

mean(exam$math, na.rm = T) #[1] 55.23529

exam$math <- ifelse(is.na(exam$math), 55, exam$math) # 55점으로 대체
exam$math
#[1] 50 60 55 30 25 50 80 55 20 50 65 45 46 48 55 58 65 80 89 78

table(is.na(exam$math)) #FALSE 20

mean(exam$math) # 55.2

###########
#mpg 데이터를 이용해서 분석 문제를 해결해 보세요.
#mpg  데이터  원본에는결측치가  없습니다.우선 mpg  데이터를  불러와  몇  개의  값을  결측치로  만들겠습니다. 
#아래 코드를 실행하면 다섯 행의 hwy 변수에 NA 가 할당됩니다.

mpg  <-  as.data.frame (ggplot2::mpg)
mpg[ c ( 65 ,  124 ,  131 ,  153 ,  212 ),  "hwy" ]  <-  NA


#Q1. drv (구동방식) 별로 hwy(고속도로 연비) 평균이 어떻게 다른지 알아보려고 합니다. 
#분석을 하기 전에 우선 두 변수에 결측치가 있는지 확인해야 합니다. 
#drv 변수와 hwy 변수에 결측치가 몇 개 있는지 알아보세요. 
#[hint : 빈도표를 만드는 table() 과 결측치를 확인하는 is.na() 를 조합해 보세요.]

table ( is.na (mpg$drv))
table ( is.na (mpg$hwy))


#Q2. filter() 를 이용해 hwy 변수의 결측치를 제외하고, 어떤 구동방식의 hwy 평균이 높은지 알아보세요. 
#하나의 dplyr 구문으로 만들어야 합니다. 
#[hint: filter() 와 is.na()]를 조합해 결측치를 제외하고, 
#집단별 평균을 구하는 코드를 %>% 로 연결하면 됩니다.
mpg %>%
  filter (! is.na (hwy))  %>%
  group_by (drv)  %>%
  summarise ( mean_hwy  =  mean (hwy))


##이상치(Outlier) - 정상범주에서 크게 벗어난 값
#이상치 포함시 분석 결과 왜곡
#결측 처리 후 제외하고 분석

#  이상치               종류             해결방법
#-------------------------------------------------------------
#존재할수없는값   :  성별 변수에 3    : 결측 처리
#극단적인값       : 몸무게 변수에 200 : 정상범위 기준 정해서 결측 처리

#1.이상치 제거하기(존재할 수 없는 값)

outlier <- data.frame(sex = c(1,2,1,3,2,1),
                      score = c(50, 40, 30, 40, 20, 60))
outlier

table(outlier$sex) #이상치 확인하기
#1 2 3 
 3 2 1 

table(outlier$score)
#20 30 40 50 60 
 1  1  2  1  1 

#sex가 3이면 NA 할당
outlier$sex <- ifelse(outlier$sex == 3, NA, outlier$sex)
outlier
# sex score
1   1    50
2   2    40
3   1    30
4  NA    40
5   2    20
6   1    60

#score가 50보다 크면, NA 할당
outlier$score <- ifelse(outlier$score > 50, NA, outlier$score)
outlier
#  sex score
1   1    50
2   2    40
3   1    30
4   3    40
5   2    20
6   1    NA

#2.결측치를 제외하고 평균 계산하기
outlier %>% 
  filter(!is.na(sex) & !is.na(score)) %>% 
  summarise(mean_score = mean(score))
#  mean_score
 1   36
 
 outlier %>% 
   filter(!is.na(sex) & !is.na(score)) %>% 
   group_by(sex) %>% 
   summarise(mean_score = mean(score))
# sex mean_score
     <dbl>      <dbl>
 1     1         40
 2     2         30
 3     3         40 
 
#3.이상치 제거하기(극단적인값) 
mpg <- as.data.frame(ggplot2::mpg) 
mpg 

str(mpg) #data.frame':	234 obs. of  11 variables:

boxplot(mpg$hwy)

#상자그림 통계치 출력
boxplot(mpg$hwy)$stats
#     [,1]
[1,]   12
[2,]   18
[3,]   24
[4,]   27
[5,]   37

#12~37 데이터를 벗어나면 NA 할당
mpg$hwy <- ifelse(mpg$hwy < 12 | mpg$hwy > 37, NA, mpg$hwy)
mpg$hwy

#결측지 확인
table(is.na(mpg$hwy))
FALSE  TRUE 
 231     3 

#결측치 제거하고 평균 구하기
mpg %>% 
  group_by(drv) %>% 
  summarise(mean_hwy  = mean(hwy, na.rm = T))
drv   mean_hwy
  <chr>    <dbl>
1   4      19.2
2   f      27.7
3   r      21  


#mpg 데이터를 이용해서 분석 문제를 해결해 보세요.
#우선 mpg   데이터를 불러와서 일부러 이상치를  만들겠습니다. 
#drv(구동방식)   변수의 값은 4(사륜구동), f(전륜구동),  r(후륜구동)세 종류로  되어있습니다. 
#몇 개의 행에 존재할 수 없는 값 k를 할당하겠습니다. 
#cty(도시 연비)변수도 몇 개의 행에 극단적으로 크거나 작은 값을 할당하겠습니다 .

mpg  <-  as.data.frame (ggplot2::mpg)
mpg[ c ( 10 ,  14 ,  58 ,  93 ),  "drv" ]  <-  "k"
mpg[ c ( 29 ,  43 ,  129 ,  203 ),  "cty" ]  <-  c ( 3 ,  4 ,  39 ,  42 )

#이상치가 들어있는 mpg 데이터를 활용해서 문제를 해결해보세요. 
#구동방식별로 도시 연비가 다른지 알아보려고 합니다. 
#분석을  하려면 우선 두 변수에 이상치가 있는지 확인하려고 합니다 .

#Q1. drv 에 이상치가 있는지 확인하세요. 이상치를 결측 처리한 다음 이상치가 사라졌는지 확인하세요. 
#결측처리 할 때는 %in% 기호를 활용하세요.
# [hint]drv가 정상적인 값이면 원래 값을 유지하고, 그렇지 않으면 NA를 부여하는코드를  작성하면  됩니다. 
# 정상적인 값이 여러 개 있으니 %in% 와 c() 를 조합해 코드를 간결하게 만들어 보세요.

table (mpg$drv) #  이상치 확인
# drv 가  4, f, r 이면 기존 값 유지 ,  그 외  NA 할당
mpg$drv  <-  ifelse (mpg$drv  %in%  c ( "4" ,  "f" ,  "r" ),  mpg$drv,  NA )
table (mpg$drv)


#Q2. 상자 그림을 이용해서 cty 에 이상치가 있는지 확인하세요. 
#상자 그림의 통계치를 이용해 정상 범위를 벗어난 값을 결측 처리한 후 다시 상자 그림을 만들어 이상치가 사라졌는지 확인하세요.
#[hint]상자  그림을  만들  때  사용하는  다섯  가지  통계치를  출력해  정상  범위의  기준을  찾으세요. 
#그런 다음 filter()를 이용해 cty 가 이 범위를 벗어날 경우 NA 를 부여하면 이상치가 결측 처리 됩니다 .

boxplot (mpg$cty)$stats #상자 그림 생성 및 통계치 산출
# 9~26  벗어나면  NA  할당
mpg$cty <- ifelse(mpg$cty  <  9 | mpg$cty > 26, NA, mpg$cty)
boxplot (mpg$cty) #상자 그림 생성


#Q3. 두 변수의 이상치를 결측처리 했으니 이제 분석할 차례입니다. 
#이상치를 제외한 다음 drv 별로 cty 평균이 어떻게 다른지 알아보세요. 
#하나의 dplyr 구문으로 만들어야 합니다.
# [hint] filter() 를 이용해 drv 와 cty 가 모두 결측치가 아닌 데이터를 추출한 후 집단별 평균을 구하면 됩니다 .
mpg %>%
  filter (!is.na(drv) & !is.na(cty))%>%
  group_by(drv)%>%
  summarise(mean_hwy = mean(cty))

