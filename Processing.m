function[outFolderCsv,outFolderImg]=Processing(filepath)

filenamesCsv=dir(fullfile(filepath,'*.csv'));
filenamesImg = dir(fullfile(filepath, '*.jpg'));

total_images = numel(filenamesImg)
totalfiles=numel(filenamesCsv)

outFolderCsv='/home/omer/proje/calismaSon/newFolder';
if ~exist(outFolderCsv, 'dir')
       mkdir(outFolderCsv);
end 
outFolderImg='/home/omer/proje/calismaSon/new2Folder';
if ~exist(outFolderImg, 'dir')
       mkdir(outFolderImg);
end       

for i = 1:total_images
     fullnameImg=fullfile(filepath,filenamesImg(i).name);
     
     imageCsv=zeros(512,512);
     a=sprintf('%d.csv',i);
     i
     if exist(a)
         fullnameCsv=fullfile(filepath,filenamesCsv(i).name);
          csvdata= csvread(fullnameCsv);
            j=1;
            k=1; 
            while j<=size(csvdata,1)
                row=csvdata(j,k);
                col=csvdata(j,(k+1));
                imageCsv(row,col)=255;
                j=j+1;
            end 
     end
    
     fullnameImg=imageProcessing(fullnameImg);
     fullnameImg=imbinarize(fullnameImg);
     imageCsv=imbinarize(imageCsv);
     
   baseFileName=sprintf('%d.jpg',i);
   fullFileName=fullfile(outFolderImg,baseFileName);
   imwrite(imresize(fullnameImg,[512 512]),fullFileName);
   
   baseFileName=sprintf('%d-labelled.png',i);
   fullFileName=fullfile(outFolderCsv,baseFileName);
   imwrite(imresize(imageCsv,[512 512]),fullFileName);
     
         
end


end