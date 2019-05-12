clc
clear

img = imread('Lena.jpg');
img_gray = rgb2gray(img);
[m,n]=size(img_gray);

I = randperm(m,3/4*m);
J = randperm(n,3/4*m);

J=J+m;
cvx_setup
cvx_begin sdp
variables WX(m+n,m+n)
minimize(trace(WX(1:m,1:m))+trace(WX(m+1:m+n,m+1:m+n)))
for i=1:length(I),WX(I(i),J(i))==Img_gray(I(i),J(i)-m);end
WX>=0;
cvx_end
MR=full(WX(1:m,m+1:end));
