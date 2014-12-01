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

figure;
imshow(Im);
hold on;
plot(fips(1,2), fips(1,1),'g*');
plot(fips(2,2), fips(2,1),'r*');
plot(fips(3,2), fips(3,1),'b*');
plot(ap(2), ap(1),'c*');

% Make the new image the same size as the current
% [width,height,color] = size(Im);
% if(color == 3)
%     Im = rgb2gray(Im);
% end
[width,height] = size(Im);

    % A-------C
    % |    _/
    % |  _/
    % |_/
    % B/
    
A = fips(2,:);
B = fips(1,:);
C = fips(3,:);

AC = C-A;
AB = B-A;
    
% Calculate true values
% Find max distance:
dist_1 = sqrt(AC(1)^2 + AC(2)^2);
dist_2 = sqrt(AB(1)^2 + AB(2)^2); 

dist_max = max(dist_1, dist_2);
cell_width = dist_max/34;
dist_min = 3.5*cell_width;%dist_max*(3.5/36);%(3.5/34)%
side = 41*cell_width;%dist_max + (2*dist_min);
dist_fip = 37.5*cell_width;
dist_ap = 34.5*cell_width;


% True values for the fips
col_values_true = [dist_min;          dist_min; dist_fip;          dist_ap];
row_values_true = [dist_fip;          dist_min; dist_min         ; dist_ap];
% plot(row_values_true(1), col_values_true(1),'y*');
% plot(row_values_true(2), col_values_true(2),'y*');
% plot(row_values_true(3), col_values_true(3),'y*');
% plot(row_values_true(4), col_values_true(4),'y*');


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

n = floor(cell_width/2);
if(cell_width > 2)
    se = strel('square',n); %There is probably a better option, need to decide what square side
    newim = imclose(newim,se);
end

% figure;
% imshow(newim);
% hold on;
% plot(row_values_true(1), col_values_true(1),'y*');
% plot(row_values_true(2), col_values_true(2),'y*');
% plot(row_values_true(3), col_values_true(3),'y*');
% plot(row_values_true(4), col_values_true(4),'y*');

transformed = newim;

