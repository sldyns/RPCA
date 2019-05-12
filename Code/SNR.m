clear;
clc;

%% ����Ԥ����
img = imread('Lena.jpg'); % ��ȡԭͼ��
img_gray = rgb2gray(img); % תΪ�ڰ�ͼ��
img_gray = double(img_gray); % תΪdouble����
[U,S,V] = svd(img_gray);
rank = 64; % ��ͼ�����
img_gray = U(:,1:rank)*S(1:rank,1:rank)*V(:,1:rank)';

% [img_N, N] = Noise(img_gray, 1); % �Ӿֲ���˹����
[img_N, N] = Noise(img_gray, 2); % �Խ��߸�Ϊ0



%% ͼ��ָ�

% [img_S, V_S] = PCA(img_N, 0.7, 2); % SVD �ָ�ͼ��
tic
[img_IT, ~] = IT(img_N, 0.01); % ������ֵ���ָ�ͼ��
toc

tic
[img_APG, ~] = APG(img_N, 10); % ���ٽ����ݶȷ��ָ�ͼ��
toc

tic
[img_EALM, ~] = EALM(img_N,1); % ��ȷ�����������ճ��ӷ��ָ�ͼ��
toc

tic
[img_IALM, ~] = IALM(img_N,1); % �Ǿ�ȷ�����������ճ��ӷ��ָ�ͼ��
toc

%% %% ����Ч��

%% ���ɷַ�����Ч��
% E_S = img_gray - img_S; % ���
% 
% MSE_S = sum(E_S(:).*E_S(:))/numel(img_S); % ���������MSE
% PSNR_S = 10*log10(255^2/MSE_S); % ��ֵ�����
% MAE_S = mean(mean(abs(E_S))); % ƽ���������
% 
% disp('���ɷַ�����:MSE=');MSE_S
% disp('PSNR=');PSNR_S
% disp('MAE=');MAE_S

%% ������ֵ��Ч��
E_IT = img_gray - img_IT; % ���

disp('������ֵ��:'); 
MSE_IT = sum(E_IT(:).*E_IT(:))/numel(img_IT) % ���������MSE
PSNR_IT = 10*log10(255^2/MSE_IT) % ��ֵ�����
MAE_IT = mean(mean(abs(E_IT))) % ƽ���������

%% ���ٽ����ݶȷ�Ч��
E_APG = img_gray - img_APG; % ���

disp('���ٽ����ݶȷ�:')
MSE_APG = sum(E_APG(:).*E_APG(:))/numel(img_APG) % ���������MSE
PSNR_APG = 10*log10(255^2/MSE_APG) % ��ֵ�����
MAE_APG = mean(mean(abs(E_APG))) % ƽ���������

%% ��ȷ�����������ճ��ӷ�Ч��
E_EALM = img_gray - img_EALM; % ���

disp('��ȷ�����������ճ��ӷ�:'); 
MSE_EALM = sum(E_EALM(:).*E_EALM(:))/numel(img_EALM) % ���������MSE
PSNR_EALM = 10*log10(255^2/MSE_EALM) % ��ֵ�����
MAE_EALM = mean(mean(abs(E_EALM))) % ƽ���������


%% �Ǿ�ȷ�����������ճ��ӷ��ָ�ͼ��
E_IALM = img_gray - img_IALM; % ���

disp('�Ǿ�ȷ�����������ճ��ӷ�:');
MSE_IALM = sum(E_IALM(:).*E_IALM(:))/numel(img_IALM) % ���������MSE
PSNR_IALM = 10*log10(255^2/MSE_IALM) % ��ֵ�����
MAE_IALM = mean(mean(abs(E_IALM))) % ƽ���������

%% ��ͼ
figure(1)
subplot(2,2,1); imshow(img,[]); title('ԭ��ɫͼ');
subplot(2,2,2); imshow(img_gray,[]); title('ԭ�Ҷ�ͼ');
subplot(2,2,3); imshow(img_N,[]); title('����ͼ��');
subplot(2,2,4); imshow(N,[]); title('����ͼ��');

figure(2)
% subplot(2,2,1); imshow(img_S,[]);  title('���ɷַ����ָ�ͼ');
% subplot(2,2,2); imshow(E_S,[]);  title('���ɷַ�������ͼ');
% subplot(2,2,3); imshow(img_I,[]);  title('������ֵ���ָ�ͼ');
% subplot(2,2,4); imshow(E_I,[]);  title('������ֵ������ͼ');

subplot(2,2,1); imshow(img_IT,[]);  title('������ֵ���ָ�ͼ');
subplot(2,2,2); imshow(E_IT,[]);  title('������ֵ���ָ�����ͼ');
subplot(2,2,3); imshow(img_APG,[]);  title('���ٽ����ݶȷ��ָ�ͼ');
subplot(2,2,4); imshow(E_APG,[]);  title('���ٽ����ݶȷ�����ͼ');

figure(3)
subplot(2,2,1); imshow(img_EALM,[]);  title('EALM�ָ�ͼ');
subplot(2,2,2); imshow(E_EALM,[]);  title('EALM���ͼ');
subplot(2,2,3); imshow(img_IALM,[]);  title('IALM�ָ�ͼ');
subplot(2,2,4); imshow(E_IALM,[]);  title('IALM���ͼ');
