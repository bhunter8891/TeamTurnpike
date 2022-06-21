function [ Comps ] = basicSegmentation2( imageFile )
% Basic segmentation method which does not sharpen or
% blur image. It finds the edges, dilates, and removes
% small components.
tic
%Read in file, convert to grayscale
J = imread(imageFile);
I = rgb2gray(J);
I = imcomplement(I);
[x,y] = size(I);

%Get edges, and thicken
BWThin = edge(I,'Canny');
se90 = strel('line', 3, 90);
se0 = strel('line', 3, 0);
BWsdilThin = imdilate(BWThin, [se90 se0]);
blank = ~BWsdilThin;

%remove any small pieces
blank = bwareaopen(imfill(blank,'holes'),floor(x*y/100));
%Do a median gaussian filter -- %Set a pixel to 1 if five or more pixels 
%in a 3X3 neighboorhood are ones
blank = conv2(double(blank), ones(4), 'same') >= 5;

%get components
CCThin = bwconncomp(blank);

%Code for displaying components alongside original image
%labeledThin = labelmatrix(CCThin);
%RGB_labelThin = label2rgb(labeledThin, 'jet', 'w', 'shuffle');
%imshow(RGB_labelThin)
toc 
%Code for putting segmented image over the original image. 
labeledThin = labelmatrix(CCThin);
RGB_labelThin = label2rgb(labeledThin, 'jet', 'w', 'shuffle');
figure(1)
imshow(J)
hold on;
himage = imshow(RGB_labelThin);
himage.AlphaData = 0.3; 

Comps = CCThin;

end

