%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%function [out, moduleSize] = checkRatio(vector, pattern)
%
%Check ratio of the vector that is sent in. Example if search for FIP,
%the pattern is [1 1 3 1 1] or search for AP is [1 1 1].
%Out is given in true or false saying if the pattern is found or not.
%
%Part of a pattern recognition project TNM034 - Advanced Image Processing, Linköping
%University HT2014.
%
%Copyright (c) <2014> Karolin Jonsson, Louise Carlström, Linnea Nåbo, Linnea Mellblom
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [out, moduleSize] = checkRatio(vector, pattern)
    % total size of all the pixels in the sequence we looking at
    totalFinderSize = sum(vector);
    
    % size of the modules, ex 7 for the FIP-finder
    patternSize = sum(pattern);
    
    % if smaller than pattern size, no pattern found
    if(totalFinderSize < patternSize)
        out = false;
    end

    % Calculate the size of one module
    TOLERANCE = 0.3;
    moduleSize = (totalFinderSize / patternSize);
    
    % how much the pattern can vary and still be acceptable. 
    maxVariance = moduleSize * TOLERANCE;

    % determine if the vector is good enough
    if(abs( moduleSize .* pattern - vector) <= maxVariance)
        out = true;
    else
        out = false;

    end
end