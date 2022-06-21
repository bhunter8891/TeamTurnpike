I = imread('Road4.png');
J=imshow(I);
img = I;
thresh = 3;
brack = rgb2gray(img);
%[x0,y0] = ginput(1)
%[x,y]=getpixelposition(ginput(1));
abc=img;
[x1,y1]=ginput(1)


x1 =int32(x1)
y1 = int32(y1)
pixR =img(y1,x1,1);
pixG = img(y1,x1,2);
pixB = img(y1,x1,3);
figure
imshow(brack);

pixg = brack(x1,y1);

[m,n,xxx] = size(img);

for i = 1:m
    for j =1:n
        if (abs(img(i,j,1)-pixR)< thresh) && (abs(img(i,j,2)-pixG)<thresh) && (abs(img(i,j,3)-pixB)<thresh)
            abc(i,j,1)= 0;
            abc(i,j,2) = 0;
            abc(i,j,3) = 255;
        end
        if abs(brack(i,j)-pixg)<2
            brack(i,j) = 0;
        end
        
    end
end

brack(y1,x1)=0;
for i =-10:1:10
    for j =-10:1:10
        brack(y1-i,x1) = 0;
        brack(y1,x1-j)=0;
        brack(y1+i,x1)=0;
        brack(y1,x1+1)=0;
        abc(y1+i,x1,3) = 0;
        abc(y1+i,x1,2) = 0;
        abc(y1+i,x1,1) = 255;
        abc(y1,x1+j,3) = 0;
        abc(y1,x1+j,2) = 0;
        abc(y1,x1+j,1) = 255;
        abc(y1+i,x1+j,3) = 0;
        abc(y1+i,x1+j,2) = 0;
        abc(y1+i,x1+j,1) = 255;
    end
end

figure
imshow(abc);
figure
imshow(brack);