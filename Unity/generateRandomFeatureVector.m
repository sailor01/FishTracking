% Ro generate a radom feature vector
% neiblen: half length of feature vecotr
% outfile: file to output feature vector
% append: need to append or create a new file? 1 for append, 0 for new
function featureVector = generateRandomFeatureVector(neiblen,outfile,append)
        neibsize = (2*neiblen+1)*(2*neiblen+1);
        onesize =( neibsize -1)/2;
        set = [1:onesize,(onesize +2) :neibsize];
        oneindex = randsample(set,onesize);
        zeroinde = neibsize + 1 - oneindex;

        %以上获得了那些作为正，那些作为负

        featureVector = -1*ones(2*neiblen+1,2*neiblen+1);
        featureVector(oneindex) = 1;
        featureVector(onesize+1) = 0;

if nargin < 3
    append = 0;
    
    if nargin < 2
        return;
    end
    if  append == 0
        dlmwrite(outfile,featureVector,' ');
    end
else
    if  append == 1
        dlmwrite(outfile,featureVector,'-append','delimiter',' ');
    end
end


