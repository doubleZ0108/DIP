% I = imread('Resources/color.jpg');
I = imread('Resources/gray.jpg');
I = rgb2gray(I);

[height, width] = size(I);  % ע���������ȸߣ����

xx = 1:1:width;
yy = 1:1:height;
[x,y] = meshgrid(xx,yy);     % ���������ڳ�����ȵ������

z = I(:,:,1);

figure;
mesh(x,y,z);