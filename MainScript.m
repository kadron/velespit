%%Multilayer Perceptron Regression Script

%TODO
%Get the results from test data
%Transform for submission
%Send to Kaggle

clear

ReadFile

tic;

TrainTest

elapsedTime = toc;
fprintf('Time passed: %g\n', elapsedTime);