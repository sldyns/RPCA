hvfr = VideoReader(filename);
nframes = get(hvfr, 'NumberOfFrames');
for k = 1 : nframes
    currentFrame = read(videoObj, k);%��ȡ��i֡
    subplot(2,2,1);%����ͼ����ʾ���ڲ���ȡ��һ�����ھ��
    imshow(currentFrame);
end