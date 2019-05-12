clear;
clc;

%% 数据预处理
img = imread('Lena.jpg'); % 读取原图像
img_gray = rgb2gray(img); % 转为黑白图形
img_gray = double(img_gray); % 转为double类型
[U,S,V] = svd(img_gray);
rank = 64; % 新图像的秩
img_gray = U(:,1:rank)*S(1:rank,1:rank)*V(:,1:rank)';

% [img_N, N] = Noise(img_gray, 1); % 加局部高斯噪声
[img_N, N] = Noise(img_gray, 2); % 对角线赋为0



%% 图像恢复

% [img_S, V_S] = PCA(img_N, 0.7, 2); % SVD 恢复图像
tic
[img_IT, ~] = IT(img_N, 0.01); % 迭代阈值法恢复图像
toc

tic
[img_APG, ~] = APG(img_N, 10); % 加速近端梯度法恢复图像
toc

tic
[img_EALM, ~] = EALM(img_N,1); % 精确增广拉格朗日乘子法恢复图像
toc

tic
[img_IALM, ~] = IALM(img_N,1); % 非精确增广拉格朗日乘子法恢复图像
toc

%% %% 评价效果

%% 主成分分析法效果
% E_S = img_gray - img_S; % 误差
% 
% MSE_S = sum(E_S(:).*E_S(:))/numel(img_S); % 均方根误差MSE
% PSNR_S = 10*log10(255^2/MSE_S); % 峰值信噪比
% MAE_S = mean(mean(abs(E_S))); % 平均绝对误差
% 
% disp('主成分分析法:MSE=');MSE_S
% disp('PSNR=');PSNR_S
% disp('MAE=');MAE_S

%% 迭代阈值法效果
E_IT = img_gray - img_IT; % 误差

disp('迭代阈值法:'); 
MSE_IT = sum(E_IT(:).*E_IT(:))/numel(img_IT) % 均方根误差MSE
PSNR_IT = 10*log10(255^2/MSE_IT) % 峰值信噪比
MAE_IT = mean(mean(abs(E_IT))) % 平均绝对误差

%% 加速近端梯度法效果
E_APG = img_gray - img_APG; % 误差

disp('加速近端梯度法:')
MSE_APG = sum(E_APG(:).*E_APG(:))/numel(img_APG) % 均方根误差MSE
PSNR_APG = 10*log10(255^2/MSE_APG) % 峰值信噪比
MAE_APG = mean(mean(abs(E_APG))) % 平均绝对误差

%% 精确增广拉格朗日乘子法效果
E_EALM = img_gray - img_EALM; % 误差

disp('精确增广拉格朗日乘子法:'); 
MSE_EALM = sum(E_EALM(:).*E_EALM(:))/numel(img_EALM) % 均方根误差MSE
PSNR_EALM = 10*log10(255^2/MSE_EALM) % 峰值信噪比
MAE_EALM = mean(mean(abs(E_EALM))) % 平均绝对误差


%% 非精确增广拉格朗日乘子法恢复图像
E_IALM = img_gray - img_IALM; % 误差

disp('非精确增广拉格朗日乘子法:');
MSE_IALM = sum(E_IALM(:).*E_IALM(:))/numel(img_IALM) % 均方根误差MSE
PSNR_IALM = 10*log10(255^2/MSE_IALM) % 峰值信噪比
MAE_IALM = mean(mean(abs(E_IALM))) % 平均绝对误差

%% 绘图
figure(1)
subplot(2,2,1); imshow(img,[]); title('原彩色图');
subplot(2,2,2); imshow(img_gray,[]); title('原灰度图');
subplot(2,2,3); imshow(img_N,[]); title('加噪图像');
subplot(2,2,4); imshow(N,[]); title('噪声图像');

figure(2)
% subplot(2,2,1); imshow(img_S,[]);  title('主成分分析恢复图');
% subplot(2,2,2); imshow(E_S,[]);  title('主成分分析噪声图');
% subplot(2,2,3); imshow(img_I,[]);  title('迭代阈值法恢复图');
% subplot(2,2,4); imshow(E_I,[]);  title('迭代阈值法噪声图');

subplot(2,2,1); imshow(img_IT,[]);  title('迭代阈值法恢复图');
subplot(2,2,2); imshow(E_IT,[]);  title('迭代阈值法恢复噪声图');
subplot(2,2,3); imshow(img_APG,[]);  title('加速近端梯度法恢复图');
subplot(2,2,4); imshow(E_APG,[]);  title('加速近端梯度法噪声图');

figure(3)
subplot(2,2,1); imshow(img_EALM,[]);  title('EALM恢复图');
subplot(2,2,2); imshow(E_EALM,[]);  title('EALM误差图');
subplot(2,2,3); imshow(img_IALM,[]);  title('IALM恢复图');
subplot(2,2,4); imshow(E_IALM,[]);  title('IALM误差图');
