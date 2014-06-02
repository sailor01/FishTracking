function [lables ,features ,areas ]= readdata(filename)
try
    data = textread(filename);
catch
    display(['cant open file ' filename]);
    exception = MException('cant open file');
    throw(exception);
end
% size = size(data);
lable = data(:,end);
lables = unique(lable);
current = 0;

features = data(:,1:end-1);
for i = 1:length(lables)
    num = sum(sum(lable == lables(i)));
    areas(i,1) = lables(i);
    areas(i,2) = current+1;
    areas(i,3) = current+ num;
    current = areas(i,3);
end
clear data;