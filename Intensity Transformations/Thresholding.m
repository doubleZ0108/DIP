clear
clc

I = imread('ScreenShots/Thresholding/origin.jpg');

% ��������ֵ��ע�ⷶΧ��0��1
threshold = 0.5;

%% im2bw �⺯��
J = im2bw(I, threshold);

%% �Զ���������ֵ
range = getrangefromclass(I)   % ���ؾ���ķ�Χ�����ﷵ��[0, 255]
K = (I>range(2)*threshold);
