function pixelValues = scanImage(img)

img = im2binary(img); %convert to gray image

[height, width] = size(img); % height and width

tolerance = 0.4; % en modul kan skilja sig +- 0.5
% referencemall för hur mkt FIP kan skilja sig
reference = [0.1429 0.1429 0.4286 0.1429 0.1429];
tol_high =  tolerance*reference(1) + reference;
tol_low = reference - tolerance*reference(1);

modSize_row = [1];
modSize_col = [1];

%imshow(img)
%hold on

posRow = [1,1];
posCol = [1,1];

k=1; l = 1;

numberOfFips = 0;

% scan pixels of each row of the image and record the length of the black and white
% modules.
for row = 1:height
	vector = img(row,:); %plockar ut en hel vector ur raden i bilden 
	length_modules = ones(1,length(vector)); % allokerar bara med 1:or
	
    % gå igenom hela raden
    for i = 1:length(vector)-1
		if vector(i) == vector(i+1)
			length_modules(k)=length_modules(k)+1;
		else
			k = k+1;
		end
    end
    length_modules = length_modules(1:k); % all the moduels in the pic

    
    % take every consecutive 5 elements of this lentgh recording of the row and divide
    % it by the sum of these 5 elemets to calculate the ratio
    col = 1;
    pixelposition = 1; % pixelvärdet som modulen börjar på!!
    for i = 1:length(length_modules)-4
        refer = length_modules(i:i+4);
        ratio = refer ./ sum(refer);
        
        % kolla om ratio ligger mellan de "tillåtna" värdena
        if (ratio >= tol_low)
            if (ratio <= tol_high)
                   % disp('FIP');
                    if (img(row,pixelposition)==0); %om första pixelvärdet är svart, är då kanske FIP, steg 3 i KTH-rapporten
                        
                        % find a potential FIP, search the col
                        col = pixelposition + floor(sum(refer)/2); % mitten positionen
                        
                        % plocka ut columen
                        vector2 = img(:,col);
                        length_modules2 = ones(1,length(vector2));
                        
                        % gå igenom hela raden
                        for i2 = 1:length(vector2)-1
                            if vector2(i2) == vector2(i2+1)
                                length_modules2(l)=length_modules2(l)+1;
                            else
                                l = l+1;
                            end
                        end
                        length_modules2 = length_modules2(1:l); % all the moduels in the pic
                        
                        row2 = 1;
                        pixelposition2 = 1; % pixelvärdet som modulen börjar på!!
                        for i3 = 1:length(length_modules2)-4
                            refer2 = length_modules2(i3:i3+4);
                            ratio2 = refer2 ./ sum(refer2);
                        
                        % kolla om ratio ligger mellan de "tillåtna" värdena
                        if (ratio2 >= tol_low)
                            if (ratio2 <= tol_high)
                                   % disp('FIP');
                                   if (img(pixelposition2,col)==0)
                                        row2 = pixelposition2 + floor(sum(refer2)/2);
                                        
                                        
                                        % borde ha hittat en FIP!!! 
                                        % om row är ungefär samma, spara
                                        % fip
                                        if (row < row2+2 && row > row2-2)
                                            numberOfFips = numberOfFips+1;
                                            %disp('EN FIP');
                                            %disp(row);disp(col);
                                            %plot(col, row,'y*');
                                            
                                            posRow = [posRow; [row,col]]; 
                                            modSize_row = [modSize_row; sum(refer)];
                                            
                                        end
                                        
                                        
                                        
                                   end
                            end
                        end

                        pixelposition2 = pixelposition2 + length_modules2(i3);

                    k=1;
                    end
                        
                        
                        l=1;
                        
                       % pos = [row, col];  
                        %posRow = [posRow; [row,col]]; 
                        %modSize_row = [modSize_row; sum(refer)]; % längden av FIP:en
                        %plot(col, row,'r*'); % i plot skrivs nog col och row tvärtom
                    end
            end
        end
         
        pixelposition = pixelposition + length_modules(i);
    
    k=1;
    end
end

% 
% % scan each pixel of the col
% k=1;
% for col = 1:width
% 	vector = img(:,col); %plockar ut en hel vector ur raden i bilden 
% 	length_modules = ones(1,length(vector)); % allokerar bara med 1:or
% 	
%     % gå igenom hela raden
%     for i = 1:length(vector)-1
% 		if vector(i) == vector(i+1)
% 			length_modules(k)=length_modules(k)+1;
% 		else
% 			k = k+1;
% 		end
%     end
%     length_modules = length_modules(1:k); % all the moduels in the pic
% 
%     
%     % take every consecutive 5 elements of this lentgh recording of the row and divide
%     % it by the sum of these 5 elemets to calculate the ratio
%     row = 1;
% 
%     pixelposition = 1; % pixelvärdet som modulen börjar på!!
%     for i = 1:length(length_modules)-4
%         refer = length_modules(i:i+4);
%         ratio = refer ./ sum(refer);
%         
%         % kolla om ratio ligger mellan de "tillåtna" värdena
%         if (ratio >= tol_low)
%             if (ratio <= tol_high)
%                    % disp('FIP');
%                    if (img(pixelposition,col)==0)
%                         row = pixelposition + floor(sum(refer)/2);
%                         posCol = [posCol; [row,col]];   
%                         modSize_col = [modSize_col; sum(refer)];
%                         %plot(col, row,'b*'); % i plot skrivs nog col och row tvärtom
%                    end
%             end
%         end
%          
%         pixelposition = pixelposition + length_modules(i);
%     
%     k=1;
%     end
%end

% ta bort fulgrejs när vi la in 1,1 för att allokera minnet... måste lösa
% sen med allokering av detta...
numberOfFips
posCol = posCol(2:end,:);
posRow = posRow(2:end,:)
modSize_col = modSize_col(2:end, :);
modSize_row = modSize_row(2:end, :);

% find max moduleSize
maxModCol = mode(modSize_col);
maxModRow = mode(modSize_row);

% ta bort de FIP som har för lite modulSize:
%I = modSize_col > (maxModCol*0.9) || modSize_col < (maxModCol*0.9);
%posCol = posCol(I,:);
%modSize_col = modSize_col(I) %bara höfta 95% hehehe
%I = modSize_row > (maxModRow*0.95) || modSize_row < (maxModRow*0.95);
%modSize_row = modSize_row( I,:)
%posRow = posRow(I,:);


%plot(posCol(:,2), posCol(:,1), 'b*');
%plot(posRow(:,2), posRow(:,1), 'r*');

% plockar ut de som är FIP genom att jämföra row och col-position
[Lia,Locb] = ismember(posCol, posRow,'rows');


% mod-size på de som är FIPS:en
%mod_col = modSize_col(Lia,:)./7  %7 är det vi vet att en FIP "ska" va
%mod_row = modSize_row(Lia,:)./7

% hämtar ut pixelvärdena på FIP
pixelValues = posCol(Lia,:);

%plot(pixelValues(:,2), pixelValues(:,1),'g*'); % i plot skrivs nog col och row tvärtom

    
    
% testning av lite olika matlab-inbyggda funktioner.. kanske kan underlätta 
%for y = 1:width
%    vector = img(y,:);      % tar ut varje rad för rad för att analysera
%    I = find(vector==0);    % find every position where the pixel is black
%    J = (diff(I)==1)             % see if there are any difference between each pixel (as that a row of blacks)  
    
%end

end
