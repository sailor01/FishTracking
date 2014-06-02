% kalmanfilter:n*1的矩阵，保存了每个需要跟着轨迹的kalmanfilter对象
% trajectory:正在跟着的轨迹，最后两列不为零表示还在跟踪的轨迹


function [newkalmanfilter,trajectory] = fishTracking(kalmanfilter,trajectory,img_curfilename,img_nextfilename,imgresultname,nearlen,r,randomfeaturevector)
    img_cur = imread(img_curfilename);
    img_next = imread(img_nextfilename);
%   拿到前一帧的头部
%     trajectory_current_end = trajectory(end-1:end,find(trajectory(:,end)~=0));
%   拿到后一帧的头部
    next_head = fishheadfilter(imgresultname,nearlen,r);
%   对于后一帧的点是否需要建立新轨迹？
    isNewTraj = zeros(length(next_head),1);
    [th,tw] = size(trajectory);
    kalmanfilter_index = 0;
%   新的kalmanfilter
    newkalmanfilter = cell(0,1);
    for i = 1:th
%       对每一个前一帧的头部进行关联
        if(trajectory(i,tw)~=0)
            kalmanfilter_index = kalmanfilter_index+1;
            lincked = linkhead(trajectory(i,tw-1:tw),next_head,img_cur,img_next,100,randomfeaturevector);
    %       如果关联不上：
            [h,~] = size(lincked);
            if h ~= 2        
    %       关联上了：
            elseif h ==2 
                predict(kalmanfilter{kalmanfilter_index});
                corrected = correct(kalmanfilter{kalmanfilter_index}, lincked(2,:));
                trajectory(i,tw+1) = corrected(1);
                trajectory(i,tw+2) = corrected(2);
                newkalmanfilter{end+1} = kalmanfilter{kalmanfilter_index};
%               需要在isNewTraj里需找是否有这个点，如果有，就设为1，最后把为0的加入到新轨迹中
                for j = 1:length(isNewTraj)
                    if sum(next_head(j,:) == lincked(2,:)) == 2
                        isNewTraj(j) = 1;
                    end
                end
            end
        end
    end
    for i = 1:length(isNewTraj)
        if isNewTraj(i) == 0
            trajectory(end+1,tw+1) = next_head(i,1);
            trajectory(end,tw+2) = next_head(i,2);
            param = getDefaultParameters(next_head(i,:));
             kalmanFilter = configureKalmanFilter(param.motionModel, ...
                    param.initialLocation, param.initialEstimateError, ...
                    param.motionNoise, param.measurementNoise);
            newkalmanfilter{end+1} = kalmanFilter;
        end
    end
end
