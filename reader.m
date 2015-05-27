function A = reader(filename,fmt)
%READER This function reads and streamlines the training and test data

%Reading the file
fid = fopen(filename);
a = textscan(fid, fmt, 'delimiter', ',',...
    'CollectOutput',1, 'HeaderLines',1);
%Transforming date into vectors to extract hour and day of week
temp1 = datevec(a{1},'yyyy-mm-dd HH:MM:SS');
[temp2, ~] = weekday(datenum(a{1},'yyyy-mm-dd HH:MM:SS'));
A = [temp2 temp1(:,4) a{2}];

%Changing the vars where weather==4 (only 3 data points)
for i=1:size(A,1)
    if A(i,6) == 4
        A(i,6) = 3;
    end
end

fclose(fid);
end