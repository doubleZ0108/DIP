clear
clc

I = imread('ScreenShots/Intensity Level Slicing/origin.png');

xa = 175; xb = 230;
reduce = 20; hightlight = 230;

J = ReduceOther(I, [xa,xb], [reduce, hightlight]);
K = PreserveOther(I, [xa, xb], hightlight);


%% ����ͼ��
% x = 0:0.1:255;
% y1 = ReduceOther(x, [xa,xb],[reduce, hightlight]);
% y2 = PreserveOther(x, [xa, xb], hightlight);
% figure;
% plot(x, y1);
% axis([0 255 0 255]);
% figure;
% plot(x, y2);
% axis([0 255 0 255]);


function y = ReduceOther(x, interval, effect)
% ������Ȥ�ķ�Χ�����������Ҷ�ֵ�䰵����ֵͼ��
% interval��͹�����������[xa, xb]
% effect��������ֵ[reduce, hightlight]

xa = interval(1); xb = interval(2);
reduce = effect(1); hightlight = effect(2);

L1 = x>=0 & x<xa;
L2 = x>=xa & x<xb;
L3 = x>=xb & x<=255;

y(L1) = reduce;
y(L2) = hightlight;
y(L3) = reduce;

[width, height,type] = size(x);
y = reshape(y, [width, height]);

end

function y = PreserveOther(x, interval, hightlight)
% ������Ȥ�ķ�Χ��������䰵��������ͼ�������Ҷȼ�����
% interval��͹�����������[xa, xb]
% hightlight��������ֵ

xa = interval(1); xb = interval(2);

L1 = x>=0 & x<xa;
L2 = x>=xa & x<xb;
L3 = x>=xb & x<=255;

y(L1) = x(L1);
y(L2) = hightlight;
y(L3) = x(L3);

[width, height,type] = size(x);
y = reshape(y, [width, height]);

end