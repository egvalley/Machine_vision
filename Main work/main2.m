clear all; close all; clc;
%% Pre-Processing 
archive = fopen('charact1.txt');% read the image
a = fscanf(archive,'%s',[64, 64]);
fclose(archive);

char2num = [zeros(1,'0'-1), 0:9, zeros(1,'A'-'9'-1), (0:('V'-'A')) + 10];% the mapping matrix
img = 32*mat2gray(char2num(a'),[0 32]);% convert the image into a 32-level gray image

Basic_Global_T = Basic_Global_Threshold(img);
Otsu_T = Otsu_T(img);
Gaus_T = Gaus_T(img);
Adap_M_T = Adap_M_T(img);
%% 1. Display the original image on screen.
show_img(img);
%% 2. Threshold the image and convert it into binary image.
figure();
subplot(2,2,1)
imshow(img>Basic_Global_T,'InitialMagnification','fit') %Global threshold image
title(['Basic Global T at ', num2str(Basic_Global_T)])
subplot(2,2,2)
imshow(img>Otsu_T,'InitialMagnification','fit') %Otsu threshold image
title(['Otsu T at ', num2str(Otsu_T)])
subplot(2,2,3)
imshow(Gaus_T,'InitialMagnification','fit') % Adaptive Gaussian threshold image
title(['Adaptive Gaussian T'])
subplot(2,2,4) 
imshow(Adap_M_T, 'InitialMagnification', 'fit'); %Adaptive Mean threshold image
title('Adaptive Mean T')
%% 3.Determine an one-pixel thin image of the objects (Zhang-Suen (ZS) thinning algorithm)
img_for_thin=img>Basic_Global_T;
ZS_thin_img=Zhang_Suen_Thin(img_for_thin);
figure();                      
imshow(ZS_thin_img,'InitialMagnification','fit');
title('Thinned Image 2');
%% 4.Determine the outlines.
img_sobel=Sobel_Operator(img);
figure();
imshow(img_sobel, 'InitialMagnification', 'fit')
title('Sobel Edge Detection V2')
%% 5. Label the different objects (4 & 8-connectivity)
binary = img>Basic_Global_T;
Label2 = CCL(binary);
Values2=unique(Label2,'stable');
Values2=[Values2(1); Values2(3); Values2(5); Values2(7); Values2(2); Values2(4); Values2(6)];

%% 6. Re-arrangement of characters
[img_cells, arr_img] = rearrange_new(Label2,Values2);
figure();
imshow(arr_img,'InitialMagnification', 'fit')
title('Rearrangement in one line')
%% 7. Rotate the output image by 30 degrees
rotate(arr_img)
%% 8. Recognize Number using SOMs
load imgs.mat
load labels_char_Unicode.mat
PCA_dim=60;
% Training images and Testing images processing
[Ori_img_tra,tra_PCA,tra_label]=Train_Data_Preprocess(imgs,labels_char_Unicode,PCA_dim);
[Ori_img_tes,tes_PCA,tes_label]=Test_Data_Preprocess(imgs,labels_char_Unicode,PCA_dim);
% Train the SOMs
[weights_label,weights]=SOMs_Train_Network(Ori_img_tra,tra_PCA,tra_label);
% Make predictions of testing dataset
test_pred=SOMs_Predict(tes_PCA,tes_label,weights,weights_label);
