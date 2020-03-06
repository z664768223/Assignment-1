library(tidyverse)
library(mosaic)
data(SaratogaHouses)

####
# Compare out-of-sample predictive performance
####

result = do(100)*{
  n = nrow(SaratogaHouses)
  n_train = round(0.8*n)  # round to nearest integer
  n_test = n - n_train
  train_cases = sample.int(n, n_train, replace=FALSE)
  test_cases = setdiff(1:n, train_cases)
  saratoga_train = SaratogaHouses[train_cases,]
  saratoga_test = SaratogaHouses[test_cases,]
  
  #medium model
  lm1 = lm(price ~ . - sewer - waterfront - landValue - newConstruction, data=saratoga_train)
  #hand-build model
  lm2 = lm(price ~ bedrooms + newConstruction + heating
           + livingArea + age + waterfront + centralAir + rooms + landValue 
           + lotSize + bathrooms + rooms*heating + landValue*lotSize + rooms*bathrooms 
           + heating*centralAir, data=saratoga_train)
  #bathroom strong driver
  lm3 = lm(price ~ bedrooms + newConstruction + heating
           + livingArea + age + waterfront + centralAir + rooms + landValue 
           + lotSize + rooms*heating + landValue*lotSize
           + heating*centralAir, data=saratoga_train)
  #livingArea strong driver
  lm4 = lm(price ~ bedrooms + newConstruction + heating
           + age + waterfront + centralAir + rooms + landValue 
           + lotSize + bathrooms + rooms*heating + landValue*lotSize + rooms*bathrooms 
           + heating*centralAir, data=saratoga_train)
  #waterfront strong driver
  lm5 = lm(price ~ bedrooms + newConstruction + heating
           + livingArea + age + centralAir + rooms + landValue 
           + lotSize + bathrooms + rooms*heating + landValue*lotSize + rooms*bathrooms 
           + heating*centralAir, data=saratoga_train)
  #landvalue
  lm6 = lm(price ~ bedrooms + newConstruction + heating
           + livingArea + age + waterfront + centralAir + rooms
           + lotSize + bathrooms + rooms*heating + rooms*bathrooms 
           + heating*centralAir, data=saratoga_train)
  # Predictions out of sample
  
  yhat_meidum = predict(lm1, saratoga_test)
  yhat_hb = predict(lm2, saratoga_test)
  yhat_3 = predict(lm3, saratoga_test)
  yhat_4 = predict(lm4, saratoga_test)
  yhat_5 = predict(lm5, saratoga_test)
  yhat_6 = predict(lm6, saratoga_test)
  
  rmse = function(y, yhat) {
    sqrt( mean( (y - yhat)^2 ) )
  }
  # predict on this testing set
  c(rmse(saratoga_test$price, yhat_meidum),
    rmse(saratoga_test$price, yhat_hb),
    rmse(saratoga_test$price, yhat_3),
    rmse(saratoga_test$price, yhat_4),
    rmse(saratoga_test$price, yhat_5),
    rmse(saratoga_test$price, yhat_6)
    )
}
colMeans(result)

###
#KNN MODEL
###
# construct the training and test-set feature matrices
# note the "-1": this says "don't add a column of ones for the intercept"


library(FNN)
library(foreach)

k_grid = seq(1,100,by=1) %>% round %>% unique
rmse_grid = foreach(K = k_grid, .combine='c') %do% {
    Xtrain = model.matrix(~ . - (price + pctCollege + sewer + fuel + fireplaces) - 1, data=saratoga_train)
    Xtest = model.matrix(~ . - (price + pctCollege + sewer + fuel + fireplaces) - 1, data=saratoga_test)
    
    # training and testing set responses
    ytrain = saratoga_train$price
    ytest = saratoga_test$price
    
    # now rescale:
    scale_train = apply(Xtrain, 2, sd)  # calculate std dev for each column
    Xtilde_train = scale(Xtrain, scale = scale_train)
    Xtilde_test = scale(Xtest, scale = scale_train)  # use the training set scales!
  knn_model = knn.reg(Xtilde_train, Xtilde_test, ytrain, k=K)
  rmse(ytest, knn_model$pred)
  }
plot(k_grid, rmse_grid, log = 'x', type="l",lwd =2, main="Plot of RMSE Versus K", xlab="K",ylab="RMSE")
k_grid[which.min(rmse_grid)]
rmse_grid[which.min(rmse_grid)]
