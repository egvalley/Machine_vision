function NMS_thresholded=Sobel_Operator(img)
% step1: Smoothing - Gaussian function
sigma = 1.0;
kernel = zeros(3,3); % Suppose the filter size is 3x3 = (2k+1)(2k+1) where k = 1
k = 1;
ksum = 0; % Sum of kernel elements

for i=1:3
    for j=1:3
        dist = (i-(k+2))^2 + (j-(k+2))^2;
        kernel(i,j) = exp(-dist/(2*sigma^2))/(2*pi*sigma^2);
        ksum = ksum + kernel(i,j);
    end
end
kernel = kernel/ksum; % Normalized Kernel for smoothing

[m, n] = size(img);
img_frame = zeros(m,n);
Im = padarray(img, [1 1], 0, 'both'); %Padded image for the kernel to scan 

for i = 1:m
    for j = 1:n
        conv = Im(i:i+2, j:j+2).*kernel;% convolution with the smoothing kernel
        img_frame(i,j) = sum(conv(:));% the sum of kernel is recored as a new pixel: this new pixel contains the information around neighbors
    end
end

% step:2 Intensity Gradient - Sobel Operator
Gx = [-1 0 1; -2 0 2; -1 0 1];
Gy = [1 2 1; 0 0 0; -1 -2 -1];

for i = 1:m-2
    for j = 1:n-2
        ax = Gx.*img_frame(i:i+2, j:j+2);% convolution with the Sobel operator
        ay = Gy.*img_frame(i:i+2, j:j+2);% convolution with the Sobel operator
        
        ax2 = ((ax(1,3)+ax(2,3)+ax(3,3))+(ax(1,1)+ax(2,1)+ax(3,1))); % delta x
        ay2 = ((ay(1,1)+ay(1,2)+ay(1,3))+(ay(3,1)+ay(3,2)+ay(3,3))); % delta y
        
        img_frame(i,j) = sqrt(ax2.^2+ay2.^2); %The magnitude of the gradient 'f'
    end 
end
sobel_threshold = round(max(img_frame)*0.4); % threholding set: 40%
output_image = max(img_frame,sobel_threshold);
output_image(output_image==round(sobel_threshold))=0;

% step:3 Non-maximum Suppression (NMS)
for i=2:m-1
    for j=2:n-1
        pixels = [output_image(i-1,j-1) output_image(i-1,j) output_image(i-1,j+1); 
            output_image(i,j-1) output_image(i,j) output_image(i,j+1);
            output_image(i+1,j-1) output_image(i+1,j) output_image(i+1,j+1)];
        %"IF" statements : if the center pixel is greater than the
        %neighbors, preserve the center pix value. if not, suppress
        if ((pixels(2,2) > pixels(2,3)) && (pixels(2,2) > pixels(2,1))) ||...
                ((pixels(2,2) > pixels(1,2)) && (pixels(2,2) > pixels(3,2)))
            NMS(i,j) = pixels(2,2);
        else
            NMS(i,j) = 0;
        end
    end
end

NMS_thresholded = NMS > 0.2;% Return to binary image
end
