# R Programming Project for Predicting Unsubscription in Telecommunications Services
Churn prediction is essential in telecom to protect revenue, reduce costs, and enhance customer satisfaction. By identifying customers at risk of leaving, providers can take proactive measures, such as targeted promotions, to retain them. This not only ensures financial stability but also offers a competitive edge through tailored services and efficient decision-making. 

In this project, the analysis of Churn Prediction will be conducted using R Programming, covering tasks ranging from the initiation of library settings to the execution of Machine Learning Modeling stages. The results will be assessed through the utilization of Evaluation Metrics.

## Table of Contents
1.  Import Library
2.  Exploratory Data Analysis (EDA)
3.  Machine Learning Modelling
4.  Model Performance Metrics
5.  K-Means Clustering


## Library
The dataset for this project will be handled using the **Tidyverse**, a popular library for data manipulation and visualization. Within this library, familiar packages serve various purposes, such as **ggplot2** for visualization, **dplyr** for data manipulation, and **tidyr** for data tidying and reshaping.
``` R
# import library 
library("tidyverse")
```
## Exploratory Data Analysis (EDA)
After importing the library and reading data from <ins>Churn.csv</ins>, the subsequent step involves exploring the dataset, preparing it for further processing. This includes examining the dataset to determine the number of columns and rows, identifying its variables, and checking for any missing values (null).

A brief observation from this step reveals that the dataset consists of **18 columns** and **5000 rows**, with **no missing values**. Additionally, the variables are listed below:
- churn
- accountlength
- internationalplan
- voicemailplan
- numbervmailmessages
- totaldayminutes
- totaldaycalls
- totaldaycharge
- totaleveminutes
- totalevecalls
- totalevecharge
- totalnightminutes
- totalnightcalls
- totalnightcharge
- totalintlminutes
- totalintlcalls
- totalintlcharge
- numbercustomerservicecalls

Next, convert **character** variables, including **churn**, **voicemailplan**, and **internationalplan**, to the **factor** data type. Afterward, plot graphs to explore the relationship between the **churn** variable and the other 6 variables. An example of the output is shown below:

![download](https://github.com/ffasnil/Churn-Prediction-with-R-Programming/assets/89661712/4cb0b11a-a462-47e7-aa25-b671120a077c)


<ins>Note</ins>: 
<br> A **factor** is a data type for handling categorical variables, such as YES and NO. It essentials for statistical modeling and visualization, providing a structured way to represent and analyze data in distinct categories.

## Machine Learning Modelling
This process performs a random 80:20 split on the `churndata` to create training (`train_data`) and testing (`test_data`) sets before applying these datasets to a logistic regression model.
```R
# calculate number of rows
n <- nrow(churndata)

# random sample (size 80%) from 1 to n   
id <- sample(1:n, size = n*0.8)

# select data from id (random sample) for training  
train_data <- churndata[id, ]

# select data excluding a random sample for testing  
test_data <- churndata[-id, ] 
```
## Model Performance Metrics
In the previous process, evaluation metrics used to evaluate the model are Accuracy, Recall, Precision, and F1-Score. The result are shown below:
|  | accuracy | recall | precision | F1-Score
|  --------  |  -------  | -------  | -------  | -------  |
| Train | 86.65% | 20.28% | 58.38% | 30.84% | 
| Test | 86.70% | 56.36% | 22.14% | 31.43% | 

## K-Means Clustering
Moreover, in the last section of the .ipynb file, k-means clustering can be employed for segmenting churn data and conducting visualizations, as illustrated in the image provided below.

![download (1)](https://github.com/ffasnil/Churn-Prediction-with-R-Programming/assets/89661712/f9b93cf0-95fb-40bd-b595-ce874a5c8f87)

