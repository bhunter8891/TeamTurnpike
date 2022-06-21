function [ abc ] = LineDrawer(img )
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here
abc=img;
hold on;
while 1>0
[x1,y1]=ginput(1);%Reads in coordiantes on click

x1=int32(x1);%UP IS DOWN AND DOWN IS UP! and converts to ints.
y1=int32(y1);

[x2,y2]=ginput(1);
x2=int32(x2);
y2= int32(y2);

x=[x1,x2];
y=[y1,y2];
plot(x,y,'LineWidth',10);
end

end

