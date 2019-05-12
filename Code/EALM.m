function [A,E] = EALM(D,method)
% 精确增广拉格朗日乘子法

D = double(D);
[m,n] = size(D);
lambda = 1/sqrt(max(m,n));
rho = 6;
esp_1 = 1e-4;
esp_2 = 1e-6;
esp_3 = 1e-5;

mu = 0.5/norm(sign(D),2);
A_s = zeros(m,n);
E_s = zeros(m,n);
Y = sign(D)/max(norm(sign(D),2),norm(sign(D),inf)/lambda);
k = 0;
nD = norm(D,'fro');

cred_1 = 1;
while(cred_1>esp_1)
    E_0 = E_s;
    A_0 = A_s;
    j = 0;
    
    cred_2 = 1;
    cred_3 = 1;
    while(cred_2>esp_2 && cred_3>esp_2)        
        [U,S,V] = svd(D-E_s+Y/mu);
        A = U*S_ep(S,1/mu)*V';
        E = S_ep(D-A+Y/mu,lambda/mu);
        
        cred_2 = norm(A-A_s,'fro')/nD;
        cred_3 = norm(E-E_s,'fro')/nD;
        
        A_s = A;
        E_s = E;
        
        j=j+1;
    end

    Y = Y + mu*(D-A_s-E_s);
    
    switch method
        case 1 % RPCA
            if((mu*norm(E_0-E_s,'fro')/nD) < esp_3)
                mu = mu*rho;
            end
        case 2 % MC
            if((min(mu,sqrt(mu))*norm(E_0-E_s,'fro')/nD) < esp_3)
                mu = mu*rho;
            end
    end
    
    cred_1 = norm(D-A_s-E_s,'fro')/nD;
    
    k = k+1;
end

end