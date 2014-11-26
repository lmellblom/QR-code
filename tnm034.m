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

loc = findFIP(Im);
Im = perspectiveTransform(Im, 3, loc);
small_im = imresize(Im, [41 41], 'nearest');
message = decodeQR(double(small_im));
    
strout=message;%char(string); 