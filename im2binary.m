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

figure('name', 'incoming fig');
imshow(img);


%% Test param. remove when working
k=10;
img = imread('images/img_set4/Hus_3a.png');
%%
%Skapa en matris där k*k st tröskelvärden sparas
thresholds = zeros(k);

%% add padding to the bottom and to the right
[height, width, depth] = size(img); % height and width (depth is not used but needs to be there so "size" works correctly
if(depth == 3) 
    img = rgb2gray(img);
end
%% Calculate padding
%Calculate how many rows to add
padHeight = k - mod(height,k);
%Calculate how many cols to add
padWidth = k - mod(width,k);

paddedHeight = height;
paddedWidth = width;

if(padHeight ~= 0)
    %Calculate height after padding
    paddedHeight = height+padHeight;
    %Create maatrix of ones of the number of rows we want to pad and of the
    %same width as the new padded img.
    padRow = zeros(padHeight, width);
    
    %Add row padding at the bottom of the image
    img = [img; padRow];
    figure('name', 'add padding bottom');
    imshow(img);
    h_step = floor(paddedHeight/k);
    loopHeight = paddedHeight;
end
if(padWidth ~= 0)
    %Calculate width after padding
    paddedWidth = width+padWidth;
    %Create matrix of ones of the same height as img and the same number of
    %cols as we want to pad
    padCol = zeros(paddedHeight, padWidth);
    % Add padding
    %Add column padding to the right of the image
    img = [img, padCol];
    
    figure('name', 'add padding side');
    imshow(img);
    
    w_step = floor(paddedWidth/k);
    loopWidth = paddedWidth;
end
if(padHeight == 0)
    h_step = floor(height/k);
    loopHeight = height;
   
end
if(padWidth == 0)
    w_step = floor(width/k);
    loopWidth = width;
end
    
%% Create new binary image
BW_img = zeros(size(img));
figure('name', 'new BW');
imshow(BW_img);
%% uncomment IF running im2bin without padding
%paddedHeight = height;
%paddedWidth = width;
%det blir olika bokstäver när man decodar beroende på om man tex trösklar med k=8 eller k=9, skulle man kunde ta det som blev rätt från båda så skulle det bli perfa. 
%%

place = 1;
for i=1:h_step:(loopHeight-h_step)
    for j=1:w_step:(loopWidth-w_step)
        if(place <= k*k)
            thresholds(place) = graythresh( img((i:i+(h_step-1)), (j:j+(w_step-1))) );
            BW_img( (i:(i+(h_step-1))), (j:(j+(w_step-1))) ) = im2bw( (img( (i:i+(h_step-1)), (j:j+(w_step-1)) )), thresholds(place) );
            place = place+1;
        end
    end
end

figure('name', 'thresholded BW');
imshow(BW_img);
%% Remove padding
BW_img=BW_img(1:height,1:width);
figure('name', 'padding removed');
imshow(BW_img);
%%
bin = BW_img;