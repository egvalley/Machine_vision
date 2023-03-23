function [img_cell,char_img]=rearrange_new(Label2,Values2)
% step1: find the window size for each character
for i = 1:length(Values2)-1
    [row{i},col{i}]=find(Label2==Values2(i+1));
    char_win_size{i}=[max(row{i})-min(row{i})+1,max(col{i})-min(col{i})+1];
end

% step2: select the maximum window size among these characters
pixel_max_row=0;
pixel_max_col=0;
for i = 1:length(char_win_size)
    if pixel_max_row<char_win_size{i}(1)
        pixel_max_row=char_win_size{i}(1);
    end
    if pixel_max_col<char_win_size{i}(2)
        pixel_max_col=char_win_size{i}(2);
    end
end

% step3: arrange these characters in one line
char_img=[];
img_cell={};
re_img=zeros(pixel_max_row,pixel_max_col);
for i =1:length(Values2)-1
    for n =1:char_win_size{i}(1)
        for m=1:char_win_size{i}(2)
            re_img(n,m)=Label2(min(row{i})+n-1,min(col{i})+m-1);
        end
    end
    img_cell(i)={re_img};
    char_img=[char_img,re_img];
end

end