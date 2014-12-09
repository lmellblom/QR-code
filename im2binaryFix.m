function thresholds = im2binaryFix(img, k)
%% Test param. remove when working
k = 8;
%img = imread('images/img_set2/test.png');
%img = imread('images/img_set1/Bygg_1.png');
%img = imread('images/img_newSet/Husannons_full_Illum.png');

uniqueLevels = unique(img(:)); %Används aldrig
%disp(['Number of unique levels = ' int2str( length(uniqLevels) )]);

%%
%Skapa en matris där k*k st tröskelvärden sparas
thresholds = zeros(k);

%% add padding to the bottom and to the right
[height, width, depth] = size(img); % height and width (depth is not used but needs to be there so "size" works correctly
if(depth == 3) 
    img = rgb2gray(img);
end

img = imadjust(img);

uniqLevels = unique(img(:)); % Används aldrig

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
img = [img; padRow]; %REMEMBER TO DELETE THE PADDING AFTER TRESHOLDING

% _step: the step with which to loop to threshold
h_step = (paddedHeight/k);
w_step = (paddedWidth/k);

loopHeight = paddedHeight;
loopWidth = paddedWidth;
    
%% Create new empty image
BW_img = zeros(size(img));

%% det blir olika bokstäver när man decodar beroende på om man tex trösklar med k=8 eller k=9, skulle man kunde ta det som blev rätt från båda så skulle det bli perfa. 

place = 1;
img = im2double(img);
entire_thresh = graythresh(img);

for i=1:h_step:(loopHeight-h_step+1)
    for j=1:w_step:(loopWidth-w_step+1)
        temp_img = img( (i:i+(h_step-1)), (j:j+(w_step-1)) );
        
        small_thresh = graythresh(temp_img);
        
        temp_min = min(min(temp_img));
        temp_max = max(max(temp_img));
        delta = temp_max - temp_min;
        
        if( place <= k*k && delta > 0.946 )%0.7 för nästan alla är bra (nästan skjuter ingen hare)
            thresholds(place) = small_thresh;
            BW_img( (i:(i+(h_step-1))), (j:(j+(w_step-1))) ) = im2bw( (img( (i:i+(h_step-1)), (j:j+(w_step-1)) )), thresholds(place) );
            place = place+1;
        elseif(entire_thresh > small_thresh)
            BW_img( (i:(i+(h_step-1))), (j:(j+(w_step-1))) ) = 0;
        else
            BW_img( (i:(i+(h_step-1))), (j:(j+(w_step-1))) ) = 1;
        end
    end
end

%% Remove padding
BW_img = BW_img(1:height, 1:width);

thresholds = BW_img;