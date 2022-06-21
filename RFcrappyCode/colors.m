figure, hold on;

x = 1:200;
y=1:200;
a = zeros(255*3,255*3,3)
for i = 1:255
    for j=1:5:255
        a(i,j,1) = i;
        a(i,j,2) = i;
        a(i,j,3) = i;
    end
end
imshow(a);
        