library(ggplot2)

library(foreach)

library(mosaic)
social <- read.csv("C:/Users/Lydia Liu/Desktop/data mining/social_marketing.csv.txt")
summary(social)

# Center and scale the data

M = social[,-c(1,2,6,36)]

M = scale(M, center=TRUE, scale=TRUE)

library(foreach)
k_grid = seq(2,20,by=1)
SSE_grid = foreach(k = k_grid, .combine ='c') %do%
  {cluster_k = kmeans(M,k,nstart = 50)
  cluster_k$tot.withinss}
plot(k_grid, SSE_grid)

mu = attr(M,"scaled:center")
sigma = attr(M,"scaled:scale")

# Run k-means with 7 clusters and 50 starts
clust1 = kmeans(M, 7, nstart=50)
pc = prcomp(M, scale=TRUE)
summary(pc)
loadings = pc$rotation
scores = pc$x

#PCA
#4
qplot(scores[,2], scores[,4], color=factor(clust1$cluster), xlab='Component 2', ylab='Component 4')
#3,6
qplot(scores[,2], scores[,3], color=factor(clust1$cluster), xlab='Component 2', ylab='Component 3')
#1
qplot(scores[,4], scores[,5], color=factor(clust1$cluster), xlab='Component 4', ylab='Component 5')
#2
qplot(scores[,4], scores[,6], color=factor(clust1$cluster), xlab='Component 4', ylab='Component 6')
#5
qplot(scores[,1], scores[,6], color=factor(clust1$cluster), xlab='Component 1', ylab='Component 6')
#7
qplot(scores[,3], scores[,7], color=factor(clust1$cluster), xlab='Component 1', ylab='Component 7')

o1 = order(loadings[,1], decreasing=TRUE)
colnames(M)[head(o1,10)]

o2 = order(loadings[,2], decreasing=TRUE)
colnames(M)[head(o2,10)]

o3 = order(loadings[,3], decreasing=TRUE)
colnames(M)[head(o3,10)]

o4 = order(loadings[,4], decreasing=TRUE)
colnames(M)[head(o4,10)]

o5 = order(loadings[,5], decreasing=TRUE)
colnames(M)[head(o5,10)]

o6 = order(loadings[,6], decreasing=TRUE)
colnames(M)[head(o6,10)]

o7 = order(loadings[,7], decreasing=TRUE)
colnames(M)[head(o7,10)]