%% Test 1
% "Byggbutiken online! URL: http://www.byggstommar.se"
srcFiles = dir('images/img_set1/*.png');  % the folder in which ur images exists

numbersCorrect = 0;
correct = 'Byggbutiken online! URL: http://www.byggstommar.se';

disp('Test 1 startades');
disp('...');
tic
for i = 1 : 1%length(srcFiles)
    filename = strcat('images/img_set1/',srcFiles(i).name);
    I = imread(filename);
    message = tnm034(I);
    
    %srcFiles(i).name
    
    % test if right message
    m = cellstr(message);
    if strcmp(m{1},correct)
        numbersCorrect = numbersCorrect + 1;
    else
        disp(['Bild ' srcFiles(i).name ' failade med meddelandet: ' ]);
        disp(message);
    end
    
end

toc
%test how many sucedded
percent = round((numbersCorrect/length(srcFiles))*100);
disp(['Test klart. ' num2str(percent) '% lyckades!']);

%% Test 2
srcFiles = dir('images/img_set2/*.png');  % the folder in which ur images exists

numbersCorrect = 0;
correct = 'Typ: Fastigheten Älmhult Jämnhult 1:28. Friliggande villa. Byggår 1980. Boarea ca 260 m², biarea ca 70 m². Areauppgifter enligt säljaren. 6 rum, varav 4 sovrum. Tomtarea 4 514 m².';

disp('Test 2 startades');
disp('...');
tic
for i = 1 : length(srcFiles)
    filename = strcat('images/img_set2/',srcFiles(i).name);
    I = imread(filename);
    message = tnm034(I);
    
    % test if right message
    m = cellstr(message);
    if strcmp(m{1},correct)
        numbersCorrect = numbersCorrect + 1;
    else
        disp(['Bild ' srcFiles(i).name ' failade med meddelandet: ' ]);
        disp(message);
    end
end

toc
%test how many sucedded
percent = round((numbersCorrect/length(srcFiles))*100);
disp(['Test klart. ' num2str(percent) '% lyckades!']);

%% Test 3
srcFiles = dir('images/img_set3/*.png');  % the folder in which ur images exists
numbersCorrect = 0;
correct = 'Typ: Fastigheten Älmhult Jämnhult 1:28. Friliggande villa. Byggår 1980. Boarea ca 260 m², biarea ca 70 m². Areauppgifter enligt säljaren. 6 rum, varav 4 sovrum. Tomtarea 4 514 m².';

disp('Test 3 startades');
disp('...');
tic
for i = 1 : length(srcFiles)
    filename = strcat('images/img_set3/',srcFiles(i).name);
    I = imread(filename);
    message = tnm034(I);
    
    %srcFiles(i).name % Hus_2c fungerar ej
    
    % test if right message
    m = cellstr(message);
    if strcmp(m{1},correct)
        numbersCorrect = numbersCorrect + 1;
    else
        disp(['Bild ' srcFiles(i).name ' failade med meddelandet: ' ]);
        disp(message);
    end
end

toc
%test how many sucedded
percent = round((numbersCorrect/length(srcFiles))*100);
disp(['Test klart. ' num2str(percent) '% lyckades!']);

%% Test 4
srcFiles = dir('images/img_set4/*.png');  % the folder in which ur images exists
numbersCorrect = 0;
correct = 'Typ: Fastigheten Älmhult Jämnhult 1:28. Friliggande villa. Byggår 1980. Boarea ca 260 m², biarea ca 70 m². Areauppgifter enligt säljaren. 6 rum, varav 4 sovrum. Tomtarea 4 514 m².';

disp('Test 4 startades');
disp('...');
tic
for i = 1 : length(srcFiles)
    filename = strcat('images/img_set4/',srcFiles(i).name);
    I = imread(filename);
    message = tnm034(I);
    
    % test if right message
    m = cellstr(message);
    if strcmp(m{1},correct)
        numbersCorrect = numbersCorrect + 1;
    else
        disp(['Bild ' srcFiles(i).name ' failade med meddelandet: ' ]);
        disp(message);
    end
    
end

toc
%test how many sucedded
percent = round((numbersCorrect/length(srcFiles))*100);
disp(['Test klart. ' num2str(percent) '% lyckades!']);

%% Test 5
srcFiles = dir('images/img_set5/*.png');  % the folder in which ur images exists
numbersCorrect = 0;
correct = 'Typ: Fastigheten Älmhult Jämnhult 1:28. Friliggande villa. Byggår 1980. Boarea ca 260 m², biarea ca 70 m². Areauppgifter enligt säljaren. 6 rum, varav 4 sovrum. Tomtarea 4 514 m².';

disp('Test 5 startades');
disp('...');
tic
for i = 1 : length(srcFiles)
    filename = strcat('images/img_set5/',srcFiles(i).name);
    I = imread(filename);
    message = tnm034(I);
    
    % test if right message
    m = cellstr(message);
    if strcmp(m{1},correct)
        numbersCorrect = numbersCorrect + 1;
    else
        disp(['Bild ' srcFiles(i).name ' failade med meddelandet: ' ]);
        disp(message);
    end
end

toc
%test how many sucedded
percent = round((numbersCorrect/length(srcFiles))*100);
disp(['Test klart. ' num2str(percent) '% lyckades!']);

%% Test 6
% SISTA bilderna han lade upp, är typ svåraste... 
srcFiles = dir('images/img_newSet/*.png');  % the folder in which ur images exists

disp('Test 6 startades');
disp('...');
tic
for i = 1 : length(srcFiles)
    filename = strcat('images/img_newSet/',srcFiles(i).name);
    I = imread(filename);
    message = tnm034(I);
    disp(['Meddelande bild ' i ': ' message]);
    
end

toc
disp('Klart.');