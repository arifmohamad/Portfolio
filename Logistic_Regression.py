# Logistic regression for Breast Cancer clasification
# Note: the Code can be run on Jupyter or Google Colab veary easly!

#Importing the libraries fr Python
import pandas as pandas

# importing the dataset 
# source: "https://archive.ics.uci.edu/ml/datasets/breast+cancer"
# dataset name:breats_cancer
#format:CSV

dataset = pd.read_csv('breast_cancer.csv')
X = dataset.iloc[:, 1:-1].values # the independent variables
y = dataset.iloc[:, -1].values	# the dependent variable i.e the classification result

# we need to split the dataset into Training set and Test set, using Scikit learn
# it is a common practice to isolate 20% of the dataset for test purpose, that's why test_size=0.2
from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.2, random_state = 0)

# Trainig the model on the training set, using scikit learn's linear_model and LogisticRegression method
from sklearn.linear_model import LogisticRegression
classifier = LogisticRegression(random_state = 0)
classifier.fit(X_train, y_train)

# Making prediction on the tet set results.
# we perform this step to see how the ML logistic reg. model could make correct predcitions agains the refrence test dataset.
y_pred = classifier.predict(X_test)

# For better seeing the performance of the model, we can use the Confusion Matrix from Scikit learn's metrics model
from sklearn.metrics import confusion_matrix
cm = confusion_matrix(y_test, y_pred)
print(cm)