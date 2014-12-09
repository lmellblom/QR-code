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
    
    % calculate one cell / module size, to move the AP closer to the right
    % position
    dist_1 = sqrt(AC(1)^2 + AC(2)^2);
    dist_2 = sqrt(AB(1)^2 + AB(2)^2); 
    cell_width1 = dist_1/34;
    cell_width2 = dist_2/34;
    
    normAC = AC/norm(AC);
    normAB = AB/norm(AB);
    
    %nearAP = (AC-normAC*3*cell_width1) + (AB-normAB*3*cell_width2) + A % kommer dock för långt ner och till höger.. ej konstigt dock
    nearAP = normAC*31.5*cell_width1 + normAB*31.5*cell_width2 + A;  % 31.5 since it is the distance between the middle of the FIP and the first distance of the second
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
     plot(AP(:,2), AP(:,1),'r*');
     plot(nearAP(2), nearAP(1), 'b*');

end