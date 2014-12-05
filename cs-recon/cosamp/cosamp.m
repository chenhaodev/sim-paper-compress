% cosamp.m
% D. Needell and J. Tropp, "CoSaMP: iterative signal recovery from 
% incomplete and inaccurate measurements" , ACHA, 2009
% 
% INPUTS
% Y : measurement (M x 1)
% Phi: sensing matrix (M x N)
% S  : signal sparsity
% iter: number of iterations
% 
% OUTPUTS
% X_hat   : estimated signal  (N x 1) 
% X_cosamp: matrix with N rows, at most iter columns,
%           where the columns represent intermediate estimated signal 
%
% created by chen hao
% email: dreamclinger@gmail.com

function [X_hat,X_cosamp] = cosamp(Y, Phi, S, iter)

Y = Y(:);
[M,N] = size(Phi);

X_cosamp = zeros(N,iter);
k=1; 
maxiter= 1000;
verbose= 0;
tol= 1e-3;
s_cosamp = zeros(N,1);
residue_cosamp = Y - Phi*(s_cosamp);

while le(k,iter),
    k = k+1; 
    
    %-----Backprojection---%
    proxy_cosamp = Phi'*(residue_cosamp);
    [~,ww]= sort(abs(proxy_cosamp),'descend');          %%Identify large components (sort,prepare)
    tt_cosamp= union(ww(1:(2*S)),find(ne(s_cosamp,0))); %%Merge supports
    
    %------Estimate------%
    [w_cosamp, res, iter] = cgsolve(Phi(:,tt_cosamp)'*Phi(:,tt_cosamp), Phi(:,tt_cosamp)'*Y,...
                                        tol,maxiter, verbose);%%Signal estimation by least-squares
                                                              %%Q:why not directly LS matrix solver?                                                          
  
    bb2= zeros(N,1);
    bb2(tt_cosamp)= w_cosamp;  %%Let complement supportted element keep zero
     
    %---Prune----%
    [~,ww2]= sort(abs(bb2),'descend'); s_cosamp=0*bb2; %%Notice: clear zero
    s_cosamp(ww2(1:S))= bb2(ww2(1:S));   %%Prune to obtain next approximation
    
    X_cosamp(:,k) = s_cosamp; % in current iteration, the estimated signal 
    residue_cosamp = Y - Phi*(s_cosamp);
    
    if (norm(X_cosamp(:,k)-X_cosamp(:,k-1)) < 1e-2*norm(X_cosamp(:,k))) %%Error converges
       break;
    end
    
end
X_cosamp(:,k+1:end)=[];
X_hat = X_cosamp(:,end);
