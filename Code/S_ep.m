function SE = S_ep(X,ep)

[m,n]=size(X);
SE = zeros(m,n);
SE(X>ep)=X(X>ep)-ep;
SE(X<-ep)=X(X<-ep)+ep;

end