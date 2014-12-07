%  1-D Orthogonal Matching Pursuit
%  meaturement M>=K*log(N/K), K is sparsity, N is signal length
%  Email: chenhaomails@gmail.com
%  Joel A. Tropp and Anna C. Gilbert, Signal Recovery From Random Measurements Via Orthogonal Matching Pursuit, IEEE TRANSACTIONS ON INFORMATION THEORY, VOL. 53, NO. 12, DECEMBER 2007.

clc;clear

% Generate Signal
K=7;        
N=256;   
M=64;     % M>=K*log(N/K), > 40
f1=50;    
f2=100;   
f3=200;   
f4=400;     
fs=800;   %  sampling rate
ts=1/fs;  %  sampling interval
Ts=1:N;  
x=0.3*cos(2*pi*f1*Ts*ts)+0.6*cos(2*pi*f2*Ts*ts)+0.1*cos(2*pi*f3*Ts*ts)+0.9*cos(2*pi*f4*Ts*ts);  %  Full signal

%%  2. Sampling Matrix
Phi=randn(M,N);                  %  Guassian Matrix
s=Phi*x.';                       %  Observation 

%%  3. OMP Recovery
m=2*K;                           %  Iterative times (m>=K)
Psi=fft(eye(N,N))/sqrt(N);       %  DFT Matrix
T=Phi*Psi';                      %  Full Sensing Matrix

hat_xf=zeros(1,N);               %  Recovered Freq                     
Aug_t=[];                        %  Desired Index
r_n=s;                           %  Residue

for times=1:m;                                  
    % Find the index that solves the easy optimization problem 
    for col=1:N;                             %  All Inner Product
        product(col)=abs(T(:,col)'*r_n);            
    end
    [val,pos]=max(product);                  %  Position of Max Inner Product 
    
    % Augment the index set and the matrix of chosen atoms 
    Aug_t=[Aug_t,T(:,pos)];                  %  Expand the Desired Index
    T(:,pos)=zeros(M,1);                     %  For the selected index, next time I will not select it 

    % Solve a least squares problem 
    aug_y=(Aug_t'*Aug_t)^(-1)*Aug_t'*s;      %  LS Solution in Matrix Form

   % Calculate the new approximation and new residue
    r_n=s-Aug_t*aug_y;                           
    pos_array(times)=pos;                         
end
hat_xf(pos_array)=aug_y;                     %  Recover Freq
hat_x=real(Psi'*hat_xf.');                   %  Recover Time domain points by inverse DFT via the recovered freq

%%  4. Comparison of original data vs recovered data
figure(1);

hold on;
plot(hat_x,'b.-')                            %  recovered
plot(x,'r')                                  %  original
legend('Recovery','Original')

norm(hat_x.'-x)/norm(x)                      %  distance
