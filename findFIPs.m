function FIPs = findFIPs(FIPCandidates)
    if( length(FIPCandidates) < 3 )
        % blivit fel!
        FIPs = [ ];
    else 
        % separerar ut de true FIPS med k-means.
        % om fått tre punkter väldigt nära varandra, görs till en.
        % http://se.mathworks.com/help/stats/kmeans.html#buefthh-3
        [idx, centerPoints] = kmeans(FIPCandidates,3,'Distance','cityblock',...
                           'Replicates',5);

        centerPoints = floor([centerPoints(:,1) centerPoints(:,2)]);

        % verifiera punkterna typ iaf vi har en outlier.. dist från
        % centerpointen typ, plocka ur de som är närmast då... har 3 kluster
        % så vi inte får en centerpunkt som ligger helt åk fanders ;) 
        for i=1:3
            calculatedPos = centerPoints(i,:);
            realLocation = FIPCandidates(idx==i,:);
            [~,index] =min( pdist2( calculatedPos, realLocation, 'euclidean') );
            FIPs(i,:)=realLocation(index,:); % plocka ut en av de som har kortast distans
        end
        
        % rätt ordning på FIP:sen
        [lowerLeft, topLeft, topRight] = getRightOrderOfFIPs(FIPs);

        rightOrder = [lowerLeft; topLeft; topRight];
        FIPs=rightOrder;
    end
    

end