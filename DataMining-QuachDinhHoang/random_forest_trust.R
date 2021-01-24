# data import
d.train <- read.table("C:\\Users\\howard\\Desktop\\ISU courses\\STAT 602 Statistical Learning\\DMC\\DMC_2019_task\\train.csv"
           ,header = T,sep='|')
d.train <- d.train[,c(10,1:9)]
d.train$fraud <- as.factor(d.train$fraud)
d.test <- read.table("C:\\Users\\howard\\Desktop\\ISU courses\\STAT 602 Statistical Learning\\DMC\\DMC_2019_task\\test.csv"
                   ,header = T,sep='|')
summary(test)
par(mfrow=c(2,2))
for(i in 2:dim(d.train)[2]){
hist(d.train[,i],main='train')
hist(d.test[,i-1],main='test')
}

##### model
library(caret)
library(AUC)
library(pROC)
library(dplyr)
### Eval function
Eval_function <- function(x){
  # x.00 <- x[x$fraud==0 & x$pred==0,]
  # n.00 <- dim(x.00)[1]
  x.01 <- x[x[,1]==0 & x[,2]==1,]
  n.01 <- dim(x.01)[1]
  x.10 <- x[x[,1]==1 & x[,2]==0,]
  n.10 <- dim(x.10)[1]
  x.11 <- x[x[,1]==1 & x[,2]==1,]
  n.11 <- dim(x.11)[1]
  cost <- -5*n.10 + (-25)*n.01 + 5*n.11
  return(cost)
}


### number of samples
n <- 100
row <- createDataPartition(d.train$fraud, times=n, p=0.8)
Outcome.list <- lapply(c(1:n), function(x){
 r <- row[[x]]
 d.model <- d.train[r,]
 d.cal <- d.train[-r,]
 model <- train(y = d.model[, 1],
                 x = d.model[, -1],
                 tuneGrid = data.frame(mtry = 4),
                 method = "rf",
                 ntree = 100,
                 trControl = trainControl(method = "repeatedcv",
                                          repeats = 2,
                                          #sampling='up',
                                          number = 10),
                 metric = "Kappa",
                 importance = F)
 pred.prob <- predict(model, d.cal, type ='prob')
 d.cal$fraud <- as.numeric(levels(d.cal$fraud))[d.cal$fraud]
 # AUC
 AUC <- auc(d.cal$fraud , pred.prob[,1])
 # compute Evaluation by cut-offs
 Eval.df <- as.data.frame(t(sapply(seq(0,1,by=0.05), function(y){
   cut_off <- y
   pred <- as.numeric(pred.prob$`1` >= cut_off)
   d.Eval <- data.frame(d.cal$fraud, pred)
   Eval <- Eval_function(d.Eval)
   return(Eval)
 })))
 colnames(Eval.df) <- paste(seq(0,1,by=0.05))
 y <- data.frame(Eval.df, AUC)
 return(y)
})

Outcome.df <- Reduce(x=Outcome.list, f=rbind)

summary(Outcome.df)


#
par(mfrow=c(2,2))
hist(Outcome.df$X0.55, breaks = 10)
hist(Outcome.df$X0.6, breaks = 10)
hist(Outcome.df$X0.65, breaks = 10)
hist(Outcome.df$X0.7, breaks = 10)
Outcome.df$X0.7

cor(Outcome.df )




#############




RF.Fit <- train(y = d.train[, 1],
                x = d.train[, -1],
                tuneGrid = data.frame(mtry = 1:9),
                method = "rf",
                ntree = 500,
                trControl = trainControl(method = "repeatedcv",
                                         repeats = 2,
                                         number = 10),
                importance = TRUE)
aa <- predict(RF.Fit, d.train, type ="prob")
sample(c(1:100),80)
summary(RF.Fit)
varImp(RF.Fit)
plot(RF.Fit)
print(RF.Fit)
RF.Fit$results$RMSE
