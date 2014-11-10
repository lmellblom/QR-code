% just a function that for now is to test the decodeQR.m file. 
clear all;
close all;

% just a test image at the moment, read in the "real" image later
img = ones(41);            
img(9,9) = 0; 

% get the message from the now image that is 41x41 pixels and ready to read
msg = decodeQR(img);

% display the message that was to be found. 
disp(msg);