library(tidyverse)
library(LICORS)
library(ISLR)
library(foreach)
library(mosaic)
library(GGally)

summary(wine)

# Q1: cluster into 2 categories,red and white

# Center and scale the data
X = wine[,1:11]
X = scale(X, center=TRUE, scale=TRUE)
mu = attr(X,"scaled:center")
sigma = attr(X,"scaled:scale")

# clustering
clust1 = kmeans(X, 2, nstart=25)
qplot(wine$density,wine$total.sulfur.dioxide, data=wine, shape=factor(clust1$cluster), col=factor(wine$color))

# table for the correctly clustering
xtabs(~clust1$cluster + wine$color)

# PCA
pc = prcomp(X, scale=TRUE)
summary(pc)
loadings = pc$rotation
scores = pc$x
qplot(scores[,1], scores[,2], color=wine$color, xlab='Component 1', ylab='Component 2')
clustPCA = kmeans(scores[,1:4], 2, nstart=20)

# table for PCA
xtabs(~clustPCA$cluster + wine$color)



# Q2: cluster into 7 categories

clust2 = kmeans(X, 7, nstart=25)
xtabs(~clust2$cluster + wine$quality)
qplot(wine$density,wine$total.sulfur.dioxide, data=wine, shape=factor(clust2$cluster), col=factor(wine$quality))

# PCA
pc2 = prcomp(X, scale=TRUE)
loadings = pc2$rotation
scores = pc2$x
qplot(scores[,1], scores[,2], color=factor(wine$quality),xlab='Component 1', ylab='Component 2')
clustPCA2 = kmeans(scores[,1:4], 7, nstart=25)
xtabs(~clustPCA2$cluster + wine$quality)
