function locationFIPs = findFIPCandidates(img)
% img should be processed and binary!
    numberOfFIPS = 0;
    locationFIPs = [0 0];
    
    [height, width] = size(img); % height and width
    
    % find FIP in the row
    for row = 1 : height
        scanline = img(row,:);
        
        % räkna alla moduler som är bredvid varandra
        length_modules = lengthModule(scanline);
        
        % check the sequence if there is a FIP
        pixelPosCol = 1;
        for i = 1:length(length_modules)-4  
            vectorFIP = length_modules(i:i+4);
            [isFIP, moduleSize] = checkRatio(vectorFIP, [1 1 3 1 1]);
            
            % if the ratio is right and the first value is black
            if(isFIP &&  img(row, pixelPosCol)==0)
                col = pixelPosCol + floor(sum(vectorFIP)/2); % mitten positionen
                
                % -----------------------------------------------------------------
                % detta kanske tas bort. nu om hittat fip i raden, går
                % längs mitten på denna och ser om samma ratio typ..
                % scan that col and see if there is a FIP there to
                pixelPosRow=1;
                length_module_col = lengthModule(img(:,col));
                for j = 1:length(length_module_col)-4
                    vector_row_FIP = length_module_col(j:j+4);
                    [rowFIP, mS] =  checkRatio(vector_row_FIP, [1 1 3 1 1]);
                    if(rowFIP && img(pixelPosRow,col)==0)
                        rows = pixelPosRow + sum(vector_row_FIP)/2;
                        if (abs(rows-row) <= 0.8) % bara felmarginal om typ brevid varandra
                            % fip is found in both directions
                            numberOfFIPS = numberOfFIPS + 1;
                            locationFIPs = [locationFIPs; [row col]];
                        end
                    end  
                    pixelPosRow = pixelPosRow + length_module_col(j);
                end
           
            end
            pixelPosCol = pixelPosCol + length_modules(i); % adds the pixelvalue.. 
        end

    end
    
    locationFIPs = locationFIPs(2:end,:);
      
    % ritar ut
    %figure;
    %imshow(img);
    %hold on;
    %plot(topLeft(:,2), topLeft(:,1),'g*');
    %plot(topRight(:,2), topRight(:,1),'r*');
    %plot(lowerLeft(:,2), lowerLeft(:,1),'b*');
    %plot(rightOrder(:,2), rightOrder(:,1), 'g*');
    
end