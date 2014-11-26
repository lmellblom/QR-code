% denna funktion ska klura ut vilken FIP som är vilken. 
function [topLeft, topRight, lowerLeft] = rearangeOrderFIP(FIPs)
    
    [~,indexMax] = max(pdist(FIPs)); % calc distance, where it distance max?    
    % sortera ut vilken ordning som triangeln ligger i.. 
    % A-------C
    % |    _/
    % |  _/
    % |_/
    % B/
    
    % olika förutsättningar, max i olika punkter, alltså längst avstånd
    switch indexMax
        case 1
            A = FIPs(3,:); %betyder att längst avstånd är mellan pos 1 och 2, därför 3 pkt A
            B = FIPs(2,:); %godtyckligt?
            C = FIPs(1,:); %godtyckligt?
        case 2
            A = FIPs(2,:); %avstånd längst mellan pos 1 och pos 3, därför 2 pkt A
            B = FIPs(3,:); %godtyckligt?
            C = FIPs(1,:); %godtyckligt?
        case 3
            A = FIPs(1,:); %avstånd längst mellan pos 2 och pos 3, därför 1 pkt A
            B = FIPs(2,:); %godtyckligt?
            C = FIPs(3,:); %godtyckligt?
    end
   
    % vectors between points
    AB = B-A;
    AC = C-A;
    CB = B-C;
    
    k = atan2(AC(2),AC(1)) - atan2(AB(2),AB(1))
    
    %k = asin(AB/CB);
    %funka inte
    if k > 0
        lowerLeft = B;
        topRight = C;
    else
        lowerLeft = C;
        topRight = B;
    end

    topLeft = A;

end