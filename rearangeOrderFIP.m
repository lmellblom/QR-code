% denna funktion ska klura ut vilken FIP som �r vilken. 
function [lowerLeft, topLeft, topRight] = rearangeOrderFIP(FIPs)
    
    [~,indexMax] = max(pdist(FIPs)); % calc distance, where it distance max?    
    % sortera ut vilken ordning som triangeln ligger i.. 
    % A-------C
    % |    _/
    % |  _/
    % |_/
    % B/
    
    % olika f�ruts�ttningar, max i olika punkter, allts� l�ngst avst�nd
    % pdist = [ |pos1-pos2|, |pos1-pos3|, |pos2-pos3| ];
    % pdist ger ut svar liknande ovan, tar ut max distans, vet d� vilken
    % pkt som inte �r involverad i hypotenusan -> d� �r det A. 
    switch indexMax
        case 1
            A = FIPs(3,:); %betyder att l�ngst avst�nd �r mellan pos 1 och 2, d�rf�r 3 pkt A
            B = FIPs(2,:); %godtyckligt?
            C = FIPs(1,:); %godtyckligt?
        case 2
            A = FIPs(2,:); %avst�nd l�ngst mellan pos 1 och pos 3, d�rf�r 2 pkt A
            B = FIPs(3,:); %godtyckligt?
            C = FIPs(1,:); %godtyckligt?
        case 3
            A = FIPs(1,:); %avst�nd l�ngst mellan pos 2 och pos 3, d�rf�r 1 pkt A
            B = FIPs(2,:); %godtyckligt?
            C = FIPs(3,:); %godtyckligt?
    end
   
    % vectors between points
    AB = B-A;
    AC = C-A;
    
    %perp dot product, http://geomalgorithms.com/vector_products.html
    k = AB(1)*AC(2) - AB(2)*AC(1);
    
    % AB _|_ AC > 0, d� ligger AC till v�nster om AB, dvs C �r topRight
    if k > 0
        topRight = C;
        lowerLeft = B;
    else
        lowerLeft = C;
        topRight = B;
    end

    topLeft = A;

end