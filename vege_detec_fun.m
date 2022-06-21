function [trees] = vege_detec_fun( Img )

%% Detect light green vegetation
Image1 = imread(Img);
Image2 = [];
[row column page] = size(Image1);

% [0 0 0] is black by MATLAB standard

for i = 1:row
    for j = 1:column
        if (Image1 (i, j, 2) > Image1(i, j, 1) && Image1(i, j, 2) > Image1(i, j, 3))
            Image2 (i, j, 1) = 1;
            Image2 (i, j, 2) = 1;
            Image2 (i, j, 3) = 1;
        else
            Image2 (i, j, 1) = 0;
            Image2 (i, j, 2) = 0;
            Image2 (i, j, 3) = 0;
        end
    end
end

%% Detect dark green image
for i = 1:row
    for j = 1:column
        Green = Image1(i,j,2) + 20;
        if (Green > Image1(i, j, 1) && Green > Image1(i, j, 3))
            Image2(i,j,1) = 1;
            Image2(i,j,2) = 1;
            Image2(i,j,3) = 1;
        else
            Image2(i,j,1) = 0;
            Image2(i,j,2) = 0;
            Image2(i,j,3) = 0;
        end
    end
end

%% Prevent shades of gray
[row2 column2 page2] = size(Image2);
for i = 1:row2
    for j = 1:column2
        for k = 1:page2
            if Image2(i,j,k) > 150
                Image2(i,j,k) = 0;
            end
        end
    end
end

trees = Image2;
