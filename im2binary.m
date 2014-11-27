%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%function bin = im2binary(img)
%
%Computes a global threshold using graythresh() and uses this threshold to convert 
%the image to binary with im2bw().
%Part of a pattern recognition project TNM034 - Advanced Image Processing, Linköping
%University HT2014.
%
%Copyright (c) <2014> Karolin Jonsson, Louise Carlström, Linnea Nåbo, Linnea Mellblom
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function bin = im2binary(img, k)

%imshow(img);
%figure;

%Skapa en matris där k*k st tröskelvärden sparas
thresholds = zeros(k);

[height, width, depth] = size(img); % height and width (depth is not used but needs to be there so "size" works correctly

BW_img = zeros(height, width);

h_step = floor(height/k);
w_step = floor(width/k);

place = 1;
for i=1:h_step:(height-h_step)
    for j=1:w_step:(width-w_step)
        if(place <= k*k)
            thresholds(place) = graythresh( img((i:i+(h_step-1)), (j:j+(w_step-1))) );
            BW_img( (i:(i+(h_step-1))), (j:(j+(w_step-1))) ) = im2bw( (img( (i:i+(h_step-1)), (j:j+(w_step-1)) )), thresholds(place) );
            place = place+1;
        end
    end
end

imshow(BW_img);

bin = BW_img;