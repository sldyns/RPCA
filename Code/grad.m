function [U,V] = grad(X,k,a,b,esp,lr)

[m,n]=size(X);

X = double(X);
U = double(randi(16,m,k));
V = double(randi(16,n,k));

g_U = 2*(U*V'*V-X*V+a*U);
g_V = 2*(V*U'*U-X'*U+b*V);

while((max(abs(g_U(:)))>esp)||(max(abs(g_V(:)))>esp))
    U = U - lr*g_U;
    V = V - lr*g_V;
    g_U = 2*(U*V'*V-X*V+a*U);
    g_V = 2*(V*U'*U-X'*U+b*V);
end

end