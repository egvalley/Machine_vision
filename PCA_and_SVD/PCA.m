clear all
clc

% Load data
load('traindata.mat');
data=traindata;
[m, n] = size(data);

% Center the data
mean_data = mean(data);
data_centered = data - repmat(mean_data, m, 1);

% Compute the covariance matrix
covariance_matrix = (data_centered' * data_centered) / (m - 1);

% Compute the eigenvectors and eigenvalues of the covariance matrix
[eigenvectors, eigenvalues] = eig(covariance_matrix);

% Sort the eigenvalues in descending order
[eigenvalues_sorted, index] = sort(diag(eigenvalues), 'descend');
eigenvectors_sorted = eigenvectors(:, index);

% Compute the principal components
score = data_centered * eigenvectors_sorted;

% Select the first(or any number you want) principal components
score_1d = score(:, 1);
