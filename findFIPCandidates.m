%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%function locationFIPs = findFIPCandidates(img)
%
% Given a image that is processed and binary, this function searches and
% stores the location of a possible FIP candidate. 
%
%Part of a pattern recognition project TNM034 - Advanced Image Processing, Link�ping
%University HT2014.
%
%Copyright (c) <2014> Karolin Jonsson, Louise Carlstr�m, Linnea N�bo, Linnea Mellblom
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function locationFIPs = findFIPCandidates(img)
    % initiate some variabels to be used
    numberOfFIPS = 0;
    locationFIPs = [0 0];
    [height, width] = size(img);
    
    %% search the row for a FIP candidate
    for row = 1 : height
        scanline = img(row,:); % pick out the entire row
        
        % calculate the appearence of the modules in row.
        length_modules = lengthModule(scanline);
        
        pixelPosCol = 1; % to know which pixel position in column we are at
        % check the sequence if there is a possible FIP, taking out every 5
        % element
        for i = 1:length(length_modules)-4  
            vectorFIP = length_modules(i:i+4);
            [isFIP, ~] = checkRatio(vectorFIP, [1 1 3 1 1]);
            
            % if the ratio is right and the first value is black, a
            % possible FIP in the row, then search in that column
            if(isFIP &&  img(row, pixelPosCol)==0)
                col = pixelPosCol + floor(sum(vectorFIP)/2); % column to search

                pixelPosRow=1; % which pixel position in the row
                
                length_module_col = lengthModule(img(:,col));
                % search trough the column and see if the FIP pattern is
                % found, if at almost the same row, store as a candidate.
                for j = 1:length(length_module_col)-4
                    vector_row_FIP = length_module_col(j:j+4);
                    [rowFIP, ~] =  checkRatio(vector_row_FIP, [1 1 3 1 1]);
                    
                    if(rowFIP && img(pixelPosRow,col)==0)
                        rows = pixelPosRow + sum(vector_row_FIP)/2;
                        if (abs(rows-row) <= 0.8) %allow a small error
                            numberOfFIPS = numberOfFIPS + 1;
                            locationFIPs = [locationFIPs; [row col]];
                        end
                    end  
                    pixelPosRow = pixelPosRow + length_module_col(j);
                end
           
            end
            pixelPosCol = pixelPosCol + length_modules(i);
        end

    end
    
    % since we allocated the first position to [0 0], just remove this. 
    locationFIPs = locationFIPs(2:end,:);
      
    %% Uncomment if want to se all the locations of the FIP candidates
    %figure;
    %imshow(img);
    %hold on;
    %plot(locationFIPs(:,2), locationFIPs(:,1),'g*');
    
end