% cosamp_example.m
% tests cosamp.m

clear, close all, clc
%path(path,'../Utils')

N = 1024; % signal length
K = 40; % signal sparsity
M = 240; % number of measurements

iter = 10; % number of Cosamp iterations

% generate signal
x = zeros(N,1);
v = randperm(N);
x(v(1:K)) = randn(K,1);

% measurements
Phi = (1/sqrt(M))*randn(M,N);
y = Phi*x;

% reconstruct
[xhat, ~] = cosamp(y,Phi,K,iter);

figure(1), hold on
box on
stem(x,'.','MarkerSize',10)
stem(xhat,'rd','MarkerSize',3)
axisfortex('','','')
legend('Original','Reconstruction')