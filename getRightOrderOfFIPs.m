%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%function [lowerLeft, topLeft, topRight] = getRightOrderOfFIPs(FIPs)
%
% Function that takes in three FIP locations and return known order of these.
% Function calculates which FIP is top left, top right and lower left. 
%
%Part of a pattern recognition project TNM034 - Advanced Image Processing, Linköping
%University HT2014.
%
%Copyright (c) <2014> Karolin Jonsson, Louise Carlström, Linnea Nåbo, Linnea Mellblom
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [lowerLeft, topLeft, topRight] = getRightOrderOfFIPs(FIPs)

    % A-------C
    % |    _/
    % |  _/
    % |_/
    % B/
    
    [~,indexMax] = max(pdist(FIPs)); % calc distance, where is distance max 
    
    %% Find the top left FIP, known as A. 
    
    % find the max distance, know that this is the hypotenuse and therefore
    % which FIP is not involved, and therefore the top left FIP. 
    % pdist = [ |pos1-pos2|, |pos1-pos3|, |pos2-pos3| ]
    switch indexMax
        case 1
            %longest distance between pos1 and 2, meaning position 3 is A
            A = FIPs(3,:);
            % B and C arbitrary, will calculate later
            B = FIPs(2,:); 
            C = FIPs(1,:); 
        case 2
            %longest distance between pos1 and 3, meaning position 2 is A
            A = FIPs(2,:);
            % B and C arbitrary, will calculate later
            B = FIPs(3,:);
            C = FIPs(1,:); 
        case 3
            %longest distance between pos2 and 3, meaning position 1 is A
            A = FIPs(1,:);
            % B and C arbitrary, will calculate later
            B = FIPs(2,:); 
            C = FIPs(3,:);
    end
    
    topLeft = A;

    %% Find the lower left and top right, B and C. 
    % vectors between points
    AB = B-A;
    AC = C-A;
    
    %perp dot product, http://geomalgorithms.com/vector_products.html
    k = AB(1)*AC(2) - AB(2)*AC(1);
    
    % AB _|_ AC > 0, AC left of AB => C is topRight. Otherwise the
    % opposite. 
    if k > 0
        topRight = C;
        lowerLeft = B;
    else
        lowerLeft = C;
        topRight = B;
    end

end