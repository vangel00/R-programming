##산점도(Scater Plot) 
# - 데이터를 x축과 y축에 점으로 표현한 그래프
# - 나이와 소득처럼, 연속 값으로 된 두 변수의 관계를 표현할 때 사용

install.packages("ggpolt2")
library(ggplot2)

str(mpg)
View(mpg)
#패키지에는 다양한 함수 기능 뿐만 아니라 이 기능을 테스트 할 수 있는 예제 데이터가 들어 있는데요,
#이 mpg 데이터는 ggplot2 패키지에 들어 있는 예제 데이터 입니다!
# mpg(Mile Per Gallon) 데이터는 미국 환경 보호국(US Environmental Protection Agency)에서 공개한 
#자료로, 1999~2008년 사이 미국에서 출시된 자동차 234종의 연비 관련 정보를 담고 있습니다.
# manufacturer model: 자동차 제조사
# displ : 배기량
# yeal : 제조년도
# cyl : 실린더 수
# trans : 변속기
# drv : 구동 방식(f = 전륜구동, r = 후륜구동, 4 = 사륜구동)
# city : 도시 연비
# hwy : 고속도로 연비
# fl : 연료 종류
# class : 자동차 종류

#1. x축 displ, y축 hwy로 지정해 배경 생성
ggplot(data = mpg, aes(x = displ, y = hwy))

#2. 배경에 산점도 추가
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point()

#3. x축 범위 1~7으로 지정
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point() + xlim(1, 7)

#4. x축 범위 1~7, y축 범위 10~40으로 지정
ggplot(data = mpg, aes(x = displ, y = hwy)) + 
  geom_point() + 
  xlim(1, 7) + 
  ylim(10, 40)

#ggplot() vs qplot()
#qplot() : 전처리 단계 데이터 확인용 문법 간단, 기능 단순
#ggplot() : 최종 보고용. 색, 크기, 폰트 등 세부 조작 가능


#mpg 데이터와 midwest 데이터를 이용해서 분석 문제를 해결해 보세요 .
#Q1. mpg 데이터의 cty(도시 연비)와 hwy(고속도로 연비)간에 어떤 관계가 있는지 알아보려고 합니다. 
#[hint] x 축은 cty , y 축은 hwy 로 된 산점도를 만들어 보세요.
#geom_point() 를 이용해 산점도를 만들어 보세요.

ggplot (data =  mpg,  aes (x =  cty,  y =  hwy)) +  geom_point ()



#Q2. 미국 지역별 인구통계 정보를 담은 ggplot2 패키지의 midwest 데이터를 이용해서 전체 인구와 아시아인 인구 간에 어떤 관계가 있는지 알아보려고 합니다 . x 축은 poptotal ( 전체 인구 ), y 축은 popasian ( 아시아인 인구 ) 으로 된 산점도를 만들어 보세요 . 전체 인구는 50 만 명 이하 , 아시아인 인구는 1 만 명 이하인 지역만 산점도에 표시되게 설정하세요 . [hint] xlim() 과 ylim() 을 이용해 조건에 맞게 축을 설정하면 됩니다 .

ggplot (data =  midwest,  aes (x =  poptotal,  y =  popasian)) +
  geom_point()  + xlim (0 ,  500000) + ylim (0 ,  10000)

#10 만 단위가 넘는 숫자는 지수 표기법(Exponential Notation)에 따라 표현됨. 
# 1e+05 = 10 만(1 × 10의 5승)
#정수로 표현하기 : options(scipen  =  99) 실행 후 그래프 생성
#지수로 표현하기 : options(scipen  =  0) 실행 후 그래프 생성
#R 스튜디오 재실행시 옵션 원상 복구됨


##막대 그래프(Bar Chart) : 데이터의 크기를 막대의 길이로 표현한 그래프
#성별 소득 차이처럼 집단 간 차이를 표현할 때 주로 사용

install.packages("dplyr")
library(dplyr)

df_mpg <- mpg %>%
  filter(!is.na(drv) & !is.na(cty))%>%
  group_by(drv)%>%
  summarise(mean_hwy = mean(cty)) # Na 제거하고, 집단별 평균표 만들기

mpg$hwy # NA 3개 존재 여부확인


#평균막대 그래프 만들기 : geom_col()
ggplot(data = df_mpg, aes(x = drv, y = mean_hwy)) + geom_col()

#크기순으로 정렬하기 (내림차순)
ggplot(data = df_mpg, aes(x = reorder(drv, -mean_hwy), y = mean_hwy)) + geom_col()

#빈도막대 그래프 그리기 : geom_bar()
ggplot(data = mpg, aes(x = drv)) + geom_bar()

ggplot(data = mpg, aes(x = hwy)) + geom_bar()


##선 그래프(Line Chart) : 데이터를 선으로 표현한 그래프
#시계열 그래프(Time Series Chart) : 일정 시간 간격을 두고 나열된 시계열 데이터(Time Series Data)를  선으로 표현한 그래프. 환율, 주가지수 등 경제 지표가 시간에 따라 어떻게 변하는지 표현할 때 활용
#새로운 데이터로 미국 경제상황에 대한 시계열 자료를 이용해 보자. 
#이 정보는 6개 변수로 구성되어 있고, 574건 데이터로 되어 있다. 
# date는 월별로 정보를 수집한 시점, 
# psavert는 개인저축율, 
# pce는 개인소비지출, 
# unemploy는 실업인원(천단위), 
# unempmed 실업기간 중앙값(주단위), 
# pop은 총인구(천단위)로 구성되어있다.

data("economics")
str(economics) # [574 × 6]

ggplot(data = economics, aes(x = date, y = unemploy)) + geom_line() #실업률 

economics
ggplot(data = economics, aes(x = date, y = psavert)) + geom_line() #개인저축율 

ggplot(data = economics, aes(x = date, y = pop)) + geom_line() #총인구수 

economics$pop


#상자 그림 - 집단 간 분포 차이 표현하기
#상자 그림(Box Plot) : 데이터의 분포(퍼져 있는 형태)를 직사각형 상자 모양으로 표현한 그래프
#분포를 알 수 있기 때문에 평균만 볼 때보다 데이터의 특성을 좀 더 자세히 이해할 수 있음

ggplot(data = mpg, aes(x = drv, y = hwy)) + geom_boxplot()






