% kalmanfilter:n*1�ľ��󣬱�����ÿ����Ҫ���Ź켣��kalmanfilter����
% trajectory:���ڸ��ŵĹ켣��������в�Ϊ���ʾ���ڸ��ٵĹ켣


function [newkalmanfilter,trajectory] = fishTracking(kalmanfilter,trajectory,img_curfilename,img_nextfilename,imgresultname,nearlen,r,randomfeaturevector)
    img_cur = imread(img_curfilename);
    img_next = imread(img_nextfilename);
%   �õ�ǰһ֡��ͷ��
%     trajectory_current_end = trajectory(end-1:end,find(trajectory(:,end)~=0));
%   �õ���һ֡��ͷ��
    next_head = fishheadfilter(imgresultname,nearlen,r);
%   ���ں�һ֡�ĵ��Ƿ���Ҫ�����¹켣��
    isNewTraj = zeros(length(next_head),1);
    [th,tw] = size(trajectory);
    kalmanfilter_index = 0;
%   �µ�kalmanfilter
    newkalmanfilter = cell(0,1);
    for i = 1:th
%       ��ÿһ��ǰһ֡��ͷ�����й���
        if(trajectory(i,tw)~=0)
            kalmanfilter_index = kalmanfilter_index+1;
            lincked = linkhead(trajectory(i,tw-1:tw),next_head,img_cur,img_next,100,randomfeaturevector);
    %       ����������ϣ�
            [h,~] = size(lincked);
            if h ~= 2        
    %       �������ˣ�
            elseif h ==2 
                predict(kalmanfilter{kalmanfilter_index});
                corrected = correct(kalmanfilter{kalmanfilter_index}, lincked(2,:));
                trajectory(i,tw+1) = corrected(1);
                trajectory(i,tw+2) = corrected(2);
                newkalmanfilter{end+1} = kalmanfilter{kalmanfilter_index};
%               ��Ҫ��isNewTraj�������Ƿ�������㣬����У�����Ϊ1������Ϊ0�ļ��뵽�¹켣��
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
