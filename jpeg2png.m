folder= 'home/omer/proje/trainMiccai/training_jpeg/01/*.jpg';
ds = imageDatastore(folder)
while hasdata(ds) 
    img = read(ds) ;             % read image from datastore
    figure, imshow(img);    % creates a new window for each image
end