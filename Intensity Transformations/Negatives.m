clear
clc

I = imread('ScreenShots/Negatives/origin.png');
[width, height] = size(I);

%% ֱ�Ӷ�ÿ�����ز������Լ�д�ģ�

% nagatived_I = zeros(width, height);
% for x=1:width
%     for y=1:height
%         nagatived_I(x,y) = 255 - I(x,y);
%     end
% end


%% ֱ�ӽ��о�������
negatived_I = 255 - I;
figure;
imshow(negatived_I, []);


%% imcomplement�⺯��
J = imcomplement(I);
figure;
imshow(J, []);




