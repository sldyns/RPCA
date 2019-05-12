function [A,E] = IALM(D,method)

D = double(D);
[m,n] = size(D);
lambda = 1/sqrt(max(m,n));
rho = 1.6;
esp_1 = 1e-4;
esp_2 = 1e-5;
mu = 1.25/norm(D,2);
nD = norm(D,'fro');

A = zeros(m,n);
E = zeros(m,n);
Y = D/max(norm(D,2),norm(D,inf)/lambda);
k = 0;

cred = 1;
while(cred>esp_1)
    E_s = E;
    [U,S,V] = svd(D-E+Y/mu);
    A = U*S_ep(S,1/mu)*V';
    E = S_ep(D-A+Y/mu,lambda/mu);
    Y = Y + mu*(D-A-E);
    switch method
        case 1 % RPCA
            if((mu*norm(E-E_s,'fro')/nD) < esp_2)
                mu = mu*rho;
            end
        case 2 % MC
            if((min(mu,sqrt(mu))*norm(E-E_s,'fro')/nD) < esp_2)
                mu = mu*rho;
            end
    end
    k = k+1;
    
    cred = norm(D-A-E,'fro')/nD;
    
end

end