function Label2 = CCL(binary)
% 5.1. 4-Neighbouring Connectivity
%  Padding for boundary conditions
Label= padarray(double(binary), [1 1], 0, 'both');
% Set initial variables
[m, n] = size(binary);
new_Label = 0; 
% Symbolize the pixel values (0 and 1) to perform the scanning 
Label(Label==0)=-1;
Label(Label==1)=-3;
%Scan the binary image and label components 
for i=2:m
    for j=2:n
        Current_Pixel = Label(i,j);
        if Current_Pixel == -3                                          % If current pixel is or not the object
            left_neigbor = Label(i-1,j);                                     % The pixels are scanned from left to right. Hence, only consider the previously scanned values
            above_neigbor = Label(i,j-1);                                    % And, omit the future values {Label(i,j+1) and Label(i+1,j)}
            if above_neigbor > 0                                             % If the above one is labeled
                Label(i,j)=above_neigbor;                                        % Then inherit the above label
                if  left_neigbor>0 && ~(left_neigbor==above_neigbor)               % If the left one is available/labelled and not same as the above one(label contradiction)
                    Label(Label==above_neigbor) = left_neigbor;                       % Then all the contradictory labels are kept the same as the left one
                end
            elseif left_neigbor > 0 && above_neigbor < 0                      % If the left one is labeled and the above one is not labeled
                Label(i,j) = left_neigbor;                                       % Then inherit the left label
            else                                                            % If the above one is not labeled and the left one is not labeled
                new_Label = new_Label + 1;                                      % Then create a new label
                Label(i,j) = new_Label;
            end
        end
    end
end
% Delete the padding boundary
Label = Label(2:end-1,2:end-1);
% Desymbolization & Relabelling
Label(Label==-1)=0;
Values=unique(Label); % Get the final labels % 4-Connected Component Classes, 

% Label connected components
figure();
subplot(1,2,1)
imshow(label2rgb(uint8(Label),'jet','k','shuffle'),'InitialMagnification', 'fit')
title('4-neighbour connectivity')

% 5.2. 8-Neighbouring Connectivity
%  Padding for boundary conditions
Label2= padarray(double(binary), [1 1], 0, 'both');
% Set initial variables
[m, n] = size(binary);
new_Label = 0; 
% Symbolize the pixel values (0 and 1) to perform the scanning 
Label2(Label2==0)=-1;
Label2(Label2==1)=-3;
%Scan the binary image and label components 
for i=2:m
    for j=2:j
        Current_Pixel = Label2(i,j);
        if Current_Pixel == -3
            left_above_neigbor = Label2(i-1,j-1);
            left_neigbor = Label2(i-1,j);
            above_neigbor = Label2(i,j-1);
            left_below_neigbor = Label2(i-1,j+1);
            if above_neigbor > 0
                Label2(i,j)=above_neigbor;
                if ~(left_above_neigbor==above_neigbor) && left_above_neigbor > 0
                    Label2(Label2==above_neigbor)=left_above_neigbor;
                elseif ~(left_neigbor==above_neigbor) && left_neigbor > 0
                    Label2(Label2==above_neigbor)=left_neigbor;
                elseif ~(left_below_neigbor==above_neigbor) && left_below_neigbor > 0
                    Label2(Label2==above_neigbor)=left_below_neigbor;
                end
            elseif left_above_neigbor > 0
                Label2(i,j)=left_above_neigbor;
                if ~(left_above_neigbor==left_below_neigbor) && left_below_neigbor > 0
                    Label2(Label2==left_above_neigbor)=left_below_neigbor;
                end
            elseif left_neigbor > 0
                Label2(i,j)=left_neigbor;               
            elseif left_below_neigbor > 0
                Label2(i,j)=left_below_neigbor;                
            else
                new_Label = new_Label + 1;
                Label2(i,j) = new_Label;
            end
        end
    end
end
Label2(Label2==-1)=0;
Label2=Label2(2:end-1,2:end-1);
Values2=unique(Label2,'stable');
Values2=[Values2(1); Values2(3); Values2(5); Values2(7); Values2(2); Values2(4); Values2(6)];
% Label connected components
subplot(1,2,2)
imshow(label2rgb(uint8(Label2),'jet','k','shuffle'),'InitialMagnification', 'fit')
title('8-neighbour connectivity')
end
