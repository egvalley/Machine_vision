function Gaus_T = Gaus_T(img)
%2.3. Adaptive Gaussian Threshold
% Gaussian Filtering
sigma = 1.0;
kernel = zeros(3,3); % Suppose the filter size is 3x3 = (2k+1)(2k+1) where k = 1
k = 1;
ksum = 0; % Sum of kernel elements (for normalization)

for i=1:size(kernel,1)
    for j=1:size(kernel,2)
        dist = (i-(k+1))^2 + (j-(k+1))^2;
        kernel(i,j) = exp(-dist/(2*sigma^2))/(2*pi*sigma^2);
        ksum = ksum + kernel(i,j);
    end
end
kernel = kernel/ksum;

[m, n] = size(img);
img_frame = zeros(m,n);
Im = padarray(img, [1 1], 0, 'both'); %Padded image for the kernel to scan 

for i = 1:m
    for j = 1:n
        conv = Im(i:i+2, j:j+2).*kernel';
        img_frame(i,j) = sum(conv(:));
    end
end
% Thresholding
Gaus_T = double((img_frame - img) > 3);
% Invert the binary image
for i=1:size(Gaus_T,1)
    for j=1:size(Gaus_T,2)
        if Gaus_T(i,j)==1;
            Gaus_T(i,j)=0;
        elseif Gaus_T(i,j)==0
            Gaus_T(i,j)=1;
        end
    end
end
Gaus_T = Gaus_T;
end
