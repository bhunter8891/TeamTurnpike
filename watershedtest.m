%Test for road images. 

%load the image and put it into grayscale. 
road = imread('RoadPic2.png');
I = rgb2gray(road);

se = strel(ones(15,15)); %3 x 3 square of ones is the structure of the filter
%Morphogoical gradient options
basic_gradient = imdilate(I,se)-imerode(I,se); 
%Enchances internal boundaries of objects brighter than their background
%and the external objects darker than their background
internal_gradient = I - imerode(I,se); 
%Does the opposite of the internal_gradient. 
external_gradient = imdilate(I,se) - I; 

%finding the forground of the picture.
rec = imreconstruct(external_gradient,I); 
fgm = imregionalmax(rec);
%Superimpose foreground onto the original
% I2 = I; 
% I2(fgm) = 255; 
% figure
% imshow(I2)

%Remove isolate pixels than are smaller than a specified number;
%Basically to clean things up so that only roads (i.e. long connected
%stretches, are detected. 
fgm4 = bwareaopen(fgm,12000);
I3 = I; 
I3(fgm4) = 255; 
% figure
% imshow(I3)

%Find the background of the image 
BW = edge(I3,'sobel');
D = bwdist(bw); 
DL = watershed(D);
bgm = DL == 0;

%this highlights the road -- currently hardcoded in based on experiments. 
gradmag2 = imimposemin(external_gradient, bgm | fgm4);
L = watershed(gradmag2);
%for k = 1:max(max(L))
%    Lrgb = label2rgb(L == k, 'jet', 'w');
%    figure
%    imshow(Lrgb)
%end
Lrgb = label2rgb(L == 4,'jet','w'); 

% title('Colored watershed label matrix (Lrgb)')
 figure
 imshow(road)
 hold on
 himage = imshow(Lrgb);
 himage.AlphaData = 0.3;
 title('Lrgb superimposed transparently on original image')


%Interal and external graident seem to eliminate the most noise for the
%example problem. 
%figure(1)
%imshow(basic_gradient)
% figure(3)
% imshow(internal_gradient)
% figure(4)
% imshow(external_gradient)

