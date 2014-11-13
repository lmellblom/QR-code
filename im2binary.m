function bin = im2binary(img)
level = graythresh(img);
BW = im2bw(img,level);
bin = BW;