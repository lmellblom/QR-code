function AP = findAP(FIPs, img)
    % the order of the FIPs are
    %[lowerLeft; topLeft; topRight];
    % A-------C
    % |    _/
    % |  _/
    % |_/
    % B/
    
    % http://www.hindawi.com/journals/mpe/2013/848276/, hmmm
    
    figure;
    imshow(img);
    hold on;
    
    %bild är svartvit när den ..
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
    
    startRow = nearAP(1)
    startCol = nearAP(2)
    
    pixelRow = startRow;
    pixelCol = startCol;
    
    

    % find AP in the row
    for row = 1 : height
        scanline = img(row,:);
        
        % räkna alla moduler som är bredvid varandra
        length_modules = lengthModule(scanline);
        
        % check the sequence if there is a FIP
        pixelPosCol = 1;
        for i = 1:length(length_modules)-2  
            vectorAP= length_modules(i:i+2);
            [isAP, ~] = checkRatio(vectorAP, [1 1 1]);
            
            % if the ratio is right and the first value is white
            if(isAP  && img(row, pixelPosCol)==0)
                col = pixelPosCol + floor(sum(vectorAP)/2); % mitten positionen
                %disp(['AP found in: ' num2str(row) ' ' num2str(col)]);
                plot(col,row,'*b');
            end
            pixelPosCol = pixelPosCol + length_modules(i); % adds the pixelvalue.. 
        end

    end
    
    for col = 1 : width
        scanline = img(:,col);
        
        % räkna alla moduler som är bredvid varandra
        length_modules = lengthModule(scanline);
        
        % check the sequence if there is a FIP
        pixelPosRow = 1;
        for i = 1:length(length_modules)-2  
            vectorAP= length_modules(i:i+2);
            [isAP, ~] = checkRatio(vectorAP, [1 1 1]);
            
            % if the ratio is right and the first value is white
            if(isAP  && img(pixelPosRow, col)==0)
                row = pixelPosRow + floor(sum(vectorAP)/2); % mitten positionen
                %disp(['AP found in: ' num2str(row) ' ' num2str(col)]);
                plot(col,row,'*r');
            end
            pixelPosRow = pixelPosRow + length_modules(i); % adds the pixelvalue.. 
        end

    end
    
    %locationAP = locationAP(2:end,:)


    %plot(locationAP(:,2), locationAP(:,1),'g*');

    
    
    
end