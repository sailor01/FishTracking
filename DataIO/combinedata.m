function combinedata(filename,lables ,features ,areas)
for i = 1:length(lables)
    data_for_combine = features(areas(i,2):areas(i,3),:);
    dlmwrite(filename(areas(i,1),:),data_for_combine,'-append','delimiter',' ');
end