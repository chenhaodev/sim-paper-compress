function [x, cost] = bpd(y, A, AH, lambda, mu, Nit)

% x = bpd(y, A, AH, lambda, mu, Nit)
%
% BASIS PURSUIT DENOISING
% minimize 0.5 * ||y - A x||_2^2 + lambda * || x ||_1
% where
% A * AH = I
%
% INPUT
%   A, AH - function handles
%   mu - Augmented Lagrangian parameter
%   Nit - Number of iterations
%
% OUTPUT
%   x : minimizing vector
%
% Use [x, cost] = bpd(...) to obtain cost function per iteration

% Reference
% M. V. Afonso, J. M. Bioucas-Dias, and M. A. T. Figueiredo.
% Fast image recovery using variable splitting and constrained optimization.
% IEEE Trans. Image Process., 19(9):2345Ð2356, September 2010.

if nargout > 1
    ComputeCost = true;
    cost = zeros(1, Nit);
else
    ComputeCost = false;
end    

x = AH(y);
d = zeros(size(x));

for i = 1:Nit
    u = soft(x + d, lambda/mu) - d;
    d = 1/(mu + 1) * AH(y - A(u));
    x = d + u;
    
    if ComputeCost
        residual = y - A(x);
        cost(i) = 0.5 * sum(abs(residual(:)).^2) + sum(abs(lambda * x(:))); 
    end
end

