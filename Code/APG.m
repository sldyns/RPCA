function [A,E] = APG(D,mu)

D = double(D);
[m,n] = size(D);
lambda = 1/sqrt(max(m,n));
mu_ = 0.01;
eta = 0.99;
esp = 1e-4;

A_0 = zeros(m,n); A_1 = zeros(m,n);
E_0 = zeros(m,n); E_1 = zeros(m,n);
t_0 = 1; t_1 = 1;
k = 0;
nD = norm(D,'fro');

cred = 1;
while(cred>esp)
    Y_A = A_1 + (t_0-1)/t_1*(A_1-A_0);
    Y_E = E_1 + (t_0-1)/t_1*(E_1-E_0);
    G_A = Y_A - (Y_A+Y_E-D)/2;
    [U,S,V] = svd(G_A);
    A_0 = A_1; A_1 = U*S_ep(S,mu/2)*V';
    G_E = Y_E - (Y_A+Y_E-D)/2;
    E_0 = E_1; E_1 = S_ep(G_E,lambda*mu/2);
    t_0 = t_1; t_1 = (1+sqrt(4*t_1^2+1))/2;
    mu = max(eta*mu,mu_);
    
    k = k+1;
    
    cred = norm(D-A_1-E_1,'fro')/nD;
end
A = A_1; E = E_1;
end