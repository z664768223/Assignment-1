library(tidyverse)
library(mosaic)
library(class)
library(FNN)
library(nnet)
data(brca)

###
#First question
###

rmse = function(y, yhat) {
  sqrt( mean( (y - yhat)^2 ) )
}

rmse_vals = do(100)*{
    n = nrow(brca)
    n_train = round(0.8*n) 
    n_test = n - n_train
    train_cases = sample.int(n, n_train, replace=FALSE)
    test_cases = setdiff(1:n, train_cases)
    brca_train = brca[train_cases,]
    brca_test = brca[test_cases,]
    
    ml1 = glm(recall ~ radiologist + age + history + symptoms + menopause
                   + density,data=brca_train, family = 'binomial')
    ml2 = glm(recall ~ radiologist + age + history + symptoms + menopause
              + density + age*menopause,data=brca_train, family = 'binomial')
    ml3 = glm(recall ~ radiologist + age + history + symptoms + menopause
               + density + age*symptoms,data=brca_train, family = 'binomial')
    ml4 = glm(recall ~ radiologist + age + history + symptoms + menopause
               + density + density*symptoms,data=brca_train, family = 'binomial')
    # predict on this testing set
    phat_test1 = predict(ml1, brca_test, type='response')
    phat_test2 = predict(ml2, brca_test, type='response')
    phat_test3 = predict(ml3, brca_test, type='response')
    phat_test4 = predict(ml4, brca_test, type='response')
    c(rmse(brca_test$recall, phat_test1),
      rmse(brca_test$recall, phat_test2),
      rmse(brca_test$recall, phat_test3),
      rmse(brca_test$recall, phat_test4)
    )
}
colMeans(rmse_vals)



###
#Second question
###
rmse_vals = do(100)*{
  n = nrow(brca)
  n_train = round(0.8*n) 
  n_test = n - n_train
  train_cases = sample.int(n, n_train, replace=FALSE)
  test_cases = setdiff(1:n, train_cases)
  brca_train = brca[train_cases,]
  brca_test = brca[test_cases,]
  
  m1 = glm(cancer~ recall, data = brca_train)
  m2 = glm(cancer~ recall + age, data = brca_train)
  m3 = glm(cancer~ recall + history, data = brca_train)
  m4 = glm(cancer~ recall + symptoms, data = brca_train)
  m5 = glm(cancer~ recall + menopause, data = brca_train)
  m6 = glm(cancer~ recall + density, data = brca_train)
 
  a = sum(brca$cancer==1)/987
  
  phat_test1 = predict(m1, brca_test, type='response')
  yhat_test1 = ifelse(phat_test1 >= a, 1, 0)
  #confusion_out1 = table(y = brca_test$cancer, yhat = yhat_test1)
  #sum(diag(confusion_out1))/sum(confusion_out1)
  
  phat_test2 = predict(m2, brca_test, type='response')
  yhat_test2 = ifelse(phat_test2 >= a, 1, 0)
  #confusion_out2 = table(y = brca_test$cancer, yhat = yhat_test2)
  #sum(diag(confusion_out2))/sum(confusion_out2)
  
  phat_test3 = predict(m3, brca_test, type='response')
  yhat_test3 = ifelse(phat_test3 >= a, 1, 0)
  #confusion_out3 = table(y = brca_test$cancer, yhat = yhat_test3)
  #sum(diag(confusion_out3))/sum(confusion_out3)
  
  phat_test4 = predict(m4, brca_test, type='response')
  yhat_test4 = ifelse(phat_test4 >= a, 1, 0)
  #confusion_out4 = table(y = brca_test$cancer, yhat = yhat_test4)
  #sum(diag(confusion_out4))/sum(confusion_out4)
  
  phat_test5 = predict(m5, brca_test, type='response')
  yhat_test5 = ifelse(phat_test5 >= a, 1, 0)
  #confusion_out5 = table(y = brca_test$cancer, yhat = yhat_test5)
  #sum(diag(confusion_out5))/sum(confusion_out5)
  
  phat_test6 = predict(m6, brca_test, type='response')
  yhat_test6 = ifelse(phat_test6 >= a, 1, 0)
  #confusion_out6 = table(y = brca_test$cancer, yhat = yhat_test6)
  #sum(diag(confusion_out6))/sum(confusion_out6)
  c(rmse(brca_test$cancer, yhat_test1),
    rmse(brca_test$cancer, yhat_test2),
    rmse(brca_test$cancer, yhat_test3),
    rmse(brca_test$cancer, yhat_test4),
    rmse(brca_test$cancer, yhat_test5),
    rmse(brca_test$cancer, yhat_test6)
  )
}
colMeans(rmse_vals)