K-nearest neighbors
===================

Firstly, we only need the data of trim, price, and mileage for this
question. So we clean the other unrelated variable in the data set.

    sclass<- sclass %>%
      select(trim, mileage, price) 
    summary(sclass)

    ##       trim          mileage           price       
    ##  550    :21836   Min.   :     1   Min.   :   599  
    ##  430    : 2071   1st Qu.:    14   1st Qu.: 28995  
    ##  500    : 2002   Median : 26120   Median : 56991  
    ##  63 AMG : 1413   Mean   : 40387   Mean   : 67001  
    ##  600    :  527   3rd Qu.: 68234   3rd Qu.:108815  
    ##  350    :  416   Max.   :488525   Max.   :299000  
    ##  (Other): 1201

Then, we select two specific trim levels from the full data set: 350 and
65 AMG.

    sclass350 = subset(sclass, trim == '350')
    sclass65AMG = subset(sclass, trim == '65 AMG')

**FOR 350 TRIM LEVEL DATA SET**

Take a look at price vs mileage for 350 trim level.

    plot(price ~ mileage, data = sclass350)

![](problem2_files/figure-markdown_strict/unnamed-chunk-4-1.png)

We split the data into a training and a testing set and separate the
training and testing sets into features (X) and outcome (y).

    # Make a train-test split
    N = nrow(sclass350)
    N_train = floor(0.8*N)
    N_test = N - N_train

    # randomly sample a set of data points to include in the training set
    train_ind = sample.int(N, N_train, replace=FALSE)

    # Define the training and testing set
    D_train = sclass350[train_ind,]
    D_test = sclass350[-train_ind,]

    # reorder the rows of the testing set by the mileage variable
    D_test = arrange(D_test, mileage)

    X_train = select(D_train, mileage)
    y_train = select(D_train, price)
    X_test = select(D_test, mileage)
    y_test = select(D_test, price)

Beacause we only have 416 data points in the 350 trim level sub-dataset.
We assume optimum K value for the smallest RMSE in the testing set is
less than 100. Set up a for loop to calculate the RMSE for K from 3 to
100 and save the RMSE values in a vector.

    K = seq(3, 100, by = 1)
    u <- 0
    for (i in 1:98){
      
      knn = knn.reg(train = X_train, test = X_test, y = y_train, k=K[i])
      ypred_knn = knn$pred
      u[i] = rmse(y_test, ypred_knn)

    }

Make a plot of RMSE versus K and then find the K value with the minimum
RMSE in the graph.

    ggplot(data = NULL, aes(x = K, y = u)) + 
      geom_path(aes(x = K, y = u),color = 'red') + 
      labs(title = "RMSE versus K", y = "RMSE", x = "K")

![](problem2_files/figure-markdown_strict/unnamed-chunk-8-1.png)

The optimal value of K for 350 trim level is 10. Lastly, we use the
optimum K value and present a plot of the fitted model for 350 trim
level.

    opt350 <- K[which.min(u)]
    knn = knn.reg(train = X_train, test = X_test, y = y_train, k=opt350)
    ypred_knn = knn$pred
    D_test$ypred_knn = ypred_knn
    ggplot(data = D_test) + 
      geom_point(mapping = aes(x = mileage, y = price), color='lightgrey') + 
      theme_bw(base_size=18) + 
      ylim(6600, 150000) + geom_path(aes(x = mileage, y = ypred_knn), color='red')

![](problem2_files/figure-markdown_strict/unnamed-chunk-9-1.png)

**FOR 65 AMG TRIM LEVEL DATA SET**

Take a look at price vs mileage for 65 AMG trim level.

    plot(price ~ mileage, data = sclass65AMG)

![](problem2_files/figure-markdown_strict/unnamed-chunk-10-1.png)

Basiclly, we just repeat what we did above. Since we only have 292
samples in this data set. We assume the optimum K value is less than 50.

    K = seq(3, 50, by = 1)
    u <- 0
    for (i in 1:48){
      
      knn = knn.reg(train = X_train, test = X_test, y = y_train, k=K[i])
      ypred_knn = knn$pred
      u[i] = rmse(y_test, ypred_knn)
      
    }

    ggplot(data = NULL, aes(x = K, y = u)) + 
      geom_path(aes(x = K, y = u),color = 'red') + 
      labs(title = "RMSE versus K", y = "RMSE", x = "K")

![](problem2_files/figure-markdown_strict/unnamed-chunk-12-1.png)

The optimal value of K for 65 AMG trim level is 15. Lastly, we use the
optimum K value and present a plot of the fitted model for 65 AMG trim
level.

    opt65 <- K[which.min(u)]
    knn = knn.reg(train = X_train, test = X_test, y = y_train, k=opt65)
    ypred_knn = knn$pred
    D_test$ypred_knn = ypred_knn
    ggplot(data = D_test) + 
      geom_point(mapping = aes(x = mileage, y = price), color='lightgrey') + 
      theme_bw(base_size=18) + 
      ylim(15000, 250000) + geom_path(aes(x = mileage, y = ypred_knn), color='red')

![](problem2_files/figure-markdown_strict/unnamed-chunk-13-1.png)

Comparing our results, we believe that the reason why 350 trim level
data set have a larger optimum K value is because we have more data for
350 trim level cars. So with a larger data set, generally we should have
a larger optimum K value for 350 trim level. However, it can also happen
that 65 AMG trim level has a larger optimum K value. Because we select
random data points for training data set and testing data set, everytime
we run the code again we will have a different result and a different
graph of RMSE versus K value. So it will also exist the case that we
have a larger optimum K value for 65 AMG trim level.
