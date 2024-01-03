#조건에 맞는 데이터 추출하기
getwd()
setwd("D:/RStudio/data")

library(dplyr)
exam <- read.csv("D:/RStudio/data/csv_exam.csv")
exam

str(exam) #'data.frame':	20 obs. of  5 variables:

# ctrl + shift + M : %>% 기호 삽입 

exam %>% filter(class == 1)
#  id class math english science
1  1     1   50      98      50
2  2     1   60      97      60
3  3     1   45      86      78
4  4     1   30      98      58

exam %>% filter(class == 2)
exam %>% filter(class == 3)
exam %>% filter(class == 4)
exam %>% filter(class == 5)

exam %>% filter(class != 1)
exam %>% filter(class != 2)
exam %>% filter(class != 3)
exam %>% filter(class != 4)
exam %>% filter(class != 5)

# ----초과, 미만, 이상, 이하 -------

#수학 점수가 50점을 초과한 경우
exam %>% filter(math > 50)
exam %>% filter(math < 50)
exam %>% filter(math >= 50)
exam %>% filter(math <= 50)


# 여러 조건을 충족하는 행 추출하기
# 1반이면서, 수학 점수가 50점 초과인 경우
exam %>% filter(class == 1 & math > 50)

# 1반이면서, 수학 점수가 50점 미만인 경우
exam %>% filter(class == 1 & math < 50)

# 1반이면서, 수학 점수가 50점 이상인 경우
exam %>% filter(class == 1 & math >= 50)

# 1반이면서, 수학 점수가 50점 이하인 경우
exam %>% filter(class == 1 & math <= 50)


##여러 조건 중 하나 이상 충족하는 행 추출하기
# 수학 점수가 90점 초과이거나 영어 점수가 90점 이상인 경우 
exam %>% filter(math > 90 | english >= 90)

# 수학 점수가 90점 미만이거나 영어 점수가 90점 이하인 경우
exam %>% filter(math < 90 | english <= 90)

##목록에 해당되는 행 추출하기
#1,3,5반중에 하나이면 추출
exam %>% filter(class == 1 | class == 3 | class == 5)

exam %>% filter(class %in% c(1, 3, 5))

#추출한 행으로 데이터 만들기
class1 <- exam %>% filter(class == 1)
class1

mean(class1$math) # [1] 46.25
xxx <- sum(class1$math + class1$english + class1$science) # 810
mean(xxx / 3) #[1] 270

class2 <- exam %>% filter(class == 2)
mean(class2$math) #[1] 61.25
yyy <- sum(class2$math + class2$english + class2$science) # [1] 815
mean(yyy / 3) #[1] 271.6667



#mpg 데이터를 이용해 분석 문제를 해결해 보세요 .
#Q1. 자동차 배기량에 따라 고속도로 연비가 다른지 알아보려고 합니다. 
#displ(배기량)이 4이하인 자동차와 5이상인 자동차 중 어떤 자동차의 hwy(고속도로 연비)가 평균적으로 더 높은지 알아보세요.
#[hint] 특정 조건에 해당하는 데이터를 추출해서 평균을 구하면 해결할 수 있는 문제입니다. filter() 를 이용해 displ 변수가 특정 값을 지닌 행을 추출해 새로운 변수에 할당한 다음 평균을 구해보세요.

library(ggplot2)
mpg  <-  as.data.frame (mpg)

mpg  <-  as.data.frame (ggplot2::mpg)
x  <-  mpg  %>%  filter (displ  <=  4 )
y  <-  mpg  %>%  filter (displ  >=  5 )
mean (x$hwy) ## [1] 25.96319
mean (y$hwy) ## [1] 18.07895


#Q2. 자동차 제조 회사에 따라 도시 연비가 다른지 알아보려고 합니다. 
# "audi" 와 "toyota" 중 어느 manufacturer (자동차 제조 회사) 의 cty (도시 연비) 가 평균적으로 더 높은지 알아보세요.
#앞 문제와 동일한 절차로 해결하면 됩니다. 
단, 변수의 값이 숫자가 아니라 문자라는 점이 다릅니다.

View(mpg)
x_audi  <-  mpg  %>%  filter (manufacturer  ==  "audi" )
y_toyota  <-  mpg  %>%  filter (manufacturer  ==  "toyota" )
mean (x_audi$cty) ## [1] 17.61111
mean (y_toyota$cty) ## [1] 18.52941


#Q3. "chevrolet" , "ford" , "honda" 자동차의 고속도로 연비 평균을 알아보려고 합니다. 이 회사들의 자동차를 추출한 뒤 hwy 전체 평균을 구해보세요. 
#'여러 조건 중 하나 이상 충족' 하면 추출하도록 filter() 함수를 구성해 보세요. 
#'이렇게 추출한 데이터로 평균을 구하면 됩니다. 
#'%in% 를 이용하면 코드를 짧게 만들 수 있습니다.

x_new <- mpg %>%  filter(manufacturer %in%  c( "chevrolet" ,  "ford" ,  "honda" ))
mean (x_new$hwy) #[1] 22.50943


##필요한 속성(변수)만 추출하기
exam %>% select(math) #math 과목만 추출
exam %>% select(english)
exam %>% select(class, math, english)
exam %>% select(-math) # 수학만 제외하고 출력
exam %>% select(-math, -english)


#--- dplye함수 조합하기
#class가 1인행만 추출하고, 다음 english 추출
exam %>% filter(class  == 1) %>% select(english)

#class가 2인행만 추출하고, 다음 english 추출
exam %>% filter(class  == 2) %>% select(english)

#가독성 있는 출력
exam %>% 
  filter(class == 1) %>% 
  select(class, english)

#일부만 추출하기
exam %>% 
  filter(class == 1) %>% 
  select(id, math) %>% 
  head

exam %>% 
  select(id, english) %>% 
  head

exam %>% 
  select(id, science) %>% 
  head

exam %>% 
  select(id, science) %>% 
  head(10)


#mpg 데이터를 이용해서 분석 문제를 해결해보세요.
#Q1. mpg 데이터는 11 개 변수로 구성되어 있습니다. 
#이 중 일부만 추출해서 분석에 활용하려고 합니다.
#mpg데이터에서 class (자동차 종류 ), cty (도시 연비) 변수를 추출해 새로운 데이터를 만드세요. 
#새로 만든 데이터의 일부를 출력해서 두 변수로만 구성되어 있는지 확인하세요. 
#[hint]select() 로 변수를 추출해서 새로운 데이터를 만들어 보세요.

mpg <-  as.data.frame (ggplot2::mpg)
df  <-  mpg  %>%  select (class,  cty)
head (df)


#Q2. 자동차 종류에 따라 도시 연비가 다른지 알아보려고 합니다. 
#앞에서 추출한 데이터를 이용해서 class (자동차 종류) 가 "suv" 인 자동차와 "compact" 인 자동차 중 어떤 자동차의 cty (도시 연비) 가 더 높은지 알아보세요. 
#[hint] filter() 로 조건에 해당하는 데이터를 추출한 뒤 평균을 구하면 해결할 수 있습니다.

df_suv  <- df  %>%  filter (class  ==  "suv")
df_compact  <- df  %>%  filter (class  ==  "compact")
mean(df_suv$cty)     ## [1] 13.5
mean(df_compact$cty) ## [1] 20.12766


##정렬(오름차순/내림차순)

exam %>% arrange(math) #오름차순
exam %>% arrange(science)

exam %>% arrange(desc(math)) #내림차순 
exam %>% arrange(desc(science))

exam %>% arrange(class, math)
exam %>% arrange(desc(class, math)) # error : `desc()` must be called with exactly one argument.


#mpg 데이터를 이용해서 분석 문제를 해결해보세요 .
#"audi"에서 생산한 자동차 중에 어떤 자동차 모델의 hwy(고속도로 연비)가 높은지 알아보려고 합니다.
#"audi"에서 생산한 자동차 중 hwy 가 1~5 위에 해당하는 자동차의 데이터를 출력하세요.
#filter() 를 이용해 "audi" 에서 생산한 자동차만 추출하고, arrange()로 hwy 를 내림차순 정렬하면 됩니다. 
#head() 를 이용하면 이 중 특정 순위에 해당하는 자동차만 출력할 수 있습니다.

mpg  <-  as.data.frame (ggplot2::mpg)
mpg  %>%  filter (manufacturer  ==  "audi")  %>%
  arrange (desc (hwy)) %>%
  head (10)


##--- 파생변수 추가하기 --
# total이라는 합계변수 추가
exam %>% 
  mutate(total = math + english + science) %>% 
  head()

exam %>% 
  mutate(total = math + english + science,
         mean = (total / 3)) %>% 
  head()
         
exam %>% 
  mutate(test = ifelse(science >= 60, "pass", "fail")) %>% 
  head()

exam %>% 
  mutate(total = math + english + science,
         mean = (total / 3)) %>% 
  arrange(mean) %>%  #mean변수 추가 및 오름차순 정렬 
  head()
  

#mpg 데이터를 이용해서 분석 문제를 해결해보세요 .
#mpg 데이터는 연비를 나타내는 변수가 hwy (고속도로 연비), cty (도시 연비) 두 종류로 분리되어 있습니다. 
#두 변수를 각각 활용하는 대신 하나의 통합 연비 변수를 만들어 분석하려고 합니다.

#Q1. mpg 데이터 복사본을 만들고, cty 와 hwy 를 더한 ' 합산 연비 변수 ' 를 추가하세요. 
#mutate() 를 적용한 결과를 <- 를 이용해 데이터 프레임에 할당하는 형태로 코드를 작성하면 기존 데이터 프레임에 변수가 추가됩니다.

install.packages("ggplot2")
library(ggplot2)
install.packages("dplyr")
library(dplyr)

mpg  <-  as.data.frame(mpg)
mpg_new  <-  mpg
mpg_new <-  mpg_new %>% 
  mutate (total  =  cty  +  hwy)


#Q2. 앞에서 만든 ' 합산 연비 변수 ' 를 2 로 나눠 ' 평균 연비 변수 ' 를 추가세요. 
mpg_new  <-  mpg_new  %>%  
  mutate (mean  =  total/ 2)
str(mpg_new)

#Q3. ' 평균 연비 변수 ' 가 가장 높은 자동차 3 종의 데이터를 출력하세요.arrange() 와 head() 를 조합하면 됩니다.
mpg_new %>%
  arrange (desc (mean))  %>%
  head (3)


#Q4. 1~3 번 문제를 해결할 수 있는 하나로 연결된 dplyr 구문을 만들어 출력하세요. 
#데이터는 복사본 대신 mpg 원본을 이용하세요.
#앞에서 만든 코드들을  %>% 를 이용해 연결하면 됩니다. 
#변수를 추가하는 작업을 하나의 mutate() 구성하면 코드를 더 간결하게 만들 수 있습니다.

mpg %>%
  mutate (total  =  cty  +  hwy,
          mean  =  total/ 2)  %>%
  arrange (desc (mean))  %>%
  head (3)


##집단별로 요약하기
exam %>% 
  summarise(mean_math = mean(math)) # 57.45, math평균 구하기

exam %>% 
  summarise(mean_emglish = mean(english)) #  84.9, english 평균 구하기

exam %>% 
  summarise(mean_science = mean(science)) # 59.45, science평균 구하기

exam %>% 
  group_by(class) %>% 
  summarise(mean_math = mean(math)) #반별로 수학점수 구하기 
#A tibble: 5 × 2
   class mean_math
    <int>   <dbl>
1     1      46.2
2     2      61.2
3     3      45  
4     4      56.8
5     5      78  

exam %>% 
  group_by(class) %>% 
  summarise(mean_science = mean(science))
#  class mean_science
    <int>      <dbl>
1     1         61.5
2     2         58.2
3     3         39.2
4     4         55  
5     5         83.2

exam %>% 
  group_by(class) %>% 
  summarise(mean_english = mean(english))
#  class mean_english
    <int>      <dbl>
1     1         94.8
2     2         84.2
3     3         86.5
4     4         84.8
5     5         74.2


#반별로 영어 평균점수와 합계, 중앙값과 학생수 구하기
exam %>% 
  group_by(class) %>% 
  summarise(mean_english = mean(english), 
      sum_english = sum(english),
      median_english = median(english),
      n = n())

exam %>% 
  group_by(class) %>% 
  summarise(mean_math = mean(math), 
            sum_math = sum(math),
            median_math = median(math),
            n = n())

exam %>% 
  group_by(class) %>% 
  summarise(mean_science = mean(science), 
            sum_science = sum(science),
            median_science = median(science),
            n = n())

##회사별, 구동방식별로 cty평균 산출하기
mpg %>% 
  group_by(manufacturer, drv) %>% 
  summarise(mean_cty = mean(cty)) %>% 
  head(5)

# A tibble: 5 × 3
# Groups:   manufacturer [2]
manufacturer drv   mean_cty
<chr>        <chr>    <dbl>
  1 audi         4         16.8
2 audi         f         18.9
3 chevrolet    4         12.5
4 chevrolet    f         18.8
5 chevrolet    r         14.1


#회사별로 "suv" 자동차의 도시 및 고속도로 통합 연비 평균을 구하여
#내림차순으로 하고, 1-5위까지를 출력하세요.
mpg %>%
  group_by(manufacturer) %>%               # 회사별로 분리
  filter(class == "suv") %>%               # suv 추출
  mutate(total = (cty + hwy)/2) %>%        # 통합 연비 변수 생성
  summarise(mean_total = mean(total)) %>%  # 통합 연비 평균 산출
  arrange(desc(mean_total)) %>%            # 내림차순 정렬
  head(5)                                 # 1~5위까지 출력

# A tibble: 5 × 2
manufacturer mean_tot
  <chr>           <dbl>
1 subaru           21.9
2 toyota           16.3
3 nissan           15.9
4 mercury          15.6
5 jeep             15.6


#mpg 데이터를 이용해서 분석 문제를 해결해 보세요 .
#Q1. mpg 데이터의 class 는 "suv" , "compact" 등 자동차를 특징에 따라 일곱 종류로 분류한 변수입니다. 
#어떤 차종의 연비가 높은지 비교해보려고 합니다. 
#class 별 cty 평균을 구해보세요.
#[hint] group_by()를 이용해 class 별로 나눈 뒤 summarise()를 이용해 cty 평균을 구하면 됩니다.

mpg  <-  as.data.frame (ggplot2::mpg)

mpg %>%
  group_by(class)  %>%
  summarise(mean_cty  =  mean (cty))



#Q2. 앞 문제의 출력 결과는 class 값 알파벳 순으로 정렬되어 있습니다. 
#어떤 차종의 도시 연비가 높은지 쉽게 알아볼 수 있도록 cty 평균이 높은 순으로 정렬해 출력하세요.
#[hint] 앞에서 만든 코드를 %>% 로 연결하고 내림차순으로 정렬하는 코드를 추가하면 됩니다.

mpg %>%
  group_by (class)  %>%
  summarise ( mean_cty  =  mean (cty))  %>%
  arrange ( desc (mean_cty))


#Q3. 어떤 회사 자동차의 hwy ( 고속도로 연비 ) 가 가장 높은지 알아보려고 합니다. 
# hwy 평균이 가장 높은 회사 세 곳을 출력하세요.
#[hint] 2번 문제와 같은 절차로 코드를 구성하고, 일부만 출력하도록 head()를 추가하면 됩니다.

mpg %>%
  group_by(manufacturer)  %>%
  summarise(mean_hwy  =  mean (hwy))  %>%
  arrange(desc (mean_hwy))  %>%
  head(3)


#Q4. 어떤 회사에서 "compact" ( 경차 ) 차종을 가장 많이 생산하는지 알아보려고 합니다. 
#각 회사별 "compact" 차종 수를 내림차순으로 정렬해 출력하세요.
#[hint] filter() 를 이용해 "compact" 차종만 남긴 후 회사별 자동차 수를 구하면 됩니다. 
#자동차 수는 데이터가 몇 행으로 구성되는지 빈도를 구하면 알 수 있습니다. 
#빈도는 n() 을 이용해 구할 수 있습니다.

mpg %>%
  filter (class == "compact")  %>%
  group_by (manufacturer)  %>%
  summarise (count = n())  %>%
  arrange (desc(count))


###데이터 합치기
#1.가로로 합치기

#중간고사 데이터생성
test1 <- data.frame(id=c(1,2,3,4,5), midterm = c(60, 80, 70, 90, 85))
test1

#기말고사 데이터 생성
test2 <- data.frame(id=c(1,2,3,4,5), final = c(70, 83, 65, 95, 80))
test2

# id를 기준으로 가로로 합치기 성공~~
total <- left_join(test1, test2, by = "id")
total

#total
   id midterm final
1  1      60    70
2  2      80    83
3  3      70    65
4  4      90    95
5  5      85    80


#2.세로로 합치기
#중간고사 데이터생성
test3 <- data.frame(id=c(1,2,3,4,5), midterm = c(60, 80, 70, 90, 85))
test3

#기말고사 데이터 생성
test4 <- data.frame(id=c(6,7,8,9,10), midterm = c(70, 83, 65, 95, 80))
test4

# 세로로 합치기 성공~~
total <- bind_rows(test3, test4)
total

# id midterm
1   1      60
2   2      80
3   3      70
4   4      90
5   5      85
6   6      70
7   7      83
8   8      65
9   9      95
10 10      80

#다른 변수 활용하여 변수 추가하기
name <- data.frame(class = c(1,2,3,4,5),
                   teacher  = c("kim", "lee", "park", "choi", "jung"))
name

exam_new <- left_join(exam, name, by = "class")
exam_new  
  
  
#문제> 전화번호가 있는데, 서울은 02, 경기도는 031, 인천은 032번 입니다.
# 이 데이터를 데이터 프레임으로 처리하여 출력하세요.
x <- data.frame(id=c(1,2,3), tele = c("02", "031", "032"))
x

y <- data.frame(id=c(1,2,3), loc = c("서울", "경기", "인천"))
y

z <- left_join(x, y, by="id")
z


#mpg 데이터를 이용해서 분석 문제를 해결해 보세요 .
#mpg 데이터의 fl 변수는 자동차에 사용하는 연료(fuel)를 의미합니다. 
#아래는 자동차 연료별 가격을 나타낸 표입니다.
#우선 이 정보를 이용해서 연료와 가격으로 구성된 데이터 프레임을 만들어 보세요.

fuel <-  data.frame ( fl =  c ( "c" ,  "d" ,  "e" ,  "p" ,  "r" ),
                      price_fl  =  c ( 2.35 ,  2.38 ,  2.11 ,  2.76 ,  2.22 ),
                      stringsAsFactors  =  F)
fuel



#Q1. mpg 데이터에는 연료 종류를 나타낸 fl 변수는 있지만 연료 가격을 나타낸 변수는 없습니다. 
#위에서 만든 fuel 데이터를 이용해서 mpg 데이터에 price_fl(연료가격)변수를 추가하세요.
#[hint] left_join() 을 이용해서 mpg 데이터에 fuel 데이터를 합치면 됩니다. 
#두 데이터에 공통으로 들어있는 변수를 기준으로 삼아야 합니다.

install.packages("ggplot2")
library(ggplot2)
install.packages("dplyr")
library(dplyr)

mpg  <-  as.data.frame(mpg)

mpg  <-  as.data.frame (ggplot2::mpg)
mpg  <-  left_join (mpg,  fuel,  by  =  "fl" )
head(mpg)

#Q2.연료 가격 변수가 잘 추가됐는지 확인하기 위해서 model, fl, price_fl 변수를 추출해 앞부분 5행을 출력해 보세요.
#[hint] select() 와 head() 를 조합하면 됩니다.

mpg %>%
  select (model,  fl,  price_fl)  %>%
  head (5)



###############
#도전분석 !
###############

#미국 동북중부 437개 지역의 인구통계 정보를  담고 있는 midwest데이터를 사용해 데이터 분석 문제를 해결해 보세요.
# midwest는 ggplot2 패키지에 들어 있습니다.

#문제1.popadults는 해당 지역의 성인 인구, poptotal은 전체 인구를 나타냅니다. 
#midwest 데이터에 '전체 인구 대비 미성년 인구 백분율'변수를 추가하세요.

midwest <-  as.data.frame (ggplot2::midwest)
midwest <- midwest %>%
  mutate ( ratio_child  =  (poptotal-popadults)/poptotal* 100 )
head(midwest)

#문제2.미성년 인구 백분율이 가장 높은 상위 5 개 county(지역)의 미성년 인구 백분율을 출력하세요.
midwest %>%
  arrange (desc (ratio_child))  %>%
  select (county,  ratio_child)  %>%
  head (5)


#문제3.분류표의 기준에 따라 미성년 비율 등급 변수를 추가하고, 각 등급에 몇 개의 지역이 있는지 알아보세요.
midwest <- midwest %>%
  mutate ( grade  =  ifelse (ratio_child  >=  40 ,  "large" ,
                             ifelse (ratio_child  >=  30 ,  "middle" ,  "small")))
head(midwest)

#미성년 비율 등급 빈도표
table(midwest$grade)

#large middle  small 
  32    396      9 

#문제4.popasian은 해당 지역의 아시아인 인구를 나타냅니다. 
#'전체 인구 대비 아시아인 인구 백분율 '변수를 추가하고, 하위 10 개 지역의 state (주), county(지역명), 아시아인 인구 백분율을 출력하세요.
  
  midwest %>%
    mutate ( ratio_asian  =  (popasian/poptotal)* 100)  %>%
    arrange (ratio_asian)  %>%  #오름차순 정렬
    select (state,  county,  ratio_asian)  %>%
    head (10)
  
data() 

