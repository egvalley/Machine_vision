function rotate(Arr_img)
[row,col]= size(Arr_img); 
rad=deg2rad(30);                     
%Mid-points of the previous image (Arr_img)
xo=round(row/2);                                                            
yo=round(col/2);

%Calculate array dimesions to create enough space for the output iamge
row2=round(row*(cos(rad))+col*(sin(rad)));                      
col2=round(row*(sin(rad))+col*(cos(rad)));

%Mid-points of the output image (Rotated_img)
Rotated_img=(zeros([row2 col2]));
mid_x=round(size(Rotated_img,1)/2);
mid_y=round(size(Rotated_img,2)/2);

% Calculate corresponding pixel coordinates of the previous image
% for each pixel of the output image.
for i=1:row2
    for j=1:col2                                                       

        x = i-mid_x;
        y = j-mid_y;
        Transform = [x y]*[cos(rad) -sin(rad); sin(rad) cos(rad)];
                 
        x_new=round(Transform(1))+xo;
        y_new=round(Transform(2))+yo;
         
         %Assign intensity values if (x,y) coordinates are in the bound
         %of the "Arr_img" image 
         if (x_new>=1 && x_new<=row) && (y_new>=1 &&  y_new<=col) 
              Rotated_img(i,j)=Arr_img(x_new,y_new);  
         end
    end
end
figure();
imshow(Rotated_img,'InitialMagnification', 'fit')
title(['Rotate 30 degrees']);
end
