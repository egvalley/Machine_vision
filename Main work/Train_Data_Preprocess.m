function [Ori_img,tra_PCA,tra_label]=Train_Data_Preprocess(imgs,label_unicode,PCA_dim)
    % Recording the number of samples
    sample_num=0;
    for i= 1:2:size(imgs,2) % the odd sequencies 
        sample_num=sample_num+1;

        % Reshape original images for an uniform format
        img_reshape=reshape(imgs(:,i),[26,26]);
        
        %img_reshape=Smoothing(img_reshape)>0.3;
        %img_reshape=Sobel_Operator(img_reshape);
        %img_reshape=Zhang_Suen_Thin(img_reshape);
        % Record the original information for each image
        Ori_img(:,sample_num)=img_reshape(:);
        tra_label(sample_num)=label_unicode(i);
    end
    % Use PCA algorithm to get the main information
    tra_PCA = PCA_Algorithm(Ori_img',PCA_dim);
end