#Name: analysis.R
#Author: Donald Dunagan, dgd45125@uga.edu
#Date: 10 October 2026

#Description: 
#toy analysis of the iris dataset. 
#one-way ANOVA (analysis of variance) to check for difference in petal length means between iris classes.


#set the working directory so that we can use relative path names
getwd()
#####setwd("C:/Users/dgd45125/Documents/git_workshop/template_project_directory/")

#You can also set the working directory by using the Files pane -> navigate to 
#your desired directory -> ore -> "set as working directory"

#read in the iris data as an R data frame object
iris_df <- read.csv("data/iris.csv")



iris_classes <- list('Iris-setosa','Iris-versicolor','Iris-virginica')

#calculate and print mean and standard deviation for petal length by class
for (class in iris_classes){
  selection <- iris_df$petal_length[iris_df$class == class]
  mean <- mean(selection)
  sd <- sd(selection)
  cat(class, "mean petal length:", mean, "and SD:", sd, "\n")
  
}

#get petal length summary statistics by class
aggregate(petal_length ~ class, data = iris_df, summary)


#petal length boxplot by class
boxplot(petal_length ~ class,
        data = iris_df,
        main = "Petal Length by Iris Class",
        xlab = "Iris Class",
        ylab = "Petal Length (cm.)",
        col = c("gold","tomato","lightgreen"))



#fit a one-way ANOVA: petal length ~ iris class
model <-  aov(petal_length ~ class, data = iris_df)

summary(model)
#with very large F and very low p-value, we conclude that there
#exists some difference in petal length means between iris classes.


#next, apply posthoc comparison to identify which classes (pairwise) are different from each other.
#use Tukey's honest significance test (HSD)
TukeyHSD(model)
#p adj indicates comparison p-value after correcting for family-wise error rate. 
#all 3 contrasts are significant: versicolor > setosa; virginica > setosa; virginica > versicolor
