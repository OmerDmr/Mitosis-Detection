dataSetDir = fullfile('/home/omer/proje/calismaSon/train/');
imageDir = fullfile(dataSetDir,'trainingImages');
labelDir = fullfile(dataSetDir,'trainingLabels');

imds = imageDatastore(imageDir);

classNames = ["mitotik","nonmitotik"];
labelIDs   = [1 0];
pxds = pixelLabelDatastore(labelDir,classNames,labelIDs);




filterSize = [7 7];
numClasses = numel(classNames);
imageSize=[512 512]

lgraph = segnetLayers(imageSize,numClasses,2)


inputLayer = imageInputLayer([512 512 1])
classNames = ["mitotik","nonmitotik"];
labelIDs   = [1 0];
pxds = pixelLabelDatastore(labelDir,classNames,labelIDs);




filterSize = [7 7];
numClasses = numel(classNames);


middleLayers = [
                
    convolution2dLayer(filterSize, 32, 'Padding', 1)
    batchNormalizationLayer
    reluLayer()
    maxPooling2dLayer(3, 'Stride',2)
    dropoutLayer
    
    convolution2dLayer(filterSize, 64, 'Padding', 1)
    batchNormalizationLayer
    reluLayer()
    convolution2dLayer(filterSize, 64, 'Padding', 1)
    batchNormalizationLayer
    reluLayer()
    maxPooling2dLayer(2, 'Stride',2)
    dropoutLayer
    
    convolution2dLayer(filterSize, 128, 'Padding', 1)
    batchNormalizationLayer
    reluLayer()
    convolution2dLayer(filterSize, 128, 'Padding', 1)
    batchNormalizationLayer
    reluLayer()
    maxPooling2dLayer(2, 'Stride',2)
    dropoutLayer
    
    ];

finalLayers = [
    fullyConnectedLayer(numClasses)
    reluLayer()
    softmaxLayer()
    classificationLayer()
];



layers = [
    inputLayer
    middleLayers
    finalLayers
    ]

classNames = ["mitotik","nonmitotik"];
labelIDs   = [1 0];
pxds = pixelLabelDatastore(labelDir,classNames,labelIDs);




filterSize = [7 7];
numClasses = numel(classNames);

opts = trainingOptions('sgdm', ...
    'InitialLearnRate',1e-3, ...
    'MaxEpochs',200, ...
    'ValidationFrequency',30, ...
    'MiniBatchSize',64,...
    'Plots','training-progress');


trainingData = pixelLabelImageDatastore(imds,pxds);

net=trainNetwork(trainingData,lgraph,opts)

save convNet.mat net
