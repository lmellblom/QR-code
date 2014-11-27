%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%function thresh = adaptive_threshold(col, row)
%
%Divides the original image into k*k sections. Graythresh is used within
%every section resulting in k*k threshold values (thresholds).
%Part of a pattern recognition project TNM034 - Advanced Image Processing, Linköping
%University HT2014.
%
%Copyright (c) <2014> Karolin Jonsson, Louise Carlström, Linnea Nåbo, Linnea Mellblom
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function thresholds = adaptive_threshold(img, k)

%img = imread('images/img_newSet/Husannons_full_Illum.png');
img = imread('images/img_set2/Hus_1.png');
k = 8;

imshow(img);
figure;

[height, width, depth] = size(img); % height and width (depth is not used but needs to be there so "size" works correctly

BW_img = zeros(height, width);

h_step = floor(height/k)
w_step = floor(width/k)

place = 1;
for i=1:h_step:(height-h_step)
    for j=1:w_step:(width-w_step)
        if(place <= k*k)
            temp_tresh = graythresh( img((i:i+h_step-1), (j:j+w_step-1)) )
            BW_img( (i:i+h_step-1), (j:j+w_step-1) ) = im2bw( (img( (i:i+h_step-1), (j:j+w_step-1) )), temp_tresh );
            place = place+1;
        end
    end
end

imshow(BW_img);




