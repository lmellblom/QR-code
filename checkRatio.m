function [out, moduleSize] = checkRatio(vector)
    
    % total size of all the pixels in the sequence we looking at
    totalFinderSize = sum(vector); 
    
    % if smaller than 7, no finder pattern
    if(totalFinderSize<7)
        out = false; %0
    end

    % Calculate the size of one module
    TOLERANCE = 0.4;
    moduleSize = ceil(totalFinderSize / 7.0);
    maxVariance = moduleSize * TOLERANCE; % tolerance

    % determine if the vector is good enough
    if(abs( moduleSize .* [1 1 3 1 1] - vector) <= maxVariance)
        out = true;
    else
        out = false;
    end
    % the above is the same and below I think..
    %out= ( (abs(moduleSize - vector(1)) < maxVariance) && (abs(moduleSize - vector(2)) < maxVariance) && (abs(3*moduleSize - vector(3)) < maxVariance) && (abs(moduleSize - vector(4)) < maxVariance) && (abs(moduleSize - vector(5)) < maxVariance));

end