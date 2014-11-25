function [numberOfFIPS, centerPoints] = findFIP(img)

    numberOfFIPS = 0;
    locationFIP = [0 0];
    
    % test bara nu, ska skicka in en bild sen som är grayscaled
    %img = imread('images/img_set2/test','png');
    %img = imread('images/img_set2/Hus_1','png');
    %img = imread('images/img_set5/Hus_4d','png'); % hittar aldrig i denna!!
   
    img = im2binary(img);
    
    figure;
    imshow(img);
    hold on;
    
    [height, width] = size(img); % height and width
    skipRows = 1; % behöver inte scanna varje rad, läst att de går att skippa några..
    
    % find FIP in the row
    for row = skipRows : skipRows : height
        scanline = img(row,:);
        
        % räkna alla moduler som är bredvid varandra
        length_modules = lengthModule(scanline);
        
        % check the sequence if there is a FIP
        pixelPosCol = 1;
        for i = 1:length(length_modules)-4  
            vectorFIP = length_modules(i:i+4);
            [isFIP, moduleSize] = checkRatio(vectorFIP);
            
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
                    [rowFIP, mS] =  checkRatio(vector_row_FIP);
                    if(rowFIP && img(pixelPosRow,col)==0)
                        rows = pixelPosRow + sum(vector_row_FIP)/2;
                        if (abs(rows-row) <= 0.8) % bara felmarginal om typ brevid varandra
                            % fip is found in both directions
                            %disp('FIP');
                            numberOfFIPS = numberOfFIPS + 1;
                            %plot(col, row,'y+');
                            locationFIP = [locationFIP; [row col]];
                        end
                    end  
                    pixelPosRow = pixelPosRow + length_module_col(j);
                end
                
                % -------------------------------------------------------------

                %plot(col, row,'g+');
                %plot(pixelPosCol, row, 'y+'); %start of FIP
                %plot(pixelPosCol+sum(vectorFIP), row, 'c+'); %end of FIP
           
            end
            pixelPosCol = pixelPosCol + length_modules(i); % adds the pixelvalue.. 
        end

    end
    
    
%     % -----------------------------------------------------------
%     % om tar bort det som är inne i forloppen, måste detta tas tillbaka
%     % find FIP in the col
%     for col = skipRows : skipRows : width
%         scanline = img(:,col);
%         
%         % räkna alla moduler som är bredvid varandra
%         length_modules = lengthModule(scanline);
%         
%         % check the sequence if there is a FIP
%         pixelPosRow = 1;
%         for i = 1:length(length_modules)-4  
%             vectorFIP = length_modules(i:i+4);
%             [isFIP, moduleSize] = checkRatio(vectorFIP);
%             
%             if(isFIP && img(pixelPosRow, col)==0);
%                 row = pixelPosRow + floor(sum(vectorFIP)/2); % mitten positionen
%                 plot(col, row,'m*');
%                 plot(col, pixelPosRow, 'g+'); %start of FIP
%                 plot(col, pixelPosRow+sum(vectorFIP), 'r+'); %end of FIP
%             end
%             pixelPosRow = pixelPosRow + length_modules(i); % adds the pixelvalue.. 
%         end
%     end
%     % -----------------------------------------------------------------------
    locationFIP = locationFIP(2:end,:)
    
    % separerar ut de true FIPS med k-means.
    % om fått tre punkter väldigt nära varandra, görs till en.
    % http://se.mathworks.com/help/stats/kmeans.html#buefthh-3
    [idx, centerPoints] = kmeans(locationFIP,3,'Distance','cityblock',...
                       'Replicates',5);
    
    centerPoints = floor([centerPoints(:,1) centerPoints(:,2)])
    numberOfFIPS = length(centerPoints); % detta stämmer nog inte dock..
    
    % ritar ut
    plot(centerPoints(:,2), centerPoints(:,1), 'g*');
    
end