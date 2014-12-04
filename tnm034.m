%%%%%%%%%%%%%%%%%%%%%%%%%%
function strout = tnm034(Im)
%
% Im: Input image of the captured QR-code. Im should be in 
% double format, normalized to the interval [0,1]
%
% strout: The resulting character string of the coded message. 
% The string must follow the pre-defined format, explained below.
%
% Our program code...

% process the image, maybe check if gray image or something first??
%img = im2binary(Im, 4);

img = im2binarySimple(Im);

% find FIPs
FIPCandidates = findFIPCandidates(img);
FIPLocations = findFIPs(FIPCandidates);

% rotate the pic
%img = rotationTransform(img, FIPLocations);

% find FIPs
%FIPCandidates = findFIPCandidates(img);
%FIPLocations = findFIPs(FIPCandidates);

% find AP
APLocation = findAP(FIPLocations,img); 

% transform the pic
img = perspectiveTransform(img, FIPLocations, APLocation);
%figure;
%imshow(img);

small_im = imresize(img, [41 41], 'nearest');
%figure;
%imshow(small_im);

% read the QR-code
message = decodeQR(double(small_im));
    
strout=message;%char(message); 
