% just a function that for now is to test the decodeQR.m file. 
clear all;
close all;

% just a test image at the moment, read in the "real" image later
img = imread('images/img_set2/test','png');    %testimage that i cropped

% process the image and all stuff
testImg = double(im2bw(img, graythresh(img))); % makes a binary image depending on grayvalue
% im2bw gives 0 or 1 depending on the threshold value of img. 

% get the message from the now image that is 41x41 pixels and ready to read
msg = decodeQR(testImg);

% display the message that was to be found. 
disp(msg);