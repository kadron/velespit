function results = getResults(Te,func,w,l)
%getResults Returns the predicted demand by test results

nTe = size(Te,1);
results = zeros(nTe,1);

for i=1:nTe
    z = {zeros(l(1)+1,1),zeros(l(2)+1,1),zeros(l(3)+1,1),zeros(l(4),1)};
        
    %Forward pass
    z{1} = [1, Te(i,1:end)]';
    for j=2:length(l)
        temp = w{j-1}*z{j-1};
        if j == length(l)
            z{j} = temp;
        else
            z{j} = [1; arrayfun(func, temp)];
        end
    end
    results(i) = z{4};
end

end

