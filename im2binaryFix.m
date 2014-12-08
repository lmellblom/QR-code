%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%function bin = im2binary(img)
%
%Computes a global threshold using graythresh() and uses this threshold to convert 
%the image to binary with im2bw().
%Part of a pattern recognition project TNM034 - Advanced Image Processing, Link�ping
%University HT2014.
%
%Copyright (c) <2014> Louise Carlstr�m, Karolin Jonsson, Linnea Mellblom, Linnea N�bo
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function thresholds = im2binaryFix(img, k)
%% Test param. remove when working
k = 1;
img = imread('images/img_set2/test.png');
%img = imread('images/img_set1/Bygg_1.png');
%img = imread('images/img_newSet/Husannons_full_Illum.png');
%img = imread('images/img_newSet/Hus_1_illum.png');
%img = imread('images/img_set5/Husannons_full.png');

uniqLevels = unique(img(:));
disp(['Number of unique levels = ' int2str( length(uniqLevels) )]);

figure(1);
imshow(img);

%Skapa en matris d�r k*k st tr�skelv�rden sparas
thresholds = zeros(k);

%% add padding to the bottom and to the right
[height, width, depth] = size(img); % height and width (depth is not used but needs to be there so "size" works correctly
if(depth == 3) 
    img = rgb2gray(img);
end

%img = imadjust(img);
figure(7);imshow(img);

uniqLevels = unique(img(:));
disp(['Number of unique levels = ' int2str( length(uniqLevels) )]);

%% Calculate padding
% If the remainder of height / k is 0, k pixels will used for padding!!
% padHeight: how many rows of padding to add
padHeight = k - mod(height,k);
% padWidth: how many columns of padding to add
padWidth = k - mod(width,k);
    
paddedHeight = height+padHeight;
paddedWidth = width+padWidth;

% Create the column to pad with.
padCol = ones(height, padWidth);
%Create the row to pad with.
padRow = ones(padHeight, paddedWidth);

% Add padding
%Add column padding to the right of the image
img = [img, padCol];
%Add row padding at the bottom of the image
img = [img; padRow];

figure(2);
imshow(img);

% _step: the step with which to loop to threshold
h_step = (paddedHeight/k);
w_step = (paddedWidth/k);

loopHeight = paddedHeight;
loopWidth = paddedWidth;
    
%% Create new empty image
BW_img = zeros(size(img));

figure(3);
imshow(BW_img);

%% Adaptive thresholding
% 
place = 1;
entire_thresh = graythresh(img);

for i=1:h_step:(loopHeight-h_step+1)
    for j=1:w_step:(loopWidth-w_step+1)
        temp_img = img( (i:i+(h_step-1)), (j:j+(w_step-1)) );
        
        temp_mean = mean(temp_img);
        
        temp_min = min(min(temp_img));
        temp_max = max(max(temp_img));
        delta = temp_max - temp_min;
        
        if( place <= k*k && delta > 30 )
            [level, EM] = graythresh( temp_img );
            thresholds(place) = level;
            BW_img( (i:(i+(h_step-1))), (j:(j+(w_step-1))) ) = im2bw( (img( (i:i+(h_step-1)), (j:j+(w_step-1)) )), thresholds(place) );
            place = place+1;
        elseif(entire_thresh > level)
            BW_img( (i:(i+(h_step-1))), (j:(j+(w_step-1))) ) = 1;
        else
            BW_img( (i:(i+(h_step-1))), (j:(j+(w_step-1))) ) = 0;
        end
    end
end

figure(4);
imshow(BW_img);

%% Remove padding
BW_img = BW_img(1:height, 1:width);

figure(5);
imshow(BW_img);

%%
bin = BW_img;