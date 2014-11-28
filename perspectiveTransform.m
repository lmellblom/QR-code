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
function transformed = perspectiveTransform(Im, fips, ap)

no_of_points = 4;
% Set the fips
row_values_dist = [fips(1,1), fips(2,1), fips(3,1), ap(1)];
col_values_dist = [fips(1,2), fips(2,2), fips(3,2), ap(2)];


% Make the new image the same size as the current
[width,height,color] = size(Im);
if(color == 3)
    Im = rgb2gray(Im);
end

% Calculate true values
% Find max distance:
dist_1 = abs((row_values_dist(1) - row_values_dist(2)));
dist_2 = abs((col_values_dist(3) - col_values_dist(2)));

dist_max = max(dist_1, dist_2)
dist_min = dist_max*(4/34);
side = dist_max + (2*dist_min);

% True values for the fips
col_values_true = [dist_min;          dist_min; dist_min+dist_max; dist_max];
row_values_true = [dist_max+dist_min; dist_min; dist_min         ; dist_max];


% Collect coordinates from the image and the reference image
false_pic = [row_values_dist(:) col_values_dist(:) ones(no_of_points,1)]; %values of the false pic
true_pic = [row_values_true(:) col_values_true(:) ones(no_of_points,1)]; %values of the true pic

% Find transformation matrix
x = false_pic\true_pic;

% Fit geometry
[X,Y] = meshgrid(1:height,1:width);%[X,Y] = meshgrid(1:dist_max,1:dist_max);%
M = [Y(:) X(:) ones(width*height,1)];%M = [Y(:) X(:) ones(dist_max*dist_max,1)];


% Translate and get matrix P
P = M(:,1:3)*x;
P = round(P);

% Loop through every pair of coordiantes, check if positive
for k=1:(width*height)
        u = P(k,1);
        v = P(k,2);
        w = P(k,3);
        
    if(0<u && u<=side && 0<v && v<=side)          
        newim(u/w,v/w) = Im(k);   
    end
    
end

newim = im2binarySimple(newim);

n = floor(dist_max/(33*2));
se = strel('square',n); %There is probably a better option, need to decide what square side
newim = imclose(newim,se);

transformed = newim;

