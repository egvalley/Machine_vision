function Otsu_T = Otsu_T(img)
%2.2. Optimum Thresholding (Otsu's Method)
%2.2.1. Create the histogram
Intensity_Level = zeros(1,32);
sz = size(img);
for i = 1:sz(1)
    for j = 1:sz(2);
        z = img(i,j);
        Intensity_Level(z+1) = Intensity_Level(z+1) + 1;
    end
end
%2.2.2. Set the initial variables (Maximum variance, Total pixels and Sigma)
Max_V = 0;
Total_P = sum(Intensity_Level);
Sigma = zeros(1,32);
%2.2.3. Work out probability levels of all pixels in the array
Prob = Intensity_Level/Total_P;
%2.2.4. For-Loop
for i = 1:length(Intensity_Level)
    Wb = sum(Prob(1:i));% the sum of possibility of c1
    Wf = sum(Prob(i+1:end));% the sum of possibility of c2
    Ub = dot(0:i-1,Prob(1:i))/Wb;% the avarage intensity of c1
    Uf = dot(i:31,Prob(i+1:32))/Wf;% the avarage intensity of c2
    Sigma(i) = sqrt(Wb*Wf*((Ub-Uf)^2));
end 
Max_V = max(Sigma);
Otsu_T = find(Sigma==Max_V)-1;
end
