function pixelValues = scanImage(img)

img = im2binary(img); %convert to gray image

[height, width] = size(img); % height and width

tolerance = 0.3; % en modul kan skilja sig +- 0.5
% referencemall för hur mkt FIP kan skilja sig
reference = [0.1429 0.1429 0.4286 0.1429 0.1429];
tol_high =  tolerance*reference(1) + reference;
tol_low = reference - tolerance*reference(1);

imshow(img)
hold on

posRow = [1,1];
k=1;
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
                        col = pixelposition + floor(sum(refer)/2); % mitten positionen
                       % pos = [row, col];  
                        posRow = [posRow; [row,col]]; 
                        %plot(col, row,'r*'); % i plot skrivs nog col och row tvärtom
                    end
            end
        end
         
        pixelposition = pixelposition + length_modules(i);
    
    k=1;
    end
end

posCol = [1,1];

% scan each pixel of the col
k=1;
for col = 1:width
	vector = img(:,col); %plockar ut en hel vector ur raden i bilden 
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
    row = 1;

    pixelposition = 1; % pixelvärdet som modulen börjar på!!
    for i = 1:length(length_modules)-4
        refer = length_modules(i:i+4);
        ratio = refer ./ sum(refer);
        
        % kolla om ratio ligger mellan de "tillåtna" värdena
        if (ratio >= tol_low)
            if (ratio <= tol_high)
                   % disp('FIP');
                   if (img(pixelposition,col)==0)
                        row = pixelposition + floor(sum(refer)/2);
                        posCol = [posCol; [row,col]];                 
                        %plot(col, row,'b*'); % i plot skrivs nog col och row tvärtom
                   end
            end
        end
         
        pixelposition = pixelposition + length_modules(i);
    
    k=1;
    end
end

% ta bort fulgrejs när vi la in 1,1 för att allokera minnet... måste lösa
% sen med allokering av detta...
posCol = posCol(2:end,:);
posRow = posRow(2:end,:);

[Lia,Locb] = ismember(posCol, posRow,'rows');

pixelValues = posCol(Lia,:);

plot(pixelValues(:,2), pixelValues(:,1),'g*'); % i plot skrivs nog col och row tvärtom

    
    
% testning av lite olika matlab-inbyggda funktioner.. kanske kan underlätta 
%for y = 1:width
%    vector = img(y,:);      % tar ut varje rad för rad för att analysera
%    I = find(vector==0);    % find every position where the pixel is black
%    J = (diff(I)==1)             % see if there are any difference between each pixel (as that a row of blacks)  
    
%end

end
