function [ Comps ] = colorBasedSeg( imageFile )
% Color-based segmentation. First blurs the image, then
% adds components based on gray scale color values.
%
% @inputs:
%       imageFile - name of image file
% @outputs:
%       Comps - List of components which are candidates for
%               being a road

% Read file, convert to grayscale
J = imread(imageFile);
I = rgb2gray(J);
I = imcomplement(I);
[x,y] = size(I);
blank = zeros(x,y);
scr = blank;

% Blur image
seThick = strel('square', 20);
IoThick = imopen(I, seThick);
IeThick = imerode(IoThick, seThick);
IobrThick = imreconstruct(IeThick, I);
IobrdThick = imdilate(IobrThick, seThick);
IobrcbrThick = imreconstruct(imcomplement(IobrdThick), imcomplement(IobrThick));
IobrcbrThick = imcomplement(IobrcbrThick);

% Initialize a component list (empty)
CC = bwconncomp(scr);

% Add components based on pixel values
% TODO: Nested loop causes slow performance, find alternative way
for i = 0:255
    C = IobrcbrThick == i;
    C = bwareaopen(imfill(C,'holes'),floor(x*y/100));
    C = bwconncomp(C,8);
    for j = 1:C.NumObjects
        CC.PixelIdxList = [CC.PixelIdxList C.PixelIdxList{j}];
        CC.NumObjects = CC.NumObjects + 1;
    end
end

labeled = labelmatrix(CC);
RGB_label = label2rgb(labeled, 'jet', 'w', 'shuffle');

%imshow(RGB_label)
%Transposes the color segmentation onto the original image. 
figure(1)
imshow(J)
hold on; 
himage = imshow(RGB_label);
himage.AlphaData = 0.3;

Comps = CC;

end

