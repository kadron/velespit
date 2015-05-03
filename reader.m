function A = reader(filename,fmt)
%READER This function reads and streamlines the training and test data
%   Detailed explanation goes here
fid = fopen(filename);
a = textscan(fid, fmt, 'delimiter', ',',...
    'CollectOutput',1, 'HeaderLines',1);
A = [datenum(a{1}) a{2}];

%Changing the vars where weather==4 (only 3 data points)
for i=1:size(A,1)
    if A(i,5) == 4
        A(i,5) = 3;
    end
end

fclose(fid);
end