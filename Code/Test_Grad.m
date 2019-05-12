clear;
clc;

img = imread('Lena.jpg');
img = rgb2gray(img);

[U,V] = grad(img,20,0.01,0.01,0.01,1e-6);

img_k = U*V';
imshow(img_k,[]);