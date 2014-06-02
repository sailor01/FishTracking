function features =  fishRandomFeatureExtraction(img,imgcut,neiblen,zeroone,needloc)
[imgheight,imgwidth] = size(img);
[point_need_FeaExtraction_x, point_need_FeaExtraction_y]= find(imgcut > 0);
features = zeros(imgheight,imgwidth);

for i = 1:length(point_need_FeaExtraction_x)
   if(point_need_FeaExtraction_x(i)>neiblen && point_need_FeaExtraction_x(i)< imgheight - neiblen && point_need_FeaExtraction_y(i)>neiblen && point_need_FeaExtraction_y(i)< imgwidth - neiblen )
       matrix_near = getMatrixNear(img,point_need_FeaExtraction_x(i),point_need_FeaExtraction_y(i),neiblen);
       matrix_one = double(matrix_near(find(zeroone  == 1)));
       matrix_zero = double(matrix_near(find(zeroone  == -1)));
       s = 1;
       if needloc == 1
            features(point_need_FeaExtraction_x(i),point_need_FeaExtraction_y(i),1) = point_need_FeaExtraction_x(i);
            features(point_need_FeaExtraction_x(i),point_need_FeaExtraction_y(i),2) = point_need_FeaExtraction_y(i);
            s = 3;
       end
       features(point_need_FeaExtraction_x(i),point_need_FeaExtraction_y(i),s) = sum(matrix_one) - sum(matrix_zero);
   end
end
end

function matrix_near = getMatrixNear(img,x,y,neiblen)
    x_leftup = x - neiblen;
    y_leftup = y - neiblen;
    
    x_righdown = x + neiblen;
    y_rightdown = y + neiblen;
    
    matrix_near = img(x_leftup:x_righdown,y_leftup:y_rightdown);
end