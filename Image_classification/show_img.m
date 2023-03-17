function show_img(img)
figure();
h1 = title('Original image');
set(h1, 'Interpreter', 'latex')
imshow(img, [0 32], 'InitialMagnification', 'fit');
end
