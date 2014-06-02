
newkalmanfilter = cell(0,1);
locationInitialization = fishheadfilter('E:\data\fishresult\result_501.bmp',2,0.5);
trajectory = locationInitialization;
load('C:\Users\lx\Desktop\featureVector_8.txt')
for i = 1:length(locationInitialization)
    param = getDefaultParameters(locationInitialization(i,:));
    kalmanFilter = configureKalmanFilter(param.motionModel, ...
          param.initialLocation, param.initialEstimateError, ...
          param.motionNoise, param.measurementNoise);
    newkalmanfilter{end+1} = kalmanFilter;
end
img_curfilename = 'E:\data\fish\CoreView_269_Master_Camera_00501.bmp';
img_nextfilename = 'E:\data\fish\CoreView_269_Master_Camera_00502.bmp';
imgresultname = 'E:\data\fishresult\result_502.bmp';
nearlen = 2;
r = 0.5;
[newkalmanfilter,trajectory] = fishTracking(newkalmanfilter,trajectory,img_curfilename,img_nextfilename,imgresultname,nearlen,r,featureVector_8);


subplot(121);
imshow(imread(img_curfilename));
hold on
for i = 1:length(trajectory)
    plot(trajectory(i,2),trajectory(i,1),'+');
    text(trajectory(i,2)+2,trajectory(i,1)+2,num2str(i),'color',[1 0 0]);
end
    
subplot(122);
imshow(imread(img_nextfilename));
hold on
for i = 1:length(trajectory)
    plot(trajectory(i,4),trajectory(i,3),'+');
    text(trajectory(i,4)+2,trajectory(i,3)+2,num2str(i),'color',[1 0 0]);
end
