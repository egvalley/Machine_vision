function [Test_Data,Test_ClassLabel]=test_data_pre_processing(img_cells)
Test_Data=[];
Test_ClassLabel=[double('1'),double('2'),double('3'),double('A'),double('B'),double('C')];

for i= 1:length(img_cells) 
    img_cells{i}=img_cells{i}>0.5;
    %
    thin_imgage=Zhang_Suen_thin_new(img_cells{i});
    smooth_image=Smoothing(thin_imgage);
    %
    Test_Data=[Test_Data,smooth_image(:)>0.4];
    
end
figure();
imshow(reshape(Test_Data(:,3),[14,12]));
Test_Data=PCA_algorithm(Test_Data',100);
end