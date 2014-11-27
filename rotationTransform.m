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

A = fips(2,:);
B = fips(1,:);
C = fips(3,:);

% Check angle for AB
BA = A - B;
BY = [0, BA(:,1)];

% Y  A
%
% B

theta = ((acos(BY/BA)));

rotated = imrotate(I,theta*(180/pi)-90);
%rotated = im2binarySimple(rotated);

% figure;
% imshow(rotated);
% hold on;
% plot(A(:,2), A(:,1),'g*');
% plot(C(:,2), C(:,1),'r*');
% plot(B(:,2), B(:,1),'b*');

n = floor(3); %Dont know if this is a good number
se = strel('square',n); %There is probably a better option, need to decide what square side
rotated = imclose(rotated,se);











