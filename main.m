%% Reading Data Format
trainFMT = '%s %f %f %f %f %f %f %f %f %f %f %f';
testFMT = '%s %f %f %f %f %f %f %f %f';

train = reader('train.csv', trainFMT);
test = reader('test.csv', testFMT);

%Changing discrete variables to be between 1-n
%Also removing the difference of casual/registered for now
%Day of week(1), year(2), month(3), day(4), hour(5), season(6), holiday(7), workingday(8), weather(9) ....
train = [train(:,1) train(:,2)-2010 train(:,3:4) train(:,5)+1 train(:,6) train(:,7:8)+1 train(:,9:end-3) train(:,end)];
test = [test(:,1) test(:,2)-2010 test(:,3:4) test(:,5)+1 test(:,6) test(:,7:8)+1 test(:,9:end)];

%% Ordinary ELM

num_skip = 1;

tic
data = train(1:num_skip:end,1:end-1);
label = log(train(1:num_skip:end,end)+1);
label = label';

%Number of training/validation data points
numTot = size(data,1);
numTr = 5000;
numTs = numTot - numTr;

%Hyperparameters of ELM
numNeurons = 750;
C = 0.1;

numTrial = 9;
elmPerf = 0;

testScores = zeros(size(test,1),numTrial);
for i=1:numTrial
    %Mixing and seperating training and validation data
    randList = randperm(numTot);
    
    indTr = randList(1:numTr);
    indTs = randList(numTr+1:end);
    
    dataTr = (data(indTr,:));
    dataTs = (data(indTs,:));
    lblTr = label(indTr);
    lblTs = label(indTs);
    
    %Training data 
    [inW, bias, outW] = elmTrain(dataTr',lblTr,numNeurons,C);
    elmScores = elmPredict(dataTs',inW,bias,outW);
    elmPerf = elmPerf + sqrt(sum((exp(elmScores)-exp(lblTs)).^2));
    
    testScores(:,i) = elmPredict(test',inW,bias,outW);
    testScores(:,i) = exp(testScores(:,i))-1;
end

%Obtaining median and mean results
testScoresMed = median(testScores,2);
testScoresAvg = mean(testScores,2);
writeResults('elmSubmissionMed2.csv',test,testScoresMed);
writeResults('elmSubmissionAvg2.csv',test,testScoresAvg);

clc
fprintf('%d\n',numTr);
fprintf('%d\n',numTs);
fprintf('ELM MSE Performance is: %f\n',elmPerf / numTrial / numTs);
toc
