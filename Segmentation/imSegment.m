function [ Comps ] = imSegment( imageFile )
% Basic segmentation method which does not sharpen or
% blur image. It finds the edges, dilates, and removes
% small components.

%Read file, keep original and gaussian blurred.
rgb = imread(imageFile);
rgbblur = imgaussfilt(rgb,1.1);

%%%% 'I' builds the edges to seperate intersecting roads.

%flipped grayscale
I = rgb2gray(rgb);
I = imcomplement(I);

%find edges (white) with Canny and thicken, parameters adjusted empirically.
I = edge(I, 'Canny', [0.05, 0.3]);
I = bwmorph(I, 'thicken', 1.1);

%fattens edges and connectes small gaps by dilating and coroding using
%squares for structure element (5x5 pixels), then shrinks the edges back to
%lines. Complement to make edges black (value zero).
se = strel('square', 5);   %25
I = imclose(I, se);
%I = bwmorph(I, 'shrink', 10);
I = imcomplement(I);

% J is going to segment regions into road-like objects and value -> 0 for
% things that aren't 

J = zeros(size(rgb(:,:,1)));
ss = size(J); 
for i = 1:ss(1)
    for j = 1:ss(2)
        J(i,j) = blackedOut(rgbblur(i,j,1), rgbblur(i,j,2),rgbblur(i,j,3));
    end
end

%H is componentwise multiplication, zeros out edges from I!

H = I .* J;


%Hfilt removes compnents of H with small pixel count, then we thiken the
%remaining "roads".
Hfilt = bwareaopen(H,300, 4);
Hfilt = bwmorph(Hfilt, 'thicken');

%build the connected compnent structure, label matrix, and the color the
%connected components differently
ccFilt= bwconncomp(Hfilt, 4);
labelFilt = labelmatrix(ccFilt);
roadsFilt = label2rgb(labelFilt, 'lines', 'w', 'shuffle');

figure
imshowpair(rgb,J, 'montage')

Comps = ccFilt

% CCH = bwconncomp(H, 4);
% labeledH = labelmatrix(CCH);
% roadsH = label2rgb(labeledH, 'jet', 'w', 'shuffle');

%Comps1 = CCH

%s = regionprops(CCH,'basic')
end



function z = blackedOut(a,b,c)
if max([abs(a-b), abs(b-c), abs(c-a)]) > 15  %17
    z = 0;
elseif max([a,b,c]) > 245  %68
    z = 0;
elseif min([a,b,c]) < 50 %110 %235  %170
    z = 0;
elseif b > max([a,c]) && max([abs(a-b), abs(b-c), abs(c-a)]) > 10   
    z = 0;
elseif a > max([b,c]) && max([abs(a-b), abs(b-c), abs(c-a)]) > 12   
    z = 0;
else
    z = 1;
end
end


    