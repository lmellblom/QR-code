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
%Part of a pattern recognition project TNM034 - Advanced Image Processing, Link�ping
%University HT2014.
%
%Copyright (c) <2014> Karolin Jonsson, Louise Carlstr�m, Linnea N�bo, Linnea Mellblom
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%Adaptive thresholding
%Dynamic thresholding
%Normalization by local maxima

% k = how adaptive this thresholding should be. Sort of.
function thresholds = adaptive_threshold(img, k)

img = imread('images/img_set2/Hus_1.png');

k = 2;

level = graythresh(img)
levels = multithresh(img);

thresholds = zeros(k)
height = size(img, 1);
width = size(img, 2);

h_step = floor(height/k)
w_step = floor(width/k)

%Skapa en matris d�r k*k tr�skelv�rden sparas f�r att sedan tr�skla bilden
%med
for i=1:k
    for j= 1:k
        i
        j
        thresholds(i, j) = graythresh(img( (i-1)*h_step:i*h_step, (j-1)*w_step:j*w_step ));
    end
end
%Tr�skla bilden direkt

%threshholds;


