function  greed( abc,tt )
grayd= im2bw(abc,tt);
[m,n]=size(grayd);
count = 0;
X = zeros(m,n);
cc = bwconncomp(grayd);
colormap(parula(cc.NumObjects));
for i =1:cc.NumObjects
    X(cc.PixelIdxList{i})=i;
end
imshow(X)
figure
for i=1:m
    for j = 1:n
        if grayd(i,j)==1
            abc(i,j,1)=0;
            abc(i,j,2)=0;
            abc(i,j,3)=255;
        end
    end
end






    
    


imshow(abc);

end

