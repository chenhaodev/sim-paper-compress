function X = pSTFT(x,R,Nfft)
% X = pSTFT(x,R,Nfft)
% Parseval short-time Fourier Transform with 50 percent overlap.
% Each block is multiplied by a cosine window.
% Input:
% x - 1D signal
% R - block length (must be even)
% Nfft - length of FFT (Nfft >= R)
%
% % Example:
% [s,fs] = wavread('sp1.wav');
% N = 20000;
% x = s(1:N)';  
% R = 512;
% Nfft = 1024;
% X = pSTFT(x,R,Nfft);
% y = ipSTFT(X,R,N);
% max(abs(x - y))  % verify perfect reconstruction

% Ivan Selesnick
% Polytechnic Institute of New York University
% revised August 2009

x = x(:).';  % Ensure that x is a row vector.

% cosine window
n = (1:R) - 0.5;
window  = cos(pi*n/R-pi/2);

% normalization constant
M = 2;
NC = sqrt(sum(window.^2) * M * Nfft/R);

% to deal with first and last block:
x = [zeros(1,R) x zeros(1,R)];

Nx = length(x);
Nc = ceil(2*Nx/R)-1;        % Number of blocks (cols of X)
L = R/2 * (Nc + 1);
if Nx < L
    x = [x zeros(1,L-Nx)];  % zero pad x as neccessary 
end
X = zeros(R,Nc);
i = 0;
for k = 1:Nc
    X(:,k) = window .* x(i + (1:R));   % multiply signal by window
    i = i + R/2;
end
X = fft(X,Nfft);            % FFT applied to each column of X
X = X/NC;

