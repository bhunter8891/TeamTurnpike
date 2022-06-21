function [Comps] = ext_grad_seg(imageFile)

%Segmentation method. 
%%Enchance external boundaries to be brighter than background and internal
%boundaries to be darker than their foreground. 
%Then uses Canny detection to find the edges which then segments it into
%its component parts.
%Returns a connectivity matrix of all the connected components 
%(See Matlab function bwconncomp for exacty details)

image = imread(imageFile);
ibw = rgb2gray(image); %convert to grayscale.
se = strel('square',10); %structural element to perform dilation over.
eg = imdilate(ibw,se) - ibw; %use a external gradient filter
rec = imreconstruct(eg,ibw); %reconstruct the image with a gradient marker.

f1 = edge(rec,'Canny'); %canny detection to find the edge.
%clear out many of the small connected components
fgm = imregionalmax(rec); 
fgm = bwareaopen(fgm,2000); 

labelmat = bwlabel(fgm); 
lgrb = label2rgb(labelmat,'jet','w'); 
figure(1)
imshow(image)
hold on; 
himage = imshow(lgrb);
himage.AlphaData = 0.3;

Comps = bwconncomp(fgm); 