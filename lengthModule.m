%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%function out = lengthModule(vector)
%
%If the vector in is [0 0 1 0 1 1 1 0 0], out = [2 1 1 3 2].
%Calculates the apperance in row of elements. 
%
%Part of a pattern recognition project TNM034 - Advanced Image Processing, Linköping
%University HT2014.
%
%Copyright (c) <2014> Karolin Jonsson, Louise Carlström, Linnea Nåbo, Linnea Mellblom
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function out = lengthModule(vector)
    % allocate with ones
    out = ones(1,length(vector));
    k=1;
    
    for i = 1 : length(vector)-1
        if (vector(i) == vector(i+1))
            out(k) = out(k) + 1;
        else
            k = k + 1;
        end
    end

    % kapa längden på den
    out = out(1:k);
end

