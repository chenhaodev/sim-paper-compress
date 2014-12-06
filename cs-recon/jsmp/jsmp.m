% jsmp.m
% Performs CS reconstruction of 1D block-sparse signals, joint sparsity
%
% INPUTS
% Y      : measurements (M x 1)
% Phi     : measurement matrix (M x N)
% J       : Block size
% S       : number of active blocks
% iter     : number of iterations
% 
% OUTPUTS
% X_hat    : Signal estimate (N x 1) 
% xjsmp   : Matrix with N rows and at most iter columns; 
%           columns represent intermediate signal estimates   
%
% CITE    : Richard Baraniuk, Volkan Cevher, Marco Duarte, Chinmay Hegde
%          "Model-based compressive sensing", submitted to IEEE IT, 2008.
%
% The model for block-sparsity used here is equivalent to the JSM-2 
% model introduced in:
% Baron et al, "Distributed Compressive Sensing", preprint 2009
% See 'DCS-SOMP Algorithm for JSM-2'
% JSM = joint sparsity model

function [X_hat,xjsmp] = jsmp(Y, Phi, J, S, iter);

Y = Y(:); % 
[M,N] = size(Phi);
num_blocks = round(N/J);

xjsmp = zeros(N,iter); 
k=1; 
maxiter= 100;
verbose= 0;
tol= 1e-3;
s_jsmp = zeros(N,1);

while le(k,iter),
    residue_jsmp = Y - Phi*(s_jsmp);  %% residue
    proxy_jsmp = Phi'*(residue_jsmp);
   
    %--------------------------------------------%
    %-----Insert approximation algorithm here----%
    %--------------------------------------------%
    %-----JSM-MP
    % pick the S largest blocks. Easy.
    proxy_jsmp_block = reshape(proxy_jsmp, J, num_blocks); %% reshape the proxy_jsmp to J*num_block matrix
    [~,blockww] = sort(sum(proxy_jsmp_block.^2,1),'descend'); %% column elements.^2 sum, vector results
    newsupp = zeros(J,num_blocks);
    newsupp(:,blockww(1:S)) = 1;    %% select S largest column and fill '1'(represent supp)
    newsupp = reshape(newsupp, N, 1); %% reshape to N*1 vector
    tt_jsmp=union(find(ne(s_jsmp,0)),find(newsupp==1));  %% use S largest supp to union signals
    %-----/Insert----%

    %------Estimate------%
    [w_jsmp, res, iter] = cgsolve(Phi(:,tt_jsmp)'*Phi(:,tt_jsmp), Phi(:,tt_jsmp)'*Y,...
                                        tol,maxiter, verbose);
    bb1= zeros(N,1);
    bb1(tt_jsmp)= w_jsmp;
    %---Prune----%
    k = k+1;   
    
    bb1_block = reshape(bb1, J, num_blocks);
    [~,blockww] = sort(sum(bb1_block.^2,1),'descend');
    newsupp = zeros(J,num_blocks);
    newsupp(:,blockww(1:S)) = 1;
    newsupp = reshape(newsupp, N, 1);  %% the same as 'pick the S largest blocks'
    s_jsmp=0*s_jsmp;
    s_jsmp = bb1.*newsupp;
    xjsmp(:,k) = s_jsmp;
    
    if (norm(xjsmp(:,k)-xjsmp(:,k-1)) < 5e-3*norm(xjsmp(:,k)))
       break;
    end
end
xjsmp(:,k+1:end)=[];
X_hat = xjsmp(:,end);
