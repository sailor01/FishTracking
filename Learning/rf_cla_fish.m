%     filefolder = 'E:\data\feature_lable2\';
%     filename = 'feature_lable_';
%     X_lable1 = dlmread([filefolder filename num2str(1) '.txt'],' ');
%     X_lable2 = dlmread([filefolder filename num2str(2) '.txt'],' ');
%     X_lable3 = dlmread([filefolder filename num2str(3) '.txt'],' ');
%     X_lable4 = dlmread([filefolder filename num2str(4) '.txt'],' ');
%     X_lable1 = X_lable1(X_lable1(:,1)~=0,:);
%     X_lable2 = X_lable2(X_lable2(:,1)~=0,:);
%     X_lable3 = X_lable3(X_lable3(:,1)~=0,:);
%     X_lable4 = X_lable4(X_lable4(:,1)~=0,:);
%     
%     j = 12;
%     X_lable1 = X_lable1(abs(X_lable1(:,j))<500,:);
%     X_lable2 = X_lable2(abs(X_lable2(:,j))<500,:);
%     X_lable3 = X_lable3(abs(X_lable3(:,j))<500,:);
%     X_lable4 = X_lable4(abs(X_lable4(:,j))<500,:);
%     
% 
%     Y = [ones(length(X_lable1),1);ones(length(X_lable2),1)*2;ones(length(X_lable3),1)*3;ones(length(X_lable4),1)*4];
%     X_withlocation = [X_lable1;X_lable2;X_lable3;X_lable4];
% %     Y = [ones(length(X_lable1),1);ones(length(X_lable2),1)*2];
% %     X_withlocation = [X_lable1;X_lable2];
%     X = X_withlocation(:,3:end);
%     [~,featurelen] =size(X);
%     X_feature_normal = zeros(featurelen,2);
%     X_normal = X;
%     for flen = 1:featurelen     
%         X_feature_normal(flen,1) = mean(X(:,flen));
%         X_feature_normal(flen,2) = std(X(:,flen),1);
%         X_normal(:,flen) = (X_normal(:,flen) - X_feature_normal(flen,1))/X_feature_normal(flen,2);
%     end
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% fish
    filefolder = 'E:\data\fishfeature\';
    filename = 'feature_lable_';
    X_lable1 = dlmread([filefolder filename num2str(1) '.txt'],' ');
    X_lable2 = dlmread([filefolder filename num2str(2) '.txt'],' ');
    X_lable3 = dlmread([filefolder filename num2str(3) '.txt'],' ');


    Y = [ones(length(X_lable1),1);ones(length(X_lable2),1)*2;ones(length(X_lable3),1)*3];
    X_withlocation = [X_lable1;X_lable2;X_lable3];
    X = X_withlocation(:,3:end);
    [~,featurelen] =size(X);
    X_feature_normal = zeros(featurelen,2);
    X_normal = X;
    for flen = 1:featurelen     
        X_feature_normal(flen,1) = mean(X(:,flen));
        X_feature_normal(flen,2) = std(X(:,flen),1);
        X_normal(:,flen) = (X_normal(:,flen) - X_feature_normal(flen,1))/X_feature_normal(flen,2);
    end
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

pstart = 2;
if pstart == 1;


    opts= struct;
    opts.depth= 20;
    opts.numTrees= 4;
    opts.numSplits= 7;
    opts.verbose= true;
    opts.classifierID= [2]; % weak learners to use. Can be an array for mix of weak learners too
    display('start training');
    
    tic;
%     m= forestTrain(X, Y, opts);
    m= forestTrain(X_normal, Y, opts);
    toc
%      save_m = ['E:\data\luren\model\' 'model_' num2str(opts.depth) '_'  num2str(opts.numTrees) '_p4_10vec'];
%      save save_m m;
%     pstart = 2;
elseif pstart == 2; 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%300-122
%606-98
%912-98
%1220-134
% load E:\data\zhang\model\model_16_4_p4_vec8_allpeople_3_31.mat
imgsavefolder = 'E:\data\fishresult\';
% featureStart = [300,606,912,1220];
% featureNum = [110,98,98,134];
featureStart = [502];
featureNum = [510];

% featureStart =[910,1156,1482];
% featureNum = [110,100,88];
step = 1;
for imgnamepairs = 1:length(featureStart)
    for index = featureStart(imgnamepairs) :step: featureStart(imgnamepairs)+featureNum(imgnamepairs)
        tic
        X_test_read = dlmread(['E:\data\fishfeature\features_' num2str(index) '.txt'],' ');
        X_test_read = X_test_read(X_test_read(:,1)~=0,:);
        X_test = X_test_read(:,3:end-1);
        X_real = X_test_read(:,end);
        X_test_location = X_test_read(:,1:2);
        X_test_normal = X_test;
        for flen = 1:featurelen     
            X_test_normal(:,flen) = (X_test_normal(:,flen) - X_feature_normal(flen,1))/X_feature_normal(flen,2);
        end
        
        display('start prediction');
        [yhatTrain,ysoft] = forestTest(m, X_test_normal);
         toc
%         subplot(131);
%         area(yhatTrain);
%         subplot(132);
%         area(X_real);
        sum(X_real == yhatTrain)/length(yhatTrain);


        % plot


        if index < 10
            now = ['0000' num2str(index)];
        elseif index <100
            now = ['000' num2str(index)];
        elseif index <1000
            now = ['00' num2str(index)];
        elseif index <10000
            now = ['0' num2str(index)];
        end
        img_draw = imread(['E:\data\fishdraw\CoreView_269_Master_Camera_' now '.bmp']);

        for j = 1:length(X_test_location)
            if X_test_location(j,1)~= 0 && X_test_location(j,2)~=0
                if max(ysoft(j,:)) > 0.9
                    switch yhatTrain(j)
                        case 1
                            img_draw(X_test_location(j,1), X_test_location(j,2),1) = 255;
                            img_draw(X_test_location(j,1), X_test_location(j,2),2) = 0;
                            img_draw(X_test_location(j,1), X_test_location(j,2),3) = 0;
                        case 2
                            img_draw(X_test_location(j,1), X_test_location(j,2),1) = 0;
                            img_draw(X_test_location(j,1), X_test_location(j,2),2) = 255;
                            img_draw(X_test_location(j,1), X_test_location(j,2),3) = 0;
                        case 3
                            img_draw(X_test_location(j,1), X_test_location(j,2),1) = 0;
                            img_draw(X_test_location(j,1), X_test_location(j,2),2) = 0;
                            img_draw(X_test_location(j,1), X_test_location(j,2),3) = 255;
                    end
                end
            end
        end
        hold off;
%         imshow(img_draw);
       
        img_needsave = [imgsavefolder 'result_' num2str(index) '.bmp'];
        try        
            imwrite(img_draw,img_needsave,'bmp');
            display([img_needsave ' saved succeeded']);
        catch
            display([img_needsave ' saved failed']);
        end
     end
end
end