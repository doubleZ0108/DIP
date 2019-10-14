clc;
clear;

I = imread('Resources/origin2.png');
I = rgb2gray(I);
[M,N] = size(I);

s = zeros(1, 256);
[counts, pixels] = imhist(I);   % [ÿ�����صĸ��� | ����ֵ(0��255)]

sum_count = 0;
for k=0:255
    
    sum_count = sum_count + counts(k + 1, 1);   % ����������ͳ�����ֵ
    
    s(1,k+1) = round(255/(M*N)*sum_count);
end


J = s(1,I+1);   % ��ԭͼ�еĻҶ�ת��Ϊ��ͼ���еĻҶȼ�
J = uint8(reshape(J, [M, N]));
