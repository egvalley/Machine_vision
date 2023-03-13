clear all
clc

load('traindata.mat');
[U, S, V] = svd_reduced(traindata, 2)

function [U, S, V] = svd_reduced(A, k)
% Reduced SVD algorithm
% Input: A - matrix to be decomposed, k - number of singular values to compute
% Output: U, S, V - matrices such that A = U*S*V'

% Compute eigenvalues and eigenvectors of A'*A
[eigenvectors_V, eigenvalues_V] = eig(A'*A);

% Sort eigenvalues in descending order
[eigenvalues_sorted_V, ind] = sort(diag(eigenvalues_V), 'descend');

% Compute singular values
S = sqrt(eigenvalues_sorted_V);

% Compute matrix V
V = eigenvectors_V(:,ind(1:k));

% Compute matrix U
U = zeros(size(A, 1), k);
for i = 1:k
    U(:,i) = (1/S(i)) * A * V(:,ind(i));
end

% Keep only the first k singular values
S = S(1:k);
end