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


function thresholds = im2binaryFix(img, k)
%% Test param. remove when working
k = 15;
img = imread('images/img_set2/test.png');

figure(1);
imshow(img);
%%
%Skapa en matris där k*k st tröskelvärden sparas
thresholds = zeros(k);

%% add padding to the bottom and to the right
[height, width, depth] = size(img) % height and width (depth is not used but needs to be there so "size" works correctly
if(depth == 3) 
    img = rgb2gray(img);
end

%% Calculate padding
% If the remainder of height / k is 0, k pixels will used for padding!!
% padHeight: how many rows of padding to add
padHeight = k - mod(height,k)
% padWidth: how many columns of padding to add
padWidth = k - mod(width,k)

% If no padding is *needed* for even thresholding, add k pixels as padding
%if(padHeight == 0)
%    padHeight = k;
%end
%if(padWidth == 0)
%    padWidth = k;
%end
    
paddedHeight = height+padHeight
paddedWidth = width+padWidth

% Create the column to pad with.
padCol = ones(height, padWidth);
%Create the row to pad with.
padRow = ones(padHeight, paddedWidth);

% Add padding
%Add column padding to the right of the image
img = [img, padCol];
%Add row padding at the bottom of the image
img = [img; padRow]; %REMEMBER TO DELETE THE PADDING AFTER TRESHOLDING

figure(2);
imshow(img);

[h, w, ~] = size(img)

% _step: the step with which to loop to threshold
h_step = (paddedHeight/k);
w_step = (paddedWidth/k);

loopHeight = paddedHeight;
loopWidth = paddedWidth;
    
%% Create new binary image
BW_img = zeros(size(img));

[bw_h, bw_w, ~] = size(BW_img)

figure(3);
imshow(BW_img);

%% uncomment IF running im2bin without padding
%paddedHeight = height;
%paddedWidth = width;
%det blir olika bokstäver när man decodar beroende på om man tex trösklar med k=8 eller k=9, skulle man kunde ta det som blev rätt från båda så skulle det bli perfa. 
%%

place = 1;
for i=1:h_step:(loopHeight-h_step+1)
    for j=1:w_step:(loopWidth-w_step+1)
        if(place <= k*k)
            thresholds(place) = graythresh( img((i:i+(h_step-1)), (j:j+(w_step-1))) );
            BW_img( (i:(i+(h_step-1))), (j:(j+(w_step-1))) ) = im2bw( (img( (i:i+(h_step-1)), (j:j+(w_step-1)) )), thresholds(place) );
            place = place+1;
        end
    end
end

figure(4);
imshow(BW_img);

%% Remove padding
BW_img=BW_img(:,1:height);
BW_img=BW_img(1:width,:);
figure(5);
imshow(BW_img);

%%
bin = BW_img;