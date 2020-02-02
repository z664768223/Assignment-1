library(mosaic)
library(tidyverse)
library(FNN)

# The variables involved
summary(sclass)

sclass<- sclass %>%
  select(trim, mileage, price) 

# Focus on 2 trim levels: 350 and 65 AMG
sclass350 = subset(sclass, trim == '350')
dim(sclass350)

sclass65AMG = subset(sclass, trim == '65 AMG')
summary(sclass65AMG)

# Look at price vs mileage for each trim level
plot(price ~ mileage, data = sclass350)
plot(price ~ mileage, data = sclass65AMG)

################## for trim 350
# Make a train-test split
N = nrow(sclass350)
N_train = floor(0.8*N)
N_test = N - N_train
K = seq(3, 100, by = 1)
#####
# Train/test split
#####

# randomly sample a set of data points to include in the training set
train_ind = sample.int(N, N_train, replace=FALSE)

# Define the training and testing set
D_train = sclass350[train_ind,]
D_test = sclass350[-train_ind,]

# optional book-keeping step:
# reorder the rows of the testing set by the KHOU (temperature) variable
# this isn't necessary, but it will allow us to make a pretty plot later
D_test = arrange(D_test, mileage)
head(D_test)

# Now separate the training and testing sets into features (X) and outcome (y)
X_train = select(D_train, mileage)
y_train = select(D_train, price)
X_test = select(D_test, mileage)
y_test = select(D_test, price)

# define a helper function for calculating RMSE
rmse = function(y, ypred) {
  sqrt(mean(data.matrix((y-ypred)^2)))
}

u <- 0
for (i in 1:98){
  
  knn = knn.reg(train = X_train, test = X_test, y = y_train, k=K[i])
  ypred_knn = knn$pred
  u[i] = rmse(y_test, ypred_knn)

}

ggplot(data = NULL, aes(x = K, y = u)) + 
  geom_path(aes(x = K, y = u),color = 'red') + 
  labs(title = "RMSE versus K", y = "RMSE", x = "K")

opt350 <- K[which.min(u)]
knn = knn.reg(train = X_train, test = X_test, y = y_train, k=opt350)
ypred_knn = knn$pred
D_test$ypred_knn = ypred_knn

p_test = ggplot(data = D_test) + 
  geom_point(mapping = aes(x = mileage, y = price), color='lightgrey') + 
  theme_bw(base_size=18) + 
  ylim(7000, 150000)
p_test

p_test + geom_path(aes(x = mileage, y = ypred_knn), color='red')

################## for trim 65 AMG
N = nrow(sclass65AMG)
N_train = floor(0.8*N)
N_test = N - N_train
K = seq(3, 25, by = 1)
#####
# Train/test split
#####

# randomly sample a set of data points to include in the training set
train_ind = sample.int(N, N_train, replace=FALSE)

# Define the training and testing set
D_train = sclass65AMG[train_ind,]
D_test = sclass65AMG[-train_ind,]

# optional book-keeping step:
# reorder the rows of the testing set by the KHOU (temperature) variable
# this isn't necessary, but it will allow us to make a pretty plot later
D_test = arrange(D_test, mileage)
head(D_test)

# Now separate the training and testing sets into features (X) and outcome (y)
X_train = select(D_train, mileage)
y_train = select(D_train, price)
X_test = select(D_test, mileage)
y_test = select(D_test, price)

# define a helper function for calculating RMSE
rmse = function(y, ypred) {
  sqrt(mean(data.matrix((y-ypred)^2)))
}

u <- 0
for (i in 1:23){
  
  knn = knn.reg(train = X_train, test = X_test, y = y_train, k=K[i])
  ypred_knn = knn$pred
  u[i] = rmse(y_test, ypred_knn)
  
}

ggplot(data = NULL, aes(x = K, y = u)) + 
  geom_path(aes(x = K, y = u),color = 'red') + 
  labs(title = "RMSE versus K", y = "RMSE", x = "K")

opt65 <- K[which.min(u)]
knn = knn.reg(train = X_train, test = X_test, y = y_train, k=opt65)
ypred_knn = knn$pred
D_test$ypred_knn = ypred_knn

p_test = ggplot(data = D_test) + 
  geom_point(mapping = aes(x = mileage, y = price), color='lightgrey') + 
  theme_bw(base_size=18) + 
  ylim(15000, 250000)
p_test

p_test + geom_path(aes(x = mileage, y = ypred_knn), color='red')
