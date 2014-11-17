%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%function Im = perspectiveTransform()
%
%Receives an original image and uses perpective transformation to transform it to
%a straight, readable image.
%Returns straight, grayscale image.
%Part of a pattern recognition project TNM034 - Advanced Image Processing, Linköping
%University HT2014.
%
%Copyright (c) <2014> Karolin Jonsson, Louise Carlström, Linnea Nåbo, Linnea Mellblom
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function transformed = perspectiveTransform(Im, col_values, row_values)
% In working progress, does not receive any image or points as function
% parameters.

% Make the new image the same size as the current (not necessary the best
% option)
Im = rgb2gray(Im);
[width,height] = size(Im);

% Calculate true values
% Find max distance:
dist_1 = abs((row_values(1) - row_values(2)));
dist_2 = abs((col_values(3) - col_values(2)));

dist_max = max(dist_1, dist_2);
dist_min = dist_max*0.09756;

col_values_true = [dist_min;          dist_min; dist_min+dist_max; dist_max+dist_min];
row_values_true = [dist_max+dist_min; dist_min; dist_min         ; dist_max+dist_min];


% Select the points in the image and the reference image
number_of_points = 4;

% Collect coordinates from the image and the reference image
false_pic = [row_values(:) col_values(:) ones(number_of_points,1)] %values of the false pic
true_pic = [row_values_true(:) col_values_true(:) ones(number_of_points,1)] %values of the true pic

% Find transformation matrix
x = false_pic\true_pic;

% Fit geometry
[X,Y] = meshgrid(1:height,1:width);
M = [Y(:) X(:) ones(width*height,1)];

% Translate and get matrix P
P = M(:,1:3)*x;
P = round(P);

% Loop through every pair of coordiantes, check if positive
for k=1:(width*height)
        u = P(k,1);
        v = P(k,2);
        w = P(k,3);
        
    if(0<u && u<=width && 0<v && v<=height)          
        newim(u/w,v/w) = Im(k);   
    end
    
end

newim = im2binary(newim);
se = strel('square',20); %There is probably a better option
newim = imclose(newim,se);
figure;
imshow(newim);

transformed = newim;


% Manually chosen points (should come from detection)
% for: imread('images/img_set5/Hus_4.png');
%col_values = [1148; 1320; 2246; 2050; 1090; 1278; 2076; 1986]; %outer, inner of f1,2,3,4
%row_values = [376;  560;  384;   568; 1456; 1284; 1376; 1296];
%col_values_true = [0; 70; 410; 340; 0;   60;  370; 320];
%row_values_true = [0; 70; 0;   70;  410; 340; 370; 320];

