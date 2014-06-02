start = 2;
img_label = imread('E:\data\fishlabel\CoreView_269_Master_Camera_00001.bmp');
img_unlabel = imread('E:\data\fish\CoreView_269_Master_Camera_00001.bmp');
img_unlabel=medfilt2(img_unlabel,[3,3]);
R = img_label(:,:,1);
G = img_label(:,:,2);
B = img_label(:,:,3);
eye = (R==255).*(G==0).*(B==0);
head = 2*(R==0).*(G==255).*(B==0);
% % % % % % % % % % % % % % % % % % % % % % % 

% nearlen = 4
elseif start == 2
tic
for index = 512:520
    i = index;
%     img_label = imread(['E:\data\fishlabel2\' num2str(i) '.bmp']);
%     img_unlabel = imread(['E:\data\fish\' num2str(i) '.bmp']);
%     i = 10*(index-1)+1;
    if i < 10
        now = ['0000' num2str(i)];
    elseif i <100
        now = ['000' num2str(i)];
    elseif i <1000
        now = ['00' num2str(i)];
    elseif i <10000
        now = ['0' num2str(i)];
    end
%     img_label = imread(['E:\data\fishlabel2\CoreView_269_Master_Camera_' now '.bmp']);
    
    img_unlabel = imread(['E:\data\fish\CoreView_269_Master_Camera_' now '.bmp']);
    img_unlabel=medfilt2(img_unlabel,[3,3]);
    img_cut = img_unlabel<200;
%     R = img_label(:,:,1);
%     G = img_label(:,:,2);
%     B = img_label(:,:,3);
%     head = (R==255).*(G==0).*(B==0);
%     body = 2*(R==0).*(G==255).*(B==0);
%     fishmargin = 3*(R==0).*(G==0).*(B==255);
    sample =img_cut;
    neiblen = 8;

    
    featureVector = load('C:\Users\lx\Desktop\featureVector_8.txt');

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
    num = length(featureVector)/(neiblen*2+1);
    for vi = 1:num
        features(:,:,end+1) = fishRandomFeatureExtraction(img_unlabel,sample,neiblen,featureVector(((vi-1)*(neiblen*2+1)+1) : ((vi)*(neiblen*2+1)),:),0);
    end
    
    lables = [1,2,3];
    output = ['E:\data\fishfeature\features_' num2str(i) '.txt'];
    fishSaveFeatures(features,lables,sample,output);
    display([num2str(i) 'complete!']);
end
toc
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
end