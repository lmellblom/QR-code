function AP = findAP(FIPs, img)
    % the order of the FIPs are [lowerLeft; topLeft; topRight];
    % A-------C
    % |    _/
    % |  _/
    % |_/
    % B/
    
    % http://www.hindawi.com/journals/mpe/2013/848276/, hmmm
    
    %% genom linjär algebra, hitta punkt där AP troligen ligger, 'nearAP'.
    %bild är svartvit när den kommer in lr liknadne?
    [height, width] = size(img);
    
    locationAP = [0 0];
    num = 0;
    
    A = FIPs(2,:);
    B = FIPs(1,:);
    C = FIPs(3,:);

    AC = C-A;
    AB = B-A;
    
    nearAP = AC + AB + A; % kommer dock för långt ner och till höger.. ej konstigt dock
    % tollerance upp och ned typ
    
    startRow = nearAP(1);
    startCol = nearAP(2);
    
    %% find all the possible candidates for the AP
    for row = 1 : height
        scanline = img(row,:);
        
        % räkna alla moduler som är bredvid varandra
        length_modules = lengthModule(scanline);
        
        % check the sequence if there is a FIP
        pixelPosCol = 1;
        for i = 1:length(length_modules)-2 
            vectorFIP = length_modules(i:i+2);
            [isFIP, ~] = checkRatio(vectorFIP, [1 1 1]);
            
            % if the ratio is right and the first value is black
            if(isFIP &&  img(row, pixelPosCol)==0)
                col = pixelPosCol + floor(sum(vectorFIP)/2); % mitten positionen
                
                % -----------------------------------------------------------------
                % detta kanske tas bort. nu om hittat fip i raden, går
                % längs mitten på denna och ser om samma ratio typ..
                % scan that col and see if there is a FIP there to
                pixelPosRow=1;
                length_module_col = lengthModule(img(:,col));
                for j = 1:length(length_module_col)-2
                    vector_row_FIP = length_module_col(j:j+2);
                    [rowFIP, ~] =  checkRatio(vector_row_FIP, [1 1 1]);
                    if(rowFIP && img(pixelPosRow,col)==0)
                        rows = pixelPosRow + sum(vector_row_FIP)/2;
                        if (abs(rows-row) <= 0.8) % bara felmarginal om typ brevid varandra
                            % fip is found in both directions
                            locationAP = [locationAP; [row col]];
                        end
                    end  
                    pixelPosRow = pixelPosRow + length_module_col(j);
                end
           
            end
            pixelPosCol = pixelPosCol + length_modules(i); % adds the pixelvalue.. 
        end

    end
    locationAP = locationAP(2:end,:);
    
    %% sålla nu ut de som inte är AP, utan hitta den mest troliga typ
    
    d = pdist2(locationAP, nearAP);
    [~, index] = min(d);
    
    % choose the point closest to the "right" now. 
    AP = locationAP(index,:);
    
    % plot cancidates and "the almost AP"
    figure;
    imshow(img);
    hold on;
    plot(AP(:,2), AP(:,1),'g*');
    %plot(nearAP(2), nearAP(1), 'r*');

end