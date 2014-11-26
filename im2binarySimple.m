function bin = im2binarySimple(img)
level = graythresh(img);
BW = im2bw(img,level);
bin=BW;