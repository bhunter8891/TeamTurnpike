%%% With current Paramenters, only works with RoadPic.png...

function [Comp1, Comp2] = AltSegmenting(image)

scrsz = get(groot,'ScreenSize');
rgb = imread(image);
%rgb = imadjust(rgb2,[.2 .3 0; .6 .7 1],[]);
red = rgb(:,:,1);
green = rgb(:,:,2);
blue = rgb(:,:,3);
I = (0.333 * red + 0.333 * green + 0.333 * blue);

%I = imadjust(J);
gsI = imgaussfilt(I, 1);
% figure('Position',[1 scrsz(4)/2 scrsz(3)/2 scrsz(4)/2]);
%I1 = imshow(I)

se = strel('square', 25);
Io = imopen(gsI, se);

Ie = imerode(gsI, se);
Iobr = imreconstruct(Ie, gsI);

% figure
% imshow(Iobr)

Iobrd = imdilate(Iobr, se);
Iobrcbr = imreconstruct(imcomplement(Iobrd), imcomplement(Iobr));
Iobrcbr = imcomplement(Iobrcbr);

se = strel('disk', 1);

I2 = imregionalmax(Iobrcbr);
I2 = bwmorph(I2, 'skel', Inf);
I2 = bwmorph(I2, 'spur', Inf);
I2 = I2 - bwmorph(I2, 'majority');


% I2 = bwmorph(I2, 'skel', Inf);
% I2 = bwmorph(I2, 'spur', Inf);
% I2 = I2 - bwmorph(I2, 'majority');
I2 = bwmorph(I2, 'thicken', 8);
I2 = imclose(I2,se);




inv1 = imcomplement(I2);

CC1 = bwconncomp(inv1, 4)
CC2 = bwconncomp(I2, 4);



labeled1 = labelmatrix(CC1);
labeled2 = labelmatrix(CC2);
labeled = labeled1 + (CC1.NumObjects())*labeled2;
RGB_label = label2rgb(labeled, 'jet', 'w', 'shuffle');
RGB_label1 = label2rgb(labeled1, 'jet', 'w', 'shuffle');
RGB_label2 = label2rgb(labeled2, 'jet', 'w', 'shuffle');


figure(1)
imshowpair(rgb, RGB_label, 'montage')
% figure(2)
% imshowpair(rgb , RGB_label, 'montage')
Comp1 = CC1;
Comp2 = CC2;