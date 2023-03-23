function Adap_M_T = Adap_M_T(img)
%2.4. Adaptive Mean Thresholding
[m, n] = size(img);
img_frame = zeros(m,n);
Im = padarray(img, [1 1], 0, 'both'); %Padded image for the kernel to scan 
for i = 1:m
    for j = 1:n
        kernel = [1 1 1; 1 1 1; 1 1 1];
        if i == 1 || i == n
            conv = Im(i:i+2,j:j+2).*kernel/6;
            if j == 1 || j == n
                conv = Im(i:i+2,j:j+2).*kernel/4;
            end
        elseif j == 1 || j == m
            conv = Im(i:i+2,j:j+2).*kernel/6;
            if i == 1 || i == m
                conv = Im(i:i+2,j:j+2).*kernel/4;
            end            
        else
            conv = Im(i:i+2,j:j+2).*kernel/9;
        end  
        img_frame(i,j) = sum(conv(:));
    end
end
Adap_M_T = double((img_frame - img) > 3); % (Adaptive T - Original T) > 3
% Invert the binary image
for i=1:size(Adap_M_T,1)
    for j=1:size(Adap_M_T,2)
        if Adap_M_T(i,j)==1;
            Adap_M_T(i,j)=0;
        elseif Adap_M_T(i,j)==0
            Adap_M_T(i,j)=1;
        end
    end
end
Adap_M_T = Adap_M_T;
end
