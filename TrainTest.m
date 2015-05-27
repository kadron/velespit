%Feeding Training data to ANN
sigmoid = @(t) 1./(1+exp(-t));
eta = 0.9;
lambda = 0.5;
epoch = 200;
scale = 1000;

n = size(test,2);
l1 = [n, 200, 200, 1];

l2 = [n, 200, 1];

%Training MLP
w1 = TwoLayerNN(train,epoch,sigmoid,eta,l1);
results1 = getResults(test,sigmoid,w1,l1);


%Getting test results using test data and trained weights
pause

w2 = OneLayerNN(train,epoch,sigmoid,eta,l2);
results2 = getResults(test,sigmoid,w2,l2);