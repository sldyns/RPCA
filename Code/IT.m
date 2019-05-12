function [A,E] = IT(D,mu)

D = double(D);
[m,n] = size(D);
lambda = 1/sqrt(max(m,n));
Y = double(rand(m,n));
E = double(rand(m,n));
k = 1;
esp = 1e-4;
nD = norm(D,'fro');


cred = 1;
while(cred>esp)
    [U,S,V] = svd(D-E+Y/mu);
    A = U*S_ep(S,1/mu)*V';
    E = S_ep(D-A+Y/mu,lambda/mu);
    Y = Y + mu*(D-A-E);
    mu = mu*1.01;
    k = k+1;
    
    cred = norm(D-A-E,'fro')/nD;
end

end