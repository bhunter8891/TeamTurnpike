function [ Comps ] = imageSegmenter2( imageFile )
% Master function for the image segmentation. Calls each
% individual segmentation method we developed, gets all
% the components returned by the methods, and cleans up
% the list. Cleaning is done by seeing if two components
% are similar, in this case if their intersection is
% at least 90% of each, and if so, removes the smaller
% of the two.
%
% To add a segmentation method, add the following lines
% below the %######################:
% Compsx = yourSegmentationMethod(imageFile);
% CC.PixelIdxList = [CC.PixelIdxList Compsx.PixelIdxList];
% CC.NumObjects = CC.NumObjects + Compsx.NumObjects;
% 
% @inputs:
%       imageFile - name of picture to be read
% @outputs:
%       Comps - Final, succint list of components

%Read in image and initialize an empty component list
img = imread(imageFile);
[x,y] = size(img(:,:,1));
CC = bwconncomp(zeros(x,y));

%Get components from each segmentation method
%Then merge all the lists into one large list
Comps1 = blurSegmentation(imageFile);
Comps2 = basicSegmentation(imageFile);
Comps3 = colorBasedSeg(imageFile);
Comps4 = ext_grad_seg(imageFile);
Comps5 = Connected_Comp_Edges2(imageFile);
%#################################

CC.PixelIdxList = [CC.PixelIdxList Comps1.PixelIdxList];
CC.NumObjects = CC.NumObjects + Comps1.NumObjects;
CC.PixelIdxList = [CC.PixelIdxList Comps2.PixelIdxList];
CC.NumObjects = CC.NumObjects + Comps2.NumObjects;
CC.PixelIdxList = [CC.PixelIdxList Comps3.PixelIdxList];
CC.NumObjects = CC.NumObjects + Comps3.NumObjects;
CC.PixelIdxList = [CC.PixelIdxList Comps4.PixelIdxList];
CC.NumObjects = CC.NumObjects + Comps4.NumObjects;
CC.PixelIdxList = [CC.PixelIdxList Comps5.PixelIdxList];
CC.NumObjects = CC.NumObjects + Comps5.NumObjects;


CC = filter(CC,x,y);

labeledThin = labelmatrix(CC);
RGB_labelThin = label2rgb(labeledThin, 'jet', 'w', 'shuffle');
figure(2)
imshow(img)
hold on;
himage = imshow(RGB_labelThin);
himage.AlphaData = 0.3; 

Comps = CC;

end

%Subfunction which cleans up the long list of components
%by removing any components which are similar to another
%
% @inputs:
%       C1 - List of components to be cleaned
%       x - x dimension of image
%       y - y dimension of image
% @outputs:
%       C2 - Component list with unique components
function [C2] = filter(C1,x,y)
%Initialize an empty component
C2 = bwconncomp(zeros(x,y));
%Go through original list and remove any redundant components
for i = 1:C1.NumObjects
   for j = i+1:C1.NumObjects
       sizeFirst = length(C1.PixelIdxList{i});
       sizeSecond = length(C1.PixelIdxList{j});
       sizeIntersect = length(intersect(C1.PixelIdxList{i},C1.PixelIdxList{j}));
       if sizeIntersect >= 0.9*sizeFirst && sizeIntersect >= 0.9*sizeSecond
           if sizeFirst > sizeSecond
               C1.PixelIdxList{j} = [];
           else
               C1.PixelIdxList{i} = [];
           end
       end
   end
end
%Add the unique pieces to the new list
for i = 1:C1.NumObjects
    if ~isempty(C1.PixelIdxList{i}) 
        C2.PixelIdxList = [C2.PixelIdxList C1.PixelIdxList{i}];
        C2.NumObjects = C2.NumObjects + 1;
    end
end

end