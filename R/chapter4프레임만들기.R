#### 04-2 ####

## ------------------------------------------------------ ##
english <- c(90, 80, 60, 70)  # 영어 점수 변수 생성
english

math <- c(50, 60, 100, 20)    # 수학 점수 변수 생성
math

# english, math로 데이터 프레임 생성해서 df_midterm에 할당
df_midterm <- data.frame(english, math)
df_midterm

class <- c(1, 1, 2, 2)
class

df_midterm <- data.frame(english, math, class)
df_midterm

mean(df_midterm$english)  # df_midterm의 english로 평균 산출
mean(df_midterm$math)     # df_midterm의 math로 평균 산술

#데이터프레임 한번에 만들기 
df_midterm <- data.frame(name = c("김지훈", "이유진", "박동현", "김민지"),
                         english = c(90, 80, 60, 70),
                         math = c(50, 60, 100, 20),
                         class = c(1, 1, 2, 2))
df_midterm


## excel file 처리
install.packages("readxl")
library(readxl)

getwd()
setwd("D:\\RStudio") #작업폴더 지정

df_exam <- read_excel("D:\\RStudio\\data\\excel_exam.xlsx")
df_exam

str(df_exam)

mean(df_exam$math)    #[1] 57.45
mean(df_exam$english) #[1] 84.9
mean(df_exam$science) #[1] 59.45

#변수없이 데이터만 존재하는 파일
df_exam_novar <- read_excel("D:\\RStudio\\data\\excel_exam_novar.xlsx")
df_exam_novar
str(df_exam_novar)

#엑셀 파일 3번째 쉬트 정보 가져오기
df_exam_sheet <- read_excel("D:\\RStudio\\data\\excel_exam.xlsx", sheet = 3)
df_exam_sheet
str(df_exam_sheet)


## CSV 파일 읽어오기
df_csv_exam <- read.csv("D:\\RStudio\\data\\csv_exam.csv")
df_csv_exam
str(df_csv_exam) #'data.frame':	20 obs. of  5 variables:

#문자가 들어 있는 파일을 불러올 때는
df_csv_exam2 <- read.csv("D:\\RStudio\\data\\csv_exam.csv", stringsAsFactors = F)
df_csv_exam2


##CSV 파일 생성 및 저장하기
df_midterm <- data.frame(english = c(90, 80, 60, 70),
           math = c(50, 60, 100, 20),
           class = c(1, 1, 2, 2))
df_midterm

write.csv(df_midterm, file = "df_midterm.csv")

df_midterm2 <- read.csv("D:\\RStudio\\data\\df_midterm.csv")
df_midterm2
str(df_midterm2)

## R 전용 데이터 파일 : 용량 작고 빠름
#데이터 프레임을 RData 파일로 저장하기

save(df_midterm, file = "df_midterm.rda")

load("df_midterm.rda")
df_midterm


## ----------------------------------------------------------- ##
# 1.변수 만들기, 데이터 프레임 만들기
english <- c(90, 80, 60, 70)  # 영어 점수 변수 생성
math <- c(50, 60, 100, 20)    # 수학 점수 변수 생성
data.frame(english, math)     # 데이터 프레임 생성

# 2. 외부 데이터 이용하기

# 엑셀 파일
library(readxl)                                 # readxl 패키지 로드
df_exam <- read_excel("excel_exam.xlsx")        # 엑셀 파일 불러오기

# CSV 파일
df_csv_exam <- read.csv("csv_exam.csv")         # CSV 파일 불러오기
write.csv(df_midterm, file = "df_midterm.csv")  # CSV 파일로 저장하기

# Rda 파일
load("df_midterm.rda")                          # Rda 파일 불러오기
save(df_midterm, file = "df_midterm.rda")       # Rda 파일로 저장하기
#--------------------------------------------------------#


#내장 데이터 목록 보기
data()

data(quakes)

#데이터 구조와 유형 보기 
str(quakes) # data.frame':	1000 obs. of  5 variables:

#Latitude(위도) of event
# lat범위는 -90(남극) ~ 90(북극), long(-180~180), 
# 경도가 180도 이상이면 '경도값 - 360'로 변환하면 됩니다.
#Longitude(경도) 
#Depth (km)
#Richter Magnitude(리히터 규모) 
#Number of stations reporting(관측소 수) 

head(quakes) # 처음부터 6개정보 출력 
head(quakes, n=12) # 원하는 갯수대로 ...

tail(quakes) # 가장 뒤에서부터 6개 출력
tail(quakes, n=12)

# 데이터 세트 변수명 보기
names(quakes) # [1] "lat"      "long"     "depth"    "mag"      "stations"

dim(quakes) # [1] 1000    5

summary(quakes)
#     lat              long           depth            mag          stations     
Min.   :-38.59   Min.   :165.7   Min.   : 40.0   Min.   :4.00   Min.   : 10.00  
1st Qu.:-23.47   1st Qu.:179.6   1st Qu.: 99.0   1st Qu.:4.30   1st Qu.: 18.00  
Median :-20.30   Median :181.4   Median :247.0   Median :4.60   Median : 27.00  
Mean   :-20.64   Mean   :179.5   Mean   :311.4   Mean   :4.62   Mean   : 33.42  
3rd Qu.:-17.64   3rd Qu.:183.2   3rd Qu.:543.0   3rd Qu.:4.90   3rd Qu.: 42.00  
Max.   :-10.72   Max.   :188.1   Max.   :680.0   Max.   :6.40   Max.   :132.00 

# quakes 데이터를 이용한 BoxPlot
data(quakes)
str(quakes)

mag <- quakes$mag #Richter Magnitude(리히터 규모) 
mag

min(mag) # 4
max(mag) #6.4
median(mag) #4.6
mean(mag) # 4.6204

quantile(mag) # 4분위수 표시하기
# 0%  25%  50%  75%  100% 
#4.0  4.3  4.6  4.9  6.4 

barplot(mag, col="red", main="지진별 발생 강도 분포")

barplot(mag, col=rainbow(length(mag)), main="지진별 발생 강도 분포")

barplot(mag, xlab="지진", ylab="발생건수", main="지진별 발생 강도 분포")

barplot(mag, col=rainbow(length(mag)), xlab="지진", ylab="발생건수", ylim=c(0, 10), main="지진별 발생 강도 분포")

bp <- barplot(mag, col=rainbow(length(mag)), xlab="지진", ylab="발생건수", ylim=c(0, 10), main="지진별 발생 강도 분포")
text(x=bp, y=mag, labels=round(mag, 0), pos=3)
plot.new() # 막대 그래프 지우기 

setwd("D:\\RStudio\\images")


## quakes 데이터를 이용한 histgram 그리기
mag <- quakes$mag
mag

var(mag) #0.1622261
sd(mag) #0.402773

hist(mag, main="지진별 발생 강도 분포")

hist(mag, col=rainbow(length(mag)), main="지진별 발생 강도 분포")

colors <- c("red", "green", "blue", "orange", "navy", "yellow")
hist(mag, col=colors, main="지진별 발생 강도 분포")

colors <- c("red", "green", "blue", "orange", "navy", "yellow")
hist(mag, main="지진 발생 강도의 분포", xlab="지진 강도", ylab="발생 건수",
     col=colors, breaks=seq(4, 6.5, by=0.8))
#breaks="Sturges" : 계급도수분포.Sturges공식이름. 
# (숫자로 입력)계급구간 수 또는 (벡터로 입력)간격

colors <- c("red", "green", "blue", "orange", "navy", "yellow")
hist(mag, main="지진 발생 강도의 분포", xlab="지진 강도", ylab="발생 건수",
     col=colors, breaks="Sturges", freq = FALSE)
# freq = FALSE : 상대도수로 표기

colors <- c("red", "green", "blue", "orange", "navy", "yellow")
hist(mag, main="지진 발생 강도의 분포", xlab="지진 강도", ylab="발생 건수",
     col=colors, breaks="Sturges", freq = FALSE)
legend("topright", "mag", fill="red") # 범례 설정 




