function transform2square()%Im, f1, f2, f3, f4)

% Read image (should be passed to the function)
Im = imread('Hus_4.png');
Im = rgb2gray(Im);

% Make the new image the same size as the current (not necessary the best
% option)
[width,height] = size(Im);

% Select the points in the image and the reference image
number_of_points = 8;
col_values = [1148; 1320; 2246; 2050; 1090; 1278; 2076; 1986]; %outer, inner of f1,2,3,4
row_values = [376;  560;  384;   568; 1456; 1284; 1376; 1296];
col_values_true = [0; 70; 410; 340; 0;   60;  370; 320];
row_values_true = [0; 70; 0;   70;  410; 340; 370; 320];

% Collect coordinates from the image and the reference image
false_pic = [row_values(:) col_values(:) ones(number_of_points,1)] %values of the false pic
true_pic = [row_values_true(:) col_values_true(:) ones(number_of_points,1)] %values of the true pic

% Find transformation matrix
x = false_pic\true_pic;

% Fit geometry
[X,Y] = meshgrid(1:height,1:width);
M = [Y(:) X(:) ones(width*height,1)];

% Translate and get matrix P
P = M(:,1:3)*x;
P = round(P);

% Loop through every pair of coordiantes, check if positive
for k=1:(width*height)
        u = P(k,1);
        v = P(k,2);
        w = P(k,3);
        
    if(0<u && u<=width && 0<v && v<=height)          
        newim(u/w,v/w) = Im(k);   
    end
    
end

imshow(Im);
figure;
imshow(newim);

