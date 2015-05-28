function writeResults(filename,test,testScores)
%Writes a submission file for Kaggle competition
	testScores = round(testScores);
	testScores(testScores<0) = 0;
	fid = fopen(filename,'w');
	fprintf(fid,'datetime,count\n');
	for i = 1:size(test,1)
		ms = '';
		hs = '';
		if(test(i,3)<10); ms='0'; end
		if(test(i,5)-1<10); hs='0'; end
		fprintf(fid,'%d-%s%d-%d %s%d:00:00,%d\n',...
		    test(i,2)+2010,ms,test(i,3),test(i,4),hs,test(i,5)-1,...
		    testScores(i));
	end
	fclose(fid);
	
end