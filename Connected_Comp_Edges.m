function [ Comps ] = Connected_Comp_Edges( imageFile )

scrsz = get(groot,'ScreenSize');
rgb =imread(imageFile);
I = rgb2gray(rgb);
gsI = imgaussfilt(I, 1);
% figure('Position',[1 scrsz(4)/2 scrsz(3)/2 scrsz(4)/2]);
%I1 = imshow(I)
I2 = edge(gsI, 'Canny');
% pause(2)
% imshow(edge(gsI, 'Prewitt'))
% figure
% imshowpair(rgb, I, 'montage')

hy = fspecial('sobel');
hx = hy';
Iy = imfilter(double(I), hy, 'replicate');
Ix = imfilter(double(I), hx, 'replicate');
gradmag = sqrt(Ix.^2 + Iy.^2);
gfilt = imgaussfilt(gradmag, 2);
% figure
% imshow(gradmag,[]), title('Gradient magnitude (gradmag)')
% figure
% imshowpair(rgb, gfilt, 'montage'), title('Gradient magnitude (gradmag)')


se = strel('square', 10);
Io = imopen(I, se);

Ie = imerode(I, se);
Iobr = imreconstruct(Ie, I);

% figure
% imshow(Iobr)

Iobrd = imdilate(Iobr, se);
Iobrcbr = imreconstruct(imcomplement(Iobrd), imcomplement(Iobr));
Iobrcbr = imcomplement(Iobrcbr);

fgm = imregionalmax(Iobrcbr);
fgm = edge(fgm);
fgm = bwmorph(fgm, 'thicken', 2);

se = strel('disk', 2);
closefgm = imclose(fgm,se);

inv1 = imcomplement(closefgm);

CC1 = bwconncomp(inv1);

labeled = labelmatrix(CC1);
RGB_label = label2rgb(labeled, 'jet', 'w', 'shuffle');
imshowpair(rgb, RGB_label, 'montage')

% figure
% imshowpair(rgb, inv1, 'montage')
% 
% se = strel('square', 20);
% Io = imopen(I, se);
% 
% Ie = imerode(I, se);
% Iobr = imreconstruct(Ie, I);
% 
% % figure
% % imshow(Iobr)
% 
% Iobrd = imdilate(Iobr, se);
% Iobrcbr = imreconstruct(imcomplement(Iobrd), imcomplement(Iobr));
% Iobrcbr = imcomplement(Iobrcbr);
% 
% fgm = imregionalmax(Iobrcbr);
% fgm = edge(fgm);
% fgm = bwmorph(fgm, 'thicken', 2);
% 
% se = strel('disk', 1);
% closefgm = imclose(fgm,se);
% inv2 = imcomplement(closefgm);
% 
% % CC2 = bwconncomp(inv2)
% % 
% % figure
% % imshowpair(rgb, inv2, 'montage')
% 
% 
% 
% 
% I2 = I;
% I2(fgm) = 255;
% %figure
% %imshow(I2), title('Regional maxima superimposed on original image (I2)')
% 
% se2 = strel(ones(5,5));
% fgm2 = imclose(fgm, se2);
% fgm3 = imerode(fgm2, se2);
% 
% fgm4 = bwareaopen(fgm3, 20);
% I3 = I;
% I3(fgm4) = 255;
% % figure
% % imshow(I3)
% % title('Modified regional maxima superimposed on original image (fgm4)')
% 
% Edges2 = edge(I3, 'Prewitt');
% Edges2 = bwmorph(Edges2, 'thicken');
% % figure
% % imshowpair(rgb,Edges2, 'montage')
% 
% level = graythresh(Iobrcbr);
% bw = im2bw(Iobrcbr,level);
% % figure
% % imshow(bw), title('Thresholded opening-closing by reconstruction (bw)')
% 
% D = bwdist(bw);
% DL = watershed(D);
% bgm = DL == 0;
% % figure
% % imshow(bgm), title('Watershed ridge lines (bgm)')
% 
% gradmag2 = imimposemin(gradmag, bgm | fgm4);
% L = watershed(gradmag2);
% 
% I4 = I;
% I4(imdilate(L == 0, ones(3, 3)) | bgm | fgm4) = 255;
% edges = edge(I4);
% thickEdges = bwmorph(edges, 'thicken');
% figure
% imshowpair(edges,thickEdges, 'montage')
% title('Markers and object boundaries superimposed on original image (I4)')
Comps = CC1;
