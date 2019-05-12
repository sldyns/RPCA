hvfr = VideoReader(filename);
nframes = get(hvfr, 'NumberOfFrames');
for k = 1 : nframes
    currentFrame = read(videoObj, k);%读取第i帧
    subplot(2,2,1);%创建图像显示窗口并获取第一个窗口句柄
    imshow(currentFrame);
end