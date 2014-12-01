%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%function Im = rotationTransform()
%
%Receives an original image and uses rotation transformation to transform it to
%a straight image that can be used in perspectiveTransform.
%Returns grayscale image.
%Part of a pattern recognition project TNM034 - Advanced Image Processing, Linköping
%University HT2014.
%
%Copyright (c) <2014> Karolin Jonsson, Louise Carlström, Linnea Nåbo, Linnea Mellblom
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function rotated = rotationTransform(I, fips)

% A   C
%
% B
% 
% figure;
% imshow(I);
% hold on;
% plot(fips(1,2), fips(1,1),'g*');
% plot(fips(2,2), fips(2,1),'r*');
% plot(fips(3,2), fips(3,1),'b*');

A = fips(2,:);
B = fips(1,:);
C = fips(3,:);

[width_orig, height_orig] = size(I);

% Check angle for AB
BA = A - B;
BC = C - B;
OB = B - B;
BY = [0, BA(:,1)];
YA = [0, BA(:,2)];

% Y  A
%
% B

theta = ((acos(BY/BA))- (pi/2));

% The rotated image
rotated = imrotate(I,theta*(180/pi));
[width_new, height_new] = size(rotated);
diff = [width_new-width_orig,0];%height_new-height_orig]

X =  [cos(theta) -sin(theta); 
      sin(theta) cos(theta)];

A2 = (X*(A'))';
B2 = (X*(B'))';
C2 = (X*(C'))';

A3 = A2 + diff;
B3 = B2 + diff;
C3 = C2 + diff;

% figure;
% imshow(rotated);
% hold on;
% plot(A3(:,2), A3(:,1),'g*');
% plot(C3(:,2), C3(:,1),'r*');
% plot(B3(:,2), B3(:,1),'b*');

n = floor(1); %Dont know if this is a good number
se = strel('square',n); %There is probably a better option, need to decide what square side
rotated = imclose(rotated,se);











