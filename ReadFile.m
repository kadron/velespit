%Reading Data
trainFMT = '%s %f %f %f %f %f %f %f %f %f %f %f';
testFMT = '%s %f %f %f %f %f %f %f %f';

train = reader('data\train.csv', trainFMT);
test = reader('data\test.csv', testFMT);

%Changing discrete variables to vectors
%Also removing the difference of casual/registered for now

train = [train(:,1:2) train(:,3:4)+1 train(:,5:end-3) train(:,end)];
test = [test(:,1:2) test(:,3:4)+1 test(:,5:end)];