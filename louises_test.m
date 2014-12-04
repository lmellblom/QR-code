close all;
%img = imread('images/img_newSet/Husannons_full_Illum.png');
%img = imread('images/img_set2/Hus_1.png');
%img = imread('images/img_set1/Bygg_1.png');
img = imread('images/img_set3/Hus_2.png');

figure(1); label('orginal'); imshow(img);

%convert to grayscale
img = rgb2gray(img);
figure(2); imshow(img);

%adjust intensity levels
img = imadjust(img);
figure(3); imshow(img);

g_thresh = graythresh(img);

%create binary image
BW = im2bw(img, g_thresh);
figure(4); imshow(BW);

%segment image into 2 levels using 1 threshold
img = imquantize(img, g_thresh);
figure(5); imshow(img, []);

%segment image into x+1 levels using x thresholds
m_thresh = multithresh(img, 10);
img = imquantize(img, m_thresh);
img = label2rgb(img);
figure(6); imshow(img, []);
