%% Test 1
srcFiles = dir('images/img_set1/*.png');  % the folder in which ur images exists
for i = 1 : length(srcFiles)
    filename = strcat('images/img_set1/',srcFiles(i).name);
    I = imread(filename);
    message = tnm034(I)
end

%% Test 2
srcFiles = dir('images/img_set2/*.png');  % the folder in which ur images exists
for i = 1 : length(srcFiles)
    filename = strcat('images/img_set2/',srcFiles(i).name);
    I = imread(filename);
    message = tnm034(I)
end

%% Test 3
srcFiles = dir('images/img_set3/*.png');  % the folder in which ur images exists
for i = 1 : length(srcFiles)
    filename = strcat('images/img_set3/',srcFiles(i).name);
    I = imread(filename);
    message = tnm034(I)
end

%% Test 4
srcFiles = dir('images/img_set4/*.png');  % the folder in which ur images exists
for i = 1:length(srcFiles)
    filename = strcat('images/img_set4/',srcFiles(i).name);
    I = imread(filename);
    message = tnm034(I)
end

%% Test 5
srcFiles = dir('images/img_set5/*.png');  % the folder in which ur images exists
for i = 1 : length(srcFiles)
    filename = strcat('images/img_set5/',srcFiles(i).name);
    I = imread(filename);
    message = tnm034(I)
end

%% Test 6
% SISTA bilderna han lade upp, är typ svåraste... 
srcFiles = dir('images/img_newSet/*.png');  % the folder in which ur images exists
for i = 1 : length(srcFiles)
    filename = strcat('images/img_newSet/',srcFiles(i).name);
    I = imread(filename);
    message = tnm034(I)
end
