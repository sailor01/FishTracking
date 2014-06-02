function fishSaveFeatures(features,lables,lableimg,filename)
    fsize = size(features);
    lablenum = length(lables);
    reshapr_thislable = zeros(0,fsize(3)+1);
    for li = 1:lablenum
        [point_x, point_y]= find(lableimg == li);
        
        for index = 1:length(point_x)
             thislable = features(point_x(index),point_y(index),:);
             %------取到了这个lable下的特征，一个三维向量1*1*f;
             re_thislable = reshape(thislable,1,fsize(3));
             re_thislable(:,end+1) = lables(li);
             reshapr_thislable =  [reshapr_thislable ; re_thislable];
        end
    end
    dlmwrite(filename,reshapr_thislable,' ');
end