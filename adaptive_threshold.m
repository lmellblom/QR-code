%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%function thresh = adaptive_threshold(col, row)
%
%
% OBS FUNKAR EJ
%
%
%Divides the original image into k*k sections. Returns a matrix with k*k
%threshold values (thresholds).
%Part of a pattern recognition project TNM034 - Advanced Image Processing, Linköping
%University HT2014.
%
%Copyright (c) <2014> Karolin Jonsson, Louise Carlström, Linnea Nåbo, Linnea Mellblom
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% k = how adaptive this thresholding should be. Sort of.
function thresholds = adaptive_threshold(img, k)

img = imread('images/img_set2/Hus_1.png');

k = 4;

level = graythresh(img)
levels = multithresh(img);

thresholds = zeros(k)
height = size(img, 1);
width = size(img, 2);

h_step = floor(height/k)
w_step = floor(width/k)

k_h = 1;
for i=1:h_step:height
    for j= 1:w_step:width
        thresholds(k_m) = graythresh(img(i:i+h_step, j:j+w_step));
        k_m = k_m+1;
    end
end

% adaptfilt.adjlms;
% multithresh

%threshholds;


