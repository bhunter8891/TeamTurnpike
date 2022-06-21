function hough1(abc)
grabc= rgb2gray(abc);
a1 = edge(grabc,'canny',.5);
figure, imshow(a1)

%[H,T,R] = hough(a1);
[H,T,R]= hough(a1,'RhoResolution',.7,'Theta',-90:1:89.5);
figure 
imshow(H);


P =houghpeaks(H,10);
x=T(P(:,2)); y= R(P(:,1));

figure
plot(x,y,'s','color','white');
lines= houghlines(a1,T,R,P,'FillGap',20,'MinLength',5);

figure, imshow(abc),hold on
for k=1:length(lines)
xy = [lines(k).point1;lines(k).point2];
plot(xy(:,1),xy(:,2),'LineWidth',4,'Color','blue');
plot(xy(1,1),xy(1,2),'x','LineWidth',4,'Color','red');
plot(xy(2,1),xy(2,2),'x','LineWidth',4,'Color','green');
end
%{
figure
imshow(imadjust(mat2gray(H)))
%}
end