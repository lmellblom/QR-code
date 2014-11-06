%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%function FIP = reference()
%
%Returns a reference image containing finding patterns (FIPs) for QR codes of version 6.
%Part of a pattern recognition project TNM034 - Advanced Image Processing, Linköping
%University HT2014.
%
%Copyright (c) <2014> Karolin Jonsson, Louise Carlström, Linnea Nåbo, Linnea Mellblom
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function FIP = reference()

        FIP = ones(41,41);
        %Top left
        FIP(1:7,1:7) = 0;
        FIP(2:6,2:6) = 1;
        FIP(3:5,3:5) = 0;
        
        %Top right
        FIP(1:7,35:41) = 0;
        FIP(2:6,36:40) = 1;
        FIP(3:5,37:39) = 0;
        
        %Bottom left
        FIP(35:41,1:7) = 0;
        FIP(36:40,2:6) = 1;
        FIP(37:39,3:5) = 0;
        
        %Bottom left
        FIP(35:41,1:7) = 0;
        FIP(36:40,2:6) = 1;
        FIP(37:39,3:5) = 0;
        
        %Bottom right
        FIP(33:37,33:37) = 0;
        FIP(34:36,34:36) = 1;
        FIP(35:35,35:35) = 0;
                