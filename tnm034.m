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
img = im2binarySimple(Im);

% find FIPs
FIPCandidates = findFIPCandidates(img);
FIPLocations = findFIPs(FIPCandidates);

% find AP
APLocation = findAP(FIPLocations,img); 

% transform the pic
Im = perspectiveTransform(Im, 3, FIPLocations);
small_im = imresize(Im, [41 41], 'nearest');

% read the QR-code
message = decodeQR(double(small_im));
    
strout=message;%char(string); 