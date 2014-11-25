%% Test 1
srcFiles = dir('images/img_set1/*.png');  % the folder in which ur images exists
correct = 0;
for i = 1 : length(srcFiles)
    filename = strcat('images/img_set1/',srcFiles(i).name);
    I = imread(filename);
    [n,loc] = findFIP(I);
    if(n==3)
        correct = correct + 1;
    end
end
if ( correct == length(srcFiles) )
  disp('TEST 1 succeded');
end

%% Test 2
srcFiles = dir('images/img_set2/*.png');  % the folder in which ur images exists
correct = 0;
for i = 1 : length(srcFiles)
    filename = strcat('images/img_set2/',srcFiles(i).name);
    I = imread(filename);
    [n,loc] = findFIP(I);
    if(n==3)
        correct = correct + 1;
    end
end
if ( correct == length(srcFiles) )
  disp('TEST 2 succeded');
end

%% Test 3
srcFiles = dir('images/img_set3/*.png');  % the folder in which ur images exists
correct = 0;
for i = 1 : length(srcFiles)
    filename = strcat('images/img_set3/',srcFiles(i).name);
    I = imread(filename);
    [n,loc] = findFIP(I);
    if(n==3)
        correct = correct + 1;
    end
end

if ( correct == length(srcFiles) )
  disp('TEST 3 succeded');
end

%% Test 4
srcFiles = dir('images/img_set4/*.png');  % the folder in which ur images exists
correct = 0;
for i = 1 : length(srcFiles)
    filename = strcat('images/img_set4/',srcFiles(i).name);
    I = imread(filename);
    [n,loc] = findFIP(I);
    if(n==3)
        correct = correct + 1;
    end
end
if ( correct == length(srcFiles) )
  disp('TEST 4 succeded');
end

%% Test 5
srcFiles = dir('images/img_set5/*.png');  % the folder in which ur images exists
correct = 0;
for i = 1 : length(srcFiles)
    filename = strcat('images/img_set5/',srcFiles(i).name);
    I = imread(filename);
    [n,loc] = findFIP(I);
    if(n==3)
        correct = correct + 1;
    end
end
if ( correct == length(srcFiles) )
  disp('TEST 5 succeded');
end

%% Test 6
% SISTA bilderna han lade upp, är typ svåraste... 
srcFiles = dir('images/img_newSet/*.png');  % the folder in which ur images exists
correct = 0;
for i = 1 : length(srcFiles)
    filename = strcat('images/img_newSet/',srcFiles(i).name);
    I = imread(filename);
    [n,loc] = findFIP(I);
    if(n==3)
        correct = correct + 1;
    end
end
if ( correct == length(srcFiles) )
  disp('TEST 6 succeded');
end