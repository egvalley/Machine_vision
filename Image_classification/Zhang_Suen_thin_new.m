function ZS_thin_img = Zhang_Suen_thin_new(bi_img)
[num_row,num_col]=size(bi_img);% Get the numbers of columns and rows
ZS_thin_img=zeros(num_row,num_col);% Create a new matrix for processing
img_iter=bi_img;% Original image = the firt interating image


while 1
    ZS_thin_img=img_iter;
    [obj_rows,obj_cols]=find(img_iter==1);

    for i = 1:length(obj_rows)

        rand_array=randperm(length(obj_rows));

        row_iter=obj_rows(rand_array(1));
        col_iter=obj_cols(rand_array(1));

        if row_iter==1 || row_iter==num_row
            continue
        elseif col_iter==1 || col_iter==num_col
            continue
        end


            % Kernel Construction (P1,P2,P3...P8,P9,P2)
            ZS_Kernel = [img_iter(row_iter,col_iter) img_iter(row_iter-1,col_iter) img_iter(row_iter-1,col_iter+1)...
                         img_iter(row_iter,col_iter+1) img_iter(row_iter+1,col_iter+1) img_iter(row_iter+1,col_iter)...
                         img_iter(row_iter+1,col_iter-1) img_iter(row_iter,col_iter-1) img_iter(row_iter-1,col_iter-1) img_iter(row_iter-1,col_iter)];


            % A(P1) Construction
            A_P1 = 0;
            for k = 2:size(ZS_Kernel,2)-1
                if ZS_Kernel(k) == 0 && ZS_Kernel(k+1) == 1
                     A_P1 = A_P1 + 1;
                end
            end

            % Establish the conditions
            if (A_P1==1&&ZS_Kernel(1) == 1 && sum(ZS_Kernel(2:9)) <= 6 && sum(ZS_Kernel(2:9)) >= 2 &&...
                ZS_Kernel(2)*ZS_Kernel(4)*ZS_Kernel(6) == 0 && ZS_Kernel(4)*ZS_Kernel(6)*ZS_Kernel(8) == 0)
                ZS_thin_img(row_iter,col_iter)=0;
                %imshow(ZS_thin_img);
                break;
            end
            % Establish the conditions
            if (A_P1==1&&ZS_Kernel(1) == 1 && sum(ZS_Kernel(2:9)) <= 6 && sum(ZS_Kernel(2:9)) >= 2&&...
                ZS_Kernel(2)*ZS_Kernel(4)*ZS_Kernel(8) == 0 && ZS_Kernel(2)*ZS_Kernel(6)*ZS_Kernel(8) == 0)
                ZS_thin_img(row_iter,col_iter)=0;
                %imshow(ZS_thin_img);
                break;
            end
        
    end

    
    if sum(sum(img_iter ~= ZS_thin_img))
        img_iter=ZS_thin_img;
    else
        break;
    end

end

end