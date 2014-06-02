function headcenter = fishheadfilter(filenmae,nearlen,r)
img = imread(filenmae);
R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);
head = (R==255).*(G==0).*(B==0);
[x,y] = find(head == 1);
head_filter = zeros(0,2);
for i = 1:length(x)
    rate = nearfilter(x(i),y(i),head,nearlen);
    if rate > r
        head_filter(i,1) = x(i);
        head_filter(i,2) = y(i);
    end
end


head_filter = head_filter(find(head_filter(:,1)~=0),:);
point_represent = findRepresentPoint(head_filter,10);
[h,~] = size(point_represent);
headcenter = size(h,2);
for i = 1:h
    pm = sum(point_represent(i,:)>0);
    mxy = [0,0];
    for j = 1:pm
        mxy = mxy + head_filter(point_represent(i,j),:);
    end
    mxy = mxy/pm;
    headcenter(i,1) = mxy(1);
    headcenter(i,2) = mxy(2);
end
% imshow(img);hold on;
% plot(headcenter(:,2),headcenter(:,1),'yo');
end

function rate =  nearfilter(x,y,img,nearlen)
[imgheight,imgwidth] = size(img);
    if(x < 1+nearlen || x > imgheight - nearlen || y < 1+nearlen || y > imgwidth - nearlen) 
        rate = 0;
    else
        matrix = img(x-nearlen:x+nearlen,y-nearlen:y+nearlen);
        rate = sum(sum(matrix))/((2*nearlen +1)*(2*nearlen +1));
    end
end

function point_represent = findRepresentPoint(pointset,mindis)
headset = zeros(0,0);
for i = 1:length(pointset)
   [headnum,~] = size(headset);
   flag = 0;
   if headnum >0 && headnum >0
       md = inf;
       mindex = 0;
       [headnum,~] = size(headset);
       for j = 1:headnum
           distance = 0;
           vectemp = headset(j,:);
           pm = sum(vectemp > 0);
           for k = 1:pm
               a = pointset(i,:);
               b = pointset(headset(j,k),:);
               distance = distance + sqrt(sum((a-b).*(a-b)));
           end
           distance = distance/pm;
           if distance < md
               md = distance;
               mindex = j;
           end
       end
       if md < mindis           
           vectemp = headset(mindex,:);
           pm = sum(vectemp > 0);
           headset(mindex,pm+1) = i;
           flag = 1;
       end
   end
   if flag == 0
       headset(end+1,1) = i;
   end
end
point_represent = headset;
end