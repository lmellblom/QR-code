function [numberOfFIPS, trueFIPS] = findFIP(img)

    numberOfFIPS = 0;
    locationFIP = [0 0];
    
    % test bara nu, ska skicka in en bild sen som är grayscaled
    %img = imread('images/img_set2/test','png');
    %img = imread('images/img_set2/Hus_1','png');
    %img = imread('images/img_set5/Hus_4d','png'); % hittar aldrig i denna!!
   
    % 3 - Number of thresholds used for adaptive thresholding!
    %Doesn't work perfectly yet, but better than just 1 threshold.
    % 3 can of course be changed to desired number of thresholds
    img = im2binary(img, 3);
    
  %  figure;
  %  imshow(img);
  %  hold on;
    
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
                            numberOfFIPS = numberOfFIPS + 1;
                            locationFIP = [locationFIP; [row col]];
                        end
                    end  
                    pixelPosRow = pixelPosRow + length_module_col(j);
                end
           
            end
            pixelPosCol = pixelPosCol + length_modules(i); % adds the pixelvalue.. 
        end

    end
    
    locationFIP = locationFIP(2:end,:);
    
    % separerar ut de true FIPS med k-means.
    % om fått tre punkter väldigt nära varandra, görs till en.
    % http://se.mathworks.com/help/stats/kmeans.html#buefthh-3
    [idx, centerPoints] = kmeans(locationFIP,3,'Distance','cityblock',...
                       'Replicates',5);
    
    centerPoints = floor([centerPoints(:,1) centerPoints(:,2)]);
    numberOfFIPS = length(centerPoints); % detta stämmer nog inte dock..
    
    % verifiera punkterna typ iaf vi har en outlier.. dist från
    % centerpointen typ, plocka ur de som är närmast då... har 3 kluster
    % så vi inte får en centerpunkt som ligger helt åk fanders ;) 
    for i=1:3
        calculatedPos = centerPoints(i,:);
        realLocation = locationFIP(idx==i,:);
        [~,index] =min( pdist2( calculatedPos, realLocation, 'euclidean') );
        trueFIPS(i,:)=realLocation(index,:); % plocka ut en av de som har kortast distans
    end
            
    % rätt ordning på FIP:sen
    [topLeft,topRight, lowerLeft] = rearangeOrderFIP(trueFIPS);
    
    rightOrder = [topLeft; topRight; lowerLeft]
    
    trueFIPS=rightOrder;
    
    % ritar ut
    %plot(topLeft(:,2), topLeft(:,1),'g*');
    %plot(topRight(:,2), topRight(:,1),'r*');
    %plot(lowerLeft(:,2), lowerLeft(:,1),'b*');
    %plot(rightOrder(:,2), rightOrder(:,1), 'g*');
    
end