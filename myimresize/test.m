clear
clc

img = imread('Resources/color1.jpg');
figure;
imshow(img, []);

small_img = myimresize(img, 0.5, 'bicubic');
figure;
imshow(small_img,[]);      % �ڶ������� -> �Զ��������ݵķ�Χ�Ա�����ʾ��������ӵڶ����������������ȷ�ģ�����ͼ����ȫ�׵�


mid_img = myimresize(img, 1, 'nearest');
figure;
imshow(mid_img, []);

big_img = myimresize(img, 2, 'bilinear');
figure;
imshow(big_img, []);
