
function [weights_labels,weights]=SOMs_Train_Network(Ori_img,tra_PCA,tra_label)

% Set up the information of train data
train_data=tra_PCA;
num_images=size(train_data,2);
train_label=tra_label;
img_dim=[26 26];
% Set up the SOM parameters
nenum=10;
output_dim = [nenum nenum];% the 2D neural map 10*10
num_neurons = output_dim(1)*output_dim(1);
num_epochs = 20;
learning_rate_initial =1.2;
sigma_initial=sqrt(output_dim(1)^2+output_dim(2)^2)/2;
% Initialize the weights
weights = rand(size(train_data,1), num_neurons);

% Step 4: Train the SOM network using the image data
for epoch = 1:num_epochs
    % Shuffle the data for each epoch
    shuffled_data = train_data(:, randperm(num_images));
    
    % Update the SOM parameters
    lr_n=2*learning_rate_initial*exp(-epoch/num_epochs);
    sigma_n = sigma_initial*exp(-epoch/(num_epochs/log(sigma_initial)));
    
    % Train the SOM network on the shuffled data
    for i = 1:num_images
        img_x = shuffled_data(:, i);
        [~, bmu] = min(sum((weights - img_x).^2)); % Find the best matching unit (BMU)
        bmu_col_num = mod(bmu, output_dim(2));% the column number in the neuron map
        bmu_row_num = floor(bmu/output_dim(2));% the row number in the neuron map
        for j = 1:num_neurons
            dist = sqrt((bmu_col_num - mod(j, output_dim(2)))^2 + (bmu_row_num - floor(j/output_dim(2)))^2); % Calculate the distance between the BMU and the current neuron
            neighbor_function = exp(-dist^2/(2*sigma_n^2));
            % Update the weights of the current neuron
            weights(:, j) = weights(:, j) + lr_n *neighbor_function* (img_x - weights(:, j));           
        end
    end
end

% Step 5: Generate a semantic map for each neuron
figure;
for i = 1:num_neurons
    % Find the input patterns that activate the current neuron the most
    [~, index] = min(sum((weights(:,i) - train_data).^2)); % Find the best matching image and return the index
    weights_labels(i)=train_label(index);
    % Visualize the semantic map
    subplot(output_dim(1), output_dim(2), i);
    imshow(reshape(Ori_img(:,index), [img_dim(1), img_dim(2)]));
    sgtitle(sprintf('Neuron %d SOMs semantic map', i));
end
hold off;
end