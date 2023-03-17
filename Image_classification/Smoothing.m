function img_frame=Smoothing(img)
    % step1: Smoothing - Gaussian function
    sigma = 1.0;
    kernel = zeros(3,3); % Suppose the filter size is 3x3 = (2k+1)(2k+1) where k = 1
    k = 1;
    ksum = 0; % Sum of kernel elements
    
    for i=1:size(kernel,1)
        for j=1:size(kernel,2)
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
end