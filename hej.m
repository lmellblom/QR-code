% srcFiles = dir('images/img_set1/*.png');  % the folder in which ur images exists
% for i = 1 : length(srcFiles)
%     filename = strcat('images/img_set1/',srcFiles(i).name);
%     I = imread(filename);
%     %figure; findFIP(I);
%     n = findFIP(I);
%     if(n<3)
%         disp('nej, hitta inte alla FIPS');
%     end
% end
% 
% srcFiles = dir('images/img_set2/*.png');  % the folder in which ur images exists
% for i = 1 : length(srcFiles)
%     filename = strcat('images/img_set2/',srcFiles(i).name);
%     I = imread(filename);
%     %figure; findFIP(I);
%     n = findFIP(I);
%     if(n<3)
%         disp('nej, hitta inte alla FIPS');
%     end
% end
% 
% srcFiles = dir('images/img_set3/*.png');  % the folder in which ur images exists
% for i = 1 : length(srcFiles)
%     filename = strcat('images/img_set3/',srcFiles(i).name);
%     I = imread(filename);
%     %figure; findFIP(I);
%     n = findFIP(I);
%     if(n<3)
%         disp('nej, hitta inte alla FIPS');
%     end
% end
% 
% srcFiles = dir('images/img_set4/*.png');  % the folder in which ur images exists
% for i = 1 : length(srcFiles)
%     filename = strcat('images/img_set4/',srcFiles(i).name);
%     I = imread(filename);
%     %figure; findFIP(I);
%     n = findFIP(I);
%     if(n<3)
%         disp('nej, hitta inte alla FIPS');
%     end
% end

srcFiles = dir('images/img_set5/*.png');  % the folder in which ur images exists
for i = 1 : length(srcFiles)
    filename = strcat('images/img_set5/',srcFiles(i).name);
    I = imread(filename);
    figure; 
    n = findFIP(I)
    if(n<3)
        disp('nej, hitta inte alla FIPS');
        %figure;imshow(I);
    end
end