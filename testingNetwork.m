data = load('convNet.mat');
testnet = data.net;
dataSetDir = fullfile('/home/omer/proje/calismaSon/test/');
imageDir = fullfile(dataSetDir,'testingImages');
labelDir = fullfile(dataSetDir,'testingLabels');

imds = imageDatastore(imageDir);

classNames = ["mitotik","nonmitotik"];
labelIDs   = [1 0];

pxdsTruth = pixelLabelDatastore(labelDir,classNames,labelIDs);

pxdsResults = semanticseg(imds,testnet,'WriteLocation',tempdir);

metrics = evaluateSemanticSegmentation(pxdsResults,pxdsTruth)



