%%Multilayer Perceptron Regression Script

%TODO
%Feed data to neural network
%Backpropagation, etc.
%Get the results from test data
%Transform for submission
%Send to Kaggle

%Reading Data
trainFMT = '%s %f %f %f %f %f %f %f %f %f %f %f';
testFMT = '%s %f %f %f %f %f %f %f %f';

train = reader('data\train.csv', trainFMT);
test = reader('data\test.csv', testFMT);

%Changing discrete variables to vectors
%Also removing the difference of casual/registered for now
%We can have seperate trainers in later stages
train = [train(:,1) dummyvar(train(:,2:5)) train(:,6:9) train(:,12)];
test = [test(:,1) dummyvar(test(:,2:5)) test(:,6:9)];

%TODO Feeding Training data to ANN
hiddenNum = [9,9];

sigmoid = @(t) 1./(1+exp(-t));
eta = 0.02;
runtime = 1000;
%Neural Network Implementation

%TODO Feeding Test data to ANN, get the results