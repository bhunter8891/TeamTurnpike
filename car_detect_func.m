function [cars] = car_detect_func( Image )

I = imread(Image);
M2_B = [];
Image1_B = [];
Image2_B = [];
Image3_B = [];

% M1 is the intensity matrix
M1 = rgb2gray(I);
% r is number of rows of M1
% c is number of column of M1
r = size(M1,1);
c = length(M1);

% max to detect bright cars
% min to detect dark cars
for i = 1:r
   m = max(M1,[],2);
   M2_B = [m];
end

% T1,T2 and T3 are three thresholds to detect cars
T1_B = mean(M2_B);
T2_B = min(M2_B);
T3_B = mean([T1_B T2_B]);

for i = 1:r
    for j = 1:c
        if I(i,j) > T1_B
            Image1_B(i,j) = 1;
        end
        if I(i,j) < T1_B
            Image1_B(i,j) = 0;
        end
    end
end

for i = 1:r
    for j = 1:c
        if I(i,j) > T2_B
            Image2_B(i,j) = 1;
        end
        if I(i,j) < T2_B
            Image2_B(i,j) = 0;
        end
    end
end

for i = 1:r
    for j = 1:c
        if I(i,j) > T3_B
            Image3_B(i,j) = 1;
        end
        if I(i,j) < T3_B
            Image3_B(i,j) = 0;
        end
    end
end

% This is used to remove white lanes
% New_Image1 = bitand(Image1, Image2);
% New_Image2 = bitand(Image2, Image3);
% New_Image3 = bitand(Image1, Image3);
% Bright_cars = bitor (New_Image1, New_Image2, New_Image3);

%% Detect dark cars

M2_D = [];
Image1_D = [];
Image2_D = [];
Image3_D = [];

for i = 1:r
   n = min(M1,[],2);
   M2_D = [n];
end

% T1,T2 and T3 are three thresholds to detect cars
T1_D = mean(M2_D);
T2_D = max(M2_D);
T3_D = mean([T1_D T2_D]);

for i = 1:r
    for j = 1:c
        if I(i,j) > T1_D
            Image1_D(i,j) = 0; % brighter than T1, then it's not dark car
        end
        if I(i,j) < T1_D
            Image1_D(i,j) = 1; % darker than T1, then it's dark car
        end
    end
end

for i = 1:r
    for j = 1:c
        if I(i,j) > T2_D
            Image2_D(i,j) = 0;
        end
        if I(i,j) < T2_D
            Image2_D(i,j) = 1;
        end
    end
end

for i = 1:r
    for j = 1:c
        if I(i,j) > T3_D
            Image3_D(i,j) = 0;
        end
        if I(i,j) < T3_D
            Image3_D(i,j) = 1;
        end
    end
end

cars = [Image1_B Image1_D Image2_B Image2_D Image3_B Image3_D];