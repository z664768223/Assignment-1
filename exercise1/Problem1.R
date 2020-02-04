library(tidyverse)
library(ggplot2)

summary(ABIA)
sample <- ABIA
####drop Arrdelay and Depdelay's NA
sample[, 15][is.na(sample[ , 15])]=0
sample[, 16][is.na(sample[ , 16])]=0

#### data cleaning 
sample <- sample %>%
  mutate(Month=as.factor(Month), DayofMonth=as.factor(DayofMonth),DayOfWeek=as.factor(DayOfWeek))

### Average Delay on each time of the day
mydata1 <-sample %>%
  mutate(sumdelay = DepDelay)  %>%
  select(Year, Month, DayofMonth, DayOfWeek, DepTime, sumdelay) %>%
  group_by(DepTime) %>%
  summarize(T.delay = sum(sumdelay), Count = n()) 

mydata1 <- mydata2 %>%
  mutate(avedelay = T.delay/Count)

ggplot(data = mydata1) + 
  geom_point(mapping = aes(x = DepTime, y = avedelay), color='darkgrey')

### Time frame from 5 am to 3 pm

ggplot(data = mydata1) + 
  geom_point(mapping = aes(x = DepTime, y = avedelay), color='darkgrey') +
  xlim(500, 1500)+ylim(-15,20)


######################################################  month minized delay
monthdata <- sample %>%
  mutate(sumdelay = DepDelay) %>%
  group_by(Month) %>%
  summarize(avedelay = mean(sumdelay))
ggplot(data=monthdata , aes(x=Month, y=avedelay)) +
  geom_bar(stat="identity", fill="steelblue")+
  theme_minimal()

########################################### September, day of month

sepdata <- sample %>%
  filter(Month == '9') %>%
  mutate(sumdelay = DepDelay) %>%
  group_by(DayofMonth) %>%
  summarize(avedelay = mean(sumdelay)) 

ggplot(data=sepdata , aes(x=DayofMonth, y=avedelay)) +
  geom_bar(stat="identity", fill="steelblue", width = 0.7)+
  theme_minimal()

##################### days on time in Sep
sepdata <- sepdata  %>%
  filter(avedelay <= 1.5)

ggplot(data=sepdata , aes(x=DayofMonth, y=avedelay)) +
  geom_bar(stat="identity", fill="steelblue", width = 0.7)+
  theme_minimal()

############## days of week in Sep
sepweekdata <- sample %>%
  filter(Month == '9') %>%
  mutate(sumdelay = DepDelay) %>%
  group_by(DayofMonth,DayOfWeek) %>%
  summarize(avedelay = mean(sumdelay))

sepweekdata <- sepweekdata  %>%
  filter(avedelay <= 1.5) %>%
  group_by(DayOfWeek) %>%
  summarize(Countnum = n(),avedelay = mean(avedelay)) 

ggplot(data=sepweekdata , aes(x=DayOfWeek, y=avedelay)) +
  geom_bar(stat="identity", fill="steelblue", width = 0.7)+
  theme_minimal()

########################################## October , day of month

octdata <- sample %>%
  filter(Month == '10') %>%
  mutate(sumdelay = DepDelay) %>%
  group_by(DayofMonth) %>%
  summarize(avedelay = mean(sumdelay)) 

ggplot(data=octdata, aes(x=DayofMonth, y=avedelay)) +
  geom_bar(stat="identity", fill="steelblue",width=0.7)+
  theme_minimal()

##################### days on time in Oct
octdata <- octdata  %>%
  filter(avedelay <= 1.5)

ggplot(data=octdata , aes(x=DayofMonth, y=avedelay)) +
  geom_bar(stat="identity", fill="steelblue", width = 0.7)+
  theme_minimal()

##############days of week in Oct
octweekdata <- sample %>%
  filter(Month == '10') %>%
  mutate(sumdelay = DepDelay) %>%
  group_by(DayofMonth,DayOfWeek) %>%
  summarize(avedelay = mean(sumdelay))

octweekdata <- octweekdata  %>%
  filter(avedelay <= 1.5) 
  
ggplot(data=octdata , aes(x=DayofMonth, y=avedelay)) +
  geom_bar(stat="identity", fill="steelblue", width = 0.7)+
  theme_minimal()

octweekdata <-octweekdata %>%
  group_by(DayOfWeek) %>%
  summarize(Countnum = n(),avedelay = mean(avedelay)) 

ggplot(data=octweekdata , aes(x=DayOfWeek, y=avedelay)) +
  geom_bar(stat="identity", fill="steelblue", width = 0.7)+
  theme_minimal()
  
########################################## November, day of month
novdata <- sample %>%
  filter(Month == '11') %>%
  mutate(sumdelay = DepDelay) %>%
  group_by(DayofMonth) %>%
  summarize(avedelay = mean(sumdelay)) 

ggplot(data=novdata , aes(x=DayofMonth, y=avedelay)) +
  geom_bar(stat="identity", fill="steelblue",width=0.7)+
  theme_minimal()

##################### days in November mninimize delay
novdata <- novdata  %>%
  filter(avedelay <= 1.5)

ggplot(data=novdata , aes(x=DayofMonth, y=avedelay)) +
  geom_bar(stat="identity", fill="steelblue", width = 0.7)+
  theme_minimal()

##############days of week in Nov
novweekdata <- sample %>%
  filter(Month == '11') %>%
  mutate(sumdelay = DepDelay) %>%
  group_by(DayofMonth,DayOfWeek) %>%
  summarize(avedelay = mean(sumdelay))

novweekdata <- novweekdata  %>%
  filter(avedelay <= 1.5) %>%
  group_by(DayOfWeek) %>%
  summarize(Countnum = n(),avedelay = mean(avedelay)) 


ggplot(data=novweekdata , aes(x=DayOfWeek, y=avedelay)) +
  geom_bar(stat="identity", fill="steelblue", width = 0.7)+
  theme_minimal()

##################################################################### three month together
overalldata <- sample %>%
  filter((Month == '11') |(Month == '10') | (Month == '9')) %>%
  mutate(sumdelay = DepDelay) %>%
  group_by(DayofMonth,DayOfWeek) %>%
  summarize(avedelay = mean(sumdelay))

overalldata <- overalldata %>%
  filter(avedelay <=1.5)

overalldata <-overalldata %>%
  group_by(DayOfWeek) %>%
  summarize(Counts = n(),avedelay = mean(avedelay)) 

ggplot(data=overalldata , aes(x=DayOfWeek, y=Counts)) +
  geom_bar(stat="identity", fill="steelblue", width = 0.7)+
  theme_minimal()

ggplot(data=overalldata , aes(x=DayOfWeek, y=avedelay)) +
  geom_bar(stat="identity", fill="steelblue", width = 0.7)+
  theme_minimal()
  
