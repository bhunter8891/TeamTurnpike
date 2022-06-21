function [ Comps ] = basicSegmentation( imageFile )
% Basic segmentation method which does not sharpen or
% blur image. It finds the edges, dilates, and removes
% small components.

%Read in file, convert to grayscale
J = imread(imageFile);
I = rgb2gray(J);
I = imcomplement(I);
[x,y] = size(I); %%I just took this from the color code to get it to run (Kelsey)

%Get edges, and thicken
BWThin = edge(I,'Canny');
se90 = strel('line', 3, 90);
se0 = strel('line', 3, 0);
BWsdilThin = imdilate(BWThin, [se90 se0]);
blank = ~BWsdilThin;

%remove any small pieces
blank = bwareaopen(imfill(blank,'holes'),floor(x*y/100));

%get components
CCThin = bwconncomp(blank);
labeledThin = labelmatrix(CCThin);
RGB_labelThin = label2rgb(labeledThin, 'jet', 'w', 'shuffle');

imshowpair(J,RGB_labelThin, 'montage')


Comps = CCThin;

end

