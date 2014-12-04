function [out, moduleSize] = checkRatio(vector, pattern)
% pattern är ex [1 1 3 1 1] elr [1 1 1 1 1], beroende på vad vi vill söka
% efter
    
    % total size of all the pixels in the sequence we looking at
    totalFinderSize = sum(vector);
    
    % size of the modules, ex 7 for the FIP-finder
    patternSize = sum(pattern);
    
    % if smaller than 7, no finder pattern
    if(totalFinderSize< patternSize)
        out = false; %0
    end

    % Calculate the size of one module
    TOLERANCE = 0.3;
    moduleSize = (totalFinderSize / patternSize);
    maxVariance = moduleSize * TOLERANCE; % tolerance

    % determine if the vector is good enough
    if(abs( moduleSize .* pattern - vector) <= maxVariance)
        out = true;
    else
        out = false;

    end
    % the above is the same and below I think..
    %out= ( (abs(moduleSize - vector(1)) < maxVariance) && (abs(moduleSize - vector(2)) < maxVariance) && (abs(3*moduleSize - vector(3)) < maxVariance) && (abs(moduleSize - vector(4)) < maxVariance) && (abs(moduleSize - vector(5)) < maxVariance));

end