%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%function AP = findAP(FIPs, img)
%
%A function that given an binary, processed image, and the calculated three
%FIP positions, search for the AP point and return the position for it. 
%
%Part of a pattern recognition project TNM034 - Advanced Image Processing, Linköping
%University HT2014.
%
%Copyright (c) <2014> Karolin Jonsson, Louise Carlström, Linnea Nåbo, Linnea Mellblom
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function AP = findAP(FIPs, img)
    %% The order of the FIPs are [lowerLeft; topLeft; topRight];
    % A-------C
    % |    _/
    % |  _/
    % |_/
    % B/
        
    %% By usin linear algebra, find the point where in a perfect image, the AP (nearAP) point is located. 
    [height, width] = size(img);
    
    % just initiate som variables
    locationAP = [0 0]; num = 0;
    
    % pick out the FIPs and store as image above says
    A = FIPs(2,:);
    B = FIPs(1,:);
    C = FIPs(3,:);

    % calculate the vectors between. 
    AC = C-A;
    AB = B-A;
    
    % calculate one cell / module size, to move the AP closer to the right position
    dist_1 = sqrt(AC(1)^2 + AC(2)^2);
    dist_2 = sqrt(AB(1)^2 + AB(2)^2); 
    cell_width1 = dist_1/34;
    cell_width2 = dist_2/34;
    
    % normalize
    normAC = AC/norm(AC);
    normAB = AB/norm(AB);
    
    % the 31.5 is the distance between ex the middle A point to the first
    % black module of the C. 
    nearAP = normAC*31.5*cell_width1 + normAB*31.5*cell_width2 + A;  
    
    % to not search in the entire image for AP, know where it "should" be
    % does not work properly
    %startRow = floor(nearAP(1)*0.5);
    %startCol = floor(nearAP(2)*0.5);
    
    %% Find all the possible candidates for the AP
    % start by searching the row
    for row = 1 : height
        scanline = img(row,:);
        
        % calculate the appearence of the modules in row.
        length_modules = lengthModule(scanline);
        
        pixelPosCol = 1; % to know which pixel position in column we are at
        % check the sequence if there is a possible AP, taking out every 3
        % element
        for i = 1:length(length_modules)-2 
            vectorAP = length_modules(i:i+2);
            [isAP, ~] = checkRatio(vectorAP, [1 1 1]);
            
            % if the ratio is right and the first value is black
            if(isAP &&  img(row, pixelPosCol)==0)
                col = pixelPosCol + floor(sum(vectorAP)/2); % search this column
                
                pixelPosRow=1;
                length_module_col = lengthModule(img(:,col));
                % search the column for ratio of AP, if almost same row as
                % above, store as AP candidate
                for j = 1:length(length_module_col)-2
                    vector_row_AP = length_module_col(j:j+2);
                    [rowAP, ~] =  checkRatio(vector_row_AP, [1 1 1]);
                    if(rowAP && img(pixelPosRow,col)==0)
                        rows = pixelPosRow + sum(vector_row_AP)/2;
                        if (abs(rows-row) <= 1) %allow a small error
                            locationAP = [locationAP; [row col]];
                        end
                    end  
                    pixelPosRow = pixelPosRow + length_module_col(j);
                end
           
            end
            pixelPosCol = pixelPosCol + length_modules(i);
        end

    end
    locationAP = locationAP(2:end,:);
    
    %% Find the most likely AP point.
    % calculate the distance between the found AP candidates and the
    % calculated nearAP in the beginning
    d = pdist2(locationAP, nearAP);
    [~, index] = min(d); % found the one with smallest distance
    
    % choose the point that had the smallest distane to the nearAP
    AP = locationAP(index,:);
    
    %% Trying to make the AP finder better precision,  will not just pick the smallest distance. 
    % does not work properly
%     if(length(locationAP)>1)
%         dNorm = d/norm(d,Inf); % normalize the vector
%         dTrue = dNorm<0.2; % find a specific range of APs, more likely to be
%         ap = locationAP(dTrue,:);
% 
%         % use k-means to find the centerpoint of this cluster
%         [~, centerPoints] = kmeans(ap,1,'Distance','cityblock',...
%                                'Replicates',5);
% 
%         % choose the centerpoint as the AP
%         AP = centerPoints;
%     else
%         AP = locationAP(index,:);
%     end
    
    %% Uncomment if want to se the found AP point and the calculated nearAP in the beginning.  
%     figure;
%     imshow(img);
%     hold on;
%     plot(AP(:,2), AP(:,1),'r*');
%     plot(nearAP(2), nearAP(1), 'b*');

end