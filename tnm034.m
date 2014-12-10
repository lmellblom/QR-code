%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%function strout = tnm034(Im)
%
% Im: Input image of the captured QR-code. Im should be in 
% double format, normalized to the interval [0,1]
%
% strout: The resulting character string of the coded message. 
% The string must follow the pre-defined format, explained below.
%
% Copyright (c) <2014> Karolin Jonsson, Louise Carlström, Linnea Nåbo, Linnea Mellblom
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function strout = tnm034(Im)

% Make image binary
img = im2binarySimple(Im);

% find FIP points in the image
FIPCandidates = findFIPCandidates(img);
FIPLocations = findFIPs(FIPCandidates);

% find AP point in the image
APLocation = findAP(FIPLocations,img); 

% Transform the image
img = perspectiveTransform(Im, FIPLocations, APLocation);

% Resize image
small_im = imresize(img, [41 41], 'nearest');

% Read the QR-code
message = decodeQR(double(small_im));
    
strout=message;
