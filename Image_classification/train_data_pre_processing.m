function [imgs_sample,imgs_sample_PCA,imgs_sample_labels]=train_data_pre_processing(imgs,labels_char_Unicode)
    sample_num=0;
    for i= 1:3:size(imgs,2)
        sample_num=sample_num+1;
        img_reshape=reshape(imgs(:,i),[26,26]);
        img_reshape=Zhang_Suen_thin_new(img_reshape);
        img_reshape=Smoothing(img_reshape);
        img_reshape=Smoothing(img_reshape)>0.328;
        img_reshape=imresize(img_reshape,[14,12]);
        imgs_sample(:,sample_num)=img_reshape(:);
        imgs_sample_labels(sample_num)=labels_char_Unicode(i);
    end
    imgs_sample_PCA=PCA_algorithm(imgs_sample',100);
end