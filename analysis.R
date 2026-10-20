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



#but have we satisfied the ANOVA assumptions?


#assumption 1: the data are independent and normally distributed.
#satisfied by assuming correct sampling procedure


#assumption 2: the residuals of the data are normally distributed (difference between an item and its class mean).
#plot the standardized residuals by their theoretical quantiles
plot(model, which = 2)
#in a perfect world, there would be a perfect diagonal.
#shapiro-wilk test evaluates the null hypothesis that the residuals are normally distributed
shapiro.test(residuals(model))
#because p < 0.05, we reject the null of normally distributed residuals


#assumption 2: the variances of the groups are equal --- i.e., homogeneity of variance
plot(model, which = 1)
#normally, we would use the standard Levene test, but that requires an external package.
#instead, because residuals are not normally distributed, we will use Fligner-Killeen
fligner.test(petal_length ~ class, data = iris_df)
#because p < 0.05, we reject the null hypothesis of equal variances --- i.e., homogeneity


#do we have equal group sizes?
table(iris_df$class)
#yes



#we at least have equal group sizes, so we will run kruskal-wallis
kruskal.test <-  kruskal.test(petal_length ~ class, data = iris_df)
print(kruskal.test)
#because p< 0.05, we reject the null of no differences among groups

#next, apply posthoc comparison to identify which classes (pairwise) are different from each other.
#we will use Pairwise Wilcoxon Rank Sum Tests with Bonferroni correction for multiple comparisons
pairwise.wilcox.test(iris_df$petal_length, iris_df$class, p.adjust.method = "bonferroni")
#all comparisons are significant 


