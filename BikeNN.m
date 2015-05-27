function [w,v] = BikeNN(Tr,eta,E,sigmoid)
%BikeNN Neural network implementation for bike sharing data
%   Inputs:
%       hiddenNum: A vector which contains the number of 
%                   perceptrons in each hidden layer
%       eta:       Step size for learning
%       epoch:     Number of epochs
%   Outputs:
%       w,v: Weights for hidden and output layers

Tr = [ones(size(Tr,1),1), Tr];
n = size(Tr,2)-1;
n2 = 1200;
w = rand(n,n2)/50-0.01;
nW = size(w,1);
v = rand(1,n2+1)/50-0.01;
nV = length(v);
nTr = size(Tr,1);

for t = 1:E
    t
    %Shuffling the data
    Tr = Tr(randperm(size(Tr,1)),:);
    for i=1:nTr
        %Finding values of hidden layer
        tz = zeros(1,n2);
        for j=1:nW
            for k = 1:n2
                tz(k) = tz(k) + Tr(i,j)*w(j,k);
            end
        end
        z = [1, sigmoid(tz)];
        %Finding value of output
        ty = 0;
        for j=1:nV
            ty = ty + z(j)*v(j);
        end
        y = ty;
        
        %Finding gradient of weights
        dw = zeros(size(w));
        dv = eta*(Tr(i,end)-y)*z;
        for k = 1:n2
            dw(:,n2) = eta*(Tr(i,end)-y)*v(n2+1)*z(n2+1)*(1-z(n2+1))*Tr(i,1:end-1);
        end
        size(dw)

        v = v + dv;
        w = w + dw;
    end
end

end
