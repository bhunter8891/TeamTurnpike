function [ Comps ] = blurSegmentation( imageFile )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

J = imread(imageFile);
I = rgb2gray(J);
I = imcomplement(I);
[x,y] = size(I);

seThick = strel('square', 20);
IoThick = imopen(I, seThick);

IeThick = imerode(IoThick, seThick);
IobrThick = imreconstruct(IeThick, I);

IobrdThick = imdilate(IobrThick, seThick);
IobrcbrThick = imreconstruct(imcomplement(IobrdThick), imcomplement(IobrThick));
IobrcbrThick = imcomplement(IobrcbrThick);

fgmThick = imregionalmax(IobrcbrThick);
fgmThick = edge(fgmThick);
fgmThick = bwmorph(fgmThick, 'thicken', 2);
seThick = strel('disk', 1);
closefgmThick = imclose(fgmThick,seThick);
BWThick = edge(closefgmThick,'Canny');
se90 = strel('line', 3, 90);
se0 = strel('line', 3, 0);
BWsdilThick = imdilate(BWThick, [se90 se0]);
BWsdilThick = bwfill(BWsdilThick,'holes');
CCThick = bwconncomp(~BWsdilThick,8);
labeledThick = labelmatrix(CCThick);
RGB_labelThick = label2rgb(labeledThick, 'jet', 'w', 'shuffle');
imshow(RGB_labelThick)

Comps = CCThick;

end

