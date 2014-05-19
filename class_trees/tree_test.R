
credit <- read.csv("credit.csv")

# 90% of the data for training and 10% for testing

set.seed(12345)

credit_rand <- credit[order(runif(1000)), ]

credit_train <- credit_rand[1:900, ]

credit_test <- credit_rand[901:1000, ]

library(C50)

credit_model <- C5.0(credit_train[-17], credit_train$default)

credit_pred <- predict(credit_model, credit_test)

#----------------------------------------

credit_boost10 <- C5.0(credit_train[-17], credit_train$default, trials = 10)


credit_boost_pred10 <- predict(credit_boost10, credit_test)

#error_cost <- matrix(c(0, 1, 4, 0), nrow = 2)


#credit_cost <- C5.0(credit_train[-17], credit_train$default, costs = error_cost)



#----------------
# With library tree

library(tree)

ct1 <- tree(default ~. , data = credit_train)
p_ct1 <- prune.tree(ct1, best = 7)
c_ct1 <- cv.tree(ct1)
p_ct4 <- prune.tree(ct1, best = 4)


par(mfrow=c(2, 2))

plot(ct1)
text(ct1)
plot(p_ct1)
text(p_ct1)
plot(p_ct4)
text(p_ct4)
plot(c_ct1)

#------------
# Trying rpart


rp1 <- rpart(default ~., data = credit_train, control = rpart.control(cp = 0))
plotcp(rp1)


rp3 <- rpart(default ~., data = credit_train, control = rpart.control(cp = 0))
plotcp(rp1)
printcp(rp3)


#prune tree with complexity parameter of 0.013

rp4 <- prune(rp3,  cp = 0.0136816)

plot(rp4)
text(rp4)
printcp(rp4)


# To get the variable importance use 
print(rp4$variable.importance)