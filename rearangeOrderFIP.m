% denna funktion ska klura ut vilken FIP som är vilken. 
function [lowerLeft, topLeft, topRight] = rearangeOrderFIP(FIPs)
    
    [~,indexMax] = max(pdist(FIPs)); % calc distance, where it distance max?    
    % sortera ut vilken ordning som triangeln ligger i.. 
    % A-------C
    % |    _/
    % |  _/
    % |_/
    % B/
    
    % olika förutsättningar, max i olika punkter, alltså längst avstånd
    % pdist = [ |pos1-pos2|, |pos1-pos3|, |pos2-pos3| ];
    % pdist ger ut svar liknande ovan, tar ut max distans, vet då vilken
    % pkt som inte är involverad i hypotenusan -> då är det A. 
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
    
    %perp dot product, http://geomalgorithms.com/vector_products.html
    k = AB(1)*AC(2) - AB(2)*AC(1);
    
    % AB _|_ AC > 0, då ligger AC till vänster om AB, dvs C är topRight
    if k > 0
        topRight = C;
        lowerLeft = B;
    else
        lowerLeft = C;
        topRight = B;
    end

    topLeft = A;

end