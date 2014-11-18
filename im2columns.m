function small_im = im2columns(im, col_size, row_size)

imshow(im);
hold on;

for k=1:41
    for i=1:41
        newim(i,k) = im(round((i*row_size - row_size/2)),round((k*col_size- col_size/2)));
        plot((i*row_size - row_size/2),(k*col_size- col_size/2), '*r');
        hold on;
    end
end

figure;
imshow(newim);
small_im = newim;

%%
% [height, width] = size(im);
% img = im; 
% posRow = [1,1];
% k=1;

% for row = 1:height
% 	vector = img(row,:); %plockar ut en hel vector ur raden i bilden 
% 	length_modules = ones(1,length(vector)); % allokerar bara med 1:or
% 	k = 1;
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
% end
% small_im = im;
