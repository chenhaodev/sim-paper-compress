% jsmp_example.m
% tests jsmp.m 

clear, close all, clc
path(path,'../../libs/Utils')

N = 4096; % signal length
J = 16; % signal sparsity
num_blocks = round(N/J);
K = round(0.05*num_blocks);
% so that overall sparsity = JK ~ 208

M = 600; % number of measurements

iter = 20;

% generate signal
v = randperm(num_blocks);
hi_col = v(1:K);
smat = zeros(J, num_blocks);
smat_hi = smat(:,hi_col);
smat_hi = randn(size(smat_hi));
smat(:,hi_col) = smat_hi;
x = smat(:);

% measurements
Phi = (1/sqrt(M))*randn(M,N);
y = Phi*x(:);

% reconstruct
[xhat, trsh] = jsmp(y,Phi,J,K,iter);

figure(1), hold on
box on
stem(x,'.','MarkerSize',10)
stem(xhat,'rd','MarkerSize',3)
axisfortex('','','')
legend('Original','Reconstruction')
