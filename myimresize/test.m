clear
clc

img = imread('Resources/color2.jpg');
figure;
imshow(img, []);

small_img = myimresize(img, 0.5, 'bicubic');
figure;
imshow(small_img,[]);      % �ڶ������� -> �Զ��������ݵķ�Χ�Ա�����ʾ��������ӵڶ����������������ȷ�ģ�����ͼ����ȫ�׵�

big_img = myimresize(img, 2, 'bicubic');
figure;
imshow(big_img, []);