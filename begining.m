%send training images and csv
trainPath=('/home/omer/proje/calismaSon/trainFirstFile');
[outFolderCsv,outFolderImg]=Processing(trainPath);

directoryCsv=('/home/omer/proje/calismaSon/train/trainingLabels');
if ~exist(directoryCsv,'dir')
    mkdir(directoryCsv);
end

directoryImg=('/home/omer/proje/calismaSon/train/trainingImages');
if ~exist(directoryImg,'dir')
    mkdir(directoryImg);
end


movefile (fullfile(outFolderCsv), fullfile(directoryCsv));
movefile (fullfile(outFolderImg), fullfile(directoryImg));

%send testing images and csv

testPath=fullfile('/home/omer/proje/calismaSon/testFirstFile');
[outFolderCsv,outFolderImg]=Processing(testPath);

directoryCsv=('/home/omer/proje/calismaSon/test/testingLabels');
if ~exist(directoryCsv,'dir')
    mkdir(directoryCsv);
end

directoryImg=('/home/omer/proje/calismaSon/test/testingImages');
if ~exist(directoryImg,'dir')
    mkdir(directoryImg);
end

movefile (fullfile(outFolderCsv), fullfile(directoryCsv));
movefile (fullfile(outFolderImg), fullfile(directoryImg));