function [w] = TwoLayerNN(Tr,E,func,eta,l)
%TwoLayerNN Neural network implementation with 2 hidden layers
%       Batch learning method is used in this function.
%       Stanford's MLP tutorial is used as a reference of implementation:
%	    http://ufldl.stanford.edu/tutorial/supervised/MultiLayerNeuralNetworks/
%
%   Inputs:
%       hiddenNum:  A vector which contains the number of 
%                       perceptrons in each hidden layer
%       eta:        Step size for learning
%       lambda:     Weight decay variable
%       E:          Number of epochs
%       func:       Activation function for perceptrons
%                       Usually sigmoid or tanh.
%       scale:      Used to divide every output by this scale to fit actual
%       regression values in [0,1]
%                       
%   Outputs:
%       w: Weights for each layer
%       b: Bias for each layer (except output)

%Initializing weight matrices and biases
n = size(Tr,2)-1;
l = [n, 20, 20, 1];

w1 = rand(l(2),l(1)+1)/5-0.1;
w2 = rand(l(3),l(2)+1)/5-0.1;
w3 = rand(l(4),l(3)+1)/5-0.1;
w  = {w1,w2,w3};
nTr = size(Tr,1);

for t = 1:E
    t
    %Shuffling the data
    Tr = Tr(randperm(size(Tr,1)),:);
    
    %Initializing gradient matrices for weights
    dW = {zeros(l(2),l(1)+1),zeros(l(3),l(2)+1),zeros(l(4),l(3)+1)};
    for i=1:nTr
        %Initializing layer variables and delta
        delta = {0,0,0,0};
        z = {zeros(l(1)+1,1),zeros(l(2)+1,1),zeros(l(3)+1,1),zeros(l(4),1)};
        
        %Forward pass
        z{1} = [1, Tr(i,1:end-1)]';
        for j=2:length(l)
            temp = w{j-1}*z{j-1};
            if j == length(l)
                z{j} = temp;
            else
                z{j} = [1; arrayfun(func, temp)];
            end
        end
        
        %Backward pass
        y = Tr(i,end);
        delta{end} = -(y-z{4}).*(z{4}.*(1-z{4}));
        for j = length(l)-1:2
            delta{j} = (w{j}'*delta{j+1}).*(z{j}.*(1-z{j}));
        end
        for j = length(l)-1:1
            dW{j} = delta{j+1}*(z{j}');
            w{j} = w{j} - eta*dW{j};
        end
    end
end

end
