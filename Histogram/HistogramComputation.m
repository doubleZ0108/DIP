clc;
clear;

I = imread('Resources/gray1.jpg');
[M,N] = size(I);

%% �⺯��
imhist(I);

%% ѭ��������ͳ��
% h = zeros(1, 255);
% for xa=1:M
%     for xb=1:N
%         pixel = I(xa, xb);
%         h(pixel) = h(pixel) + 1;
%     end
% end
% plot(h);
