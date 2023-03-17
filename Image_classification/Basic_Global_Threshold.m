function Basic_Global_T = Basic_Global_Threshold(img)
%2.1. Basic Global Thresholding
T=randi(20); %Define the initial thresholding randomly
T0=0;

G1=img<=T;
G2=img>T;
mean1=mean(img(G1));% calculate the mean of pixels larger than thresholding value
mean2=mean(img(G2));% calculate the mean of pixels smaller than thresholding value

while abs(T-T0)>10^-10 % setting the tolerance
    T0=T;% record the previous threholding value
    T=(mean1+mean2)/2; % update the thresholding
    G1=img<=T;
    G2=img>T;
    mean1=mean(img(G1));
    mean2=mean(img(G2));
end
Basic_Global_T = T;
end