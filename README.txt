Name: Template Project Directory for Git/GitHub Workshop
Author: Donald Dunagan, dgd45125@uga.edu
Date: 10 October 2026

Description: This is template project directory for teaching Git/GitHub. It is meant to be representative of the contents and organization of a small-scale data analysis project. 


Files and Directories:
	README.txt --- This file.
	analysis.R --- A simple analysis script written in R that analyses petal length in the Iris Dataset. Summary statistics are calculated for petal length by iris class, a petal length by class box plot is created, a one-way ANOVA is estimated, and posthoc Tukey's honest significance is used for pairwise comparisons.
	iris.csv --- A comma-separated value file containing sepal and petal measurements from 150 iris flower observations. The dataset was downloaded from the UC Irvine Machine Learning Repository (https://archive.ics.uci.edu/dataset/53/iris), who make it available under CC BY 4.0.
	   
	      
Data Dictionary for iris.csv:
	sepal_length: continuous; sepal length for the observation, in cm.
	sepal_width: continuous; sepal width for the observation, in cm.
	petal_length: continuous; petal length for the observation, in cm.
	petal_width: continuous; petal width for the observation, in cm.
	class: categorical; iris class; one of either: Iris-setosa, Iris-versicolor, or Iris-virginica.
  