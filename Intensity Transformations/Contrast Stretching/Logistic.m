clear
clc

I = imread('ScreenShots/Contrast Stretching/origin1.png');
I = rgb2gray(I);

J = LogisticFunction(I);


%% ����ͼ��
% x = 0:0.1:255;
% y = Growth(x);
% figure;
% plot(x, y);

function y = LogisticFunction(x)
% Logistic(��������)ģ��

a = 255;
deltax = 0;
E = 10;

y = a ./ (1 + (a*0.5./(x+deltax)).^E);

end