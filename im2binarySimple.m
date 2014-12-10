%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%function bin = im2binarySimple(img)
%
%Receives an original image and uses perpective transformation to transform it to
%a straight, readable image.
%Returns straight, grayscale image.
%Part of a pattern recognition project TNM034 - Advanced Image Processing, Linköping
%University HT2014.
%
%Copyright (c) <2014> Karolin Jonsson, Louise Carlström, Linnea Nåbo, Linnea Mellblom
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function bin = im2binarySimple(img)

% Find the gray threshold level
level = graythresh(img);

% Make the image binary using the level
BW = im2bw(img,level);

bin=BW;