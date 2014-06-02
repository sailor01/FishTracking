% filefolder = 'E:\data\feature_lable2\';
% featurefolder = 'E:\data\luren\features\';
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% fish
filefolder = 'E:\data\fishfeature\';
featurefolder = 'E:\data\fishfeature\';
% % % % % % % % % % % % % % % % % % % % % % % % % % % 
featurename = 'features_';
filename = 'feature_lable_';
% featureStart = [300,606,912,1220];
% featureNum = [110,98,98,130];
% 
featureStart =[1];
featureNum = [41];
step = 1;
for imgnamepairs = 1:length(featureStart)
%     Ëæ»ú²ÉÑù
    over = 0;
    for i = featureStart(imgnamepairs):step:featureStart(imgnamepairs)+featureNum(imgnamepairs)
        if over ~= 4
            feature_to_read = [featurefolder featurename num2str(i) '.txt'];
            try
                [lables ,features ,areas ] = readdata(feature_to_read);
            catch 
                continue;
            end
            for j = 1:length(lables)
                ft = [filefolder filename num2str(j) '.txt'];
                fn(j,:) = ft(1,:);
            end
            combinedata(fn,lables ,features ,areas)
            display([num2str(i) 'th is combined!']);
            over = over+1;
        else
            over = 0;
            continue;
        end
    end
end 