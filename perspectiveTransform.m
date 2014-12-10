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

% The fip points of the distorted image 
moving_points = [fips(1,2) fips(1,1);
                    fips(2,2) fips(2,1);
                        fips(3,2) fips(3,1);
                            ap(2) ap(1)];

    % A-------C
    % |    _/
    % |  _/
    % |_/
    % B/

% Receive the vectors between the fips
A = fips(2,:);
B = fips(1,:);
C = fips(3,:);

AC = C-A;
AB = B-A;
    
% Find distance between the fips
dist_1 = sqrt(AC(1)^2 + AC(2)^2);
dist_2 = sqrt(AB(1)^2 + AB(2)^2); 

% Find the correct values for the transformed fip
% the length between the fips is based on the longest distance
% between the fips in the distorted image
dist_max = max(dist_1, dist_2);
cell_width = dist_max/34;
side = 41*cell_width;
dist_min = 3.5*cell_width;
dist_fip = 37.5*cell_width;
dist_ap = 34.5*cell_width;

% The correct coordinates for the QR code
fixed_points = [dist_min dist_fip;
                    dist_min dist_min;
                        dist_fip dist_min;
                            dist_ap dist_ap];

% Find and perform the transformation for the image                        
tform = fitgeotrans(moving_points, fixed_points, 'projective');
newim = imwarp(Im, tform, 'linear');

% Make the transformed image binary and find the fips again
newim = im2binarySimple(newim);
FIPCandidates = findFIPCandidates(newim);
FIPLocations = findFIPs(FIPCandidates);

% Crop the image from the top left corner to a rectangle
% with the same size as the QR code
rect = [FIPLocations(2,2)-(3.5*cell_width) FIPLocations(2,1)-(3.5*cell_width) side side];
newim = imcrop(newim, rect);

transformed = newim;