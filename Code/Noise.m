function [img_N, N] = Noise(img, method)
[m,n] = size(img);
switch method
    case 1
        N = zeros(m,n);
        N((256:256+63),(256:256+63))= 10*randn(64,64);
        img_N = double(img) + N;
    case 2
        N = eye(m,n) + flip(eye(m,n));
        N(N==2) = 1;
        img_N = double(img) - N.*double(img);
        img_N(img_N<0) = 0;
end