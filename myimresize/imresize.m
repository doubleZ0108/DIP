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


function result_img = myimresize(origin_img, scale, algorithm)

% ��׳�Լ��
if ~exist('origin_img','var') || isempty(origin_img)
    error('You should input the origin image.');
end
if ~exist('scale','var') || isempty(scale)
    error('You should input the scale you want to change the image.');
end
if scale<=0
    error('SCALE should greater than 0!');
end


% Ĭ���㷨Ϊ nearest�㷨
if nargin<3, algorithm='nearest'; end


% ��ȡԭͼƬ��С��Ŀ��ͼƬ��С
[origin_width, origin_height, type] = size(origin_img);
origin_size = [origin_width, origin_height];
target_size = round(origin_size * scale);

result_img = im2uint8(zeros(target_size(1), target_size(2), type));

switch(algorithm)
    case 'nearest'
        result_img = Nearest(origin_img, result_img, origin_size, target_size,scale, type);
    case 'bilinear'
        result_img = Bilinear(origin_img, result_img, origin_size, target_size,scale, type);
    case 'bicubic'
        result_img = Bicubic(origin_img, result_img, origin_size, target_size,scale, type);
end


end


% ======================== nearest ================================ %
function result_img = Nearest(origin_img, result_img, origin_size, target_size, scale, type)
% ��������ڲ巨(Nearest Neighbor interpolation)

for x=1:target_size(1)
    for y=1:target_size(2)
        
        % ��result�е�ÿ������λ�ö�Ӧ��origin��
        a = (x+0.5) / scale + 0.5;
        b = (y+0.5) / scale + 0.5;
        
        % �ҵ�������ĸ�����λ��
        [a1,a2,b1,b2] = growNearest(a, b, origin_size(1), origin_size(2));
        
        % Ѱ���ĸ�λ���о����ֵ�������λ��
        D = [distance(a,b,a1,b1),distance(a,b,a1,b2),distance(a,b,a2,b1),distance(a,b,a2,b2)];
        [min_x, min_y] = findMinPos(a1,a2,b1,b2,D);
        
        for z=1:type
             % �����������ظ����ֵ��
            result_img(x,y,z) = origin_img(min_x,min_y,z);
        end
    end
end


end

function [a1,a2,b1,b2] = growNearest(a, b, width, height)
% ���ص�(x,y)����(a,b)��ŷ������ƽ��
% ֻ��Ҫ�ȽϾ����С����ѡ������ʡȥ��������

a1 = round(a);
if a1>width-1, a1 = width-1; end
a2 = a1 + 1;

b1 = round(b);
if b1>height-1, b1 = height-1; end
b2 = b1 + 1;

end

function length = distance(x, y, a, b)
% �ҳ����ֵ�����λ��
% D����洢��Χ�㵽��ֵ���λ��

length = (x-a)^2 + (y-b)^2;

end

function [min_x, min_y] = findMinPos(a1,a2,b1,b2,D)
% �ҳ����ֵ�����λ��
% D����洢��Χ�㵽��ֵ���λ��

minindex = find(D==max(D));

switch(minindex(1))     % �����ж�����ֵ������ѡ���һ��
    case 1
        min_x = a1;
        min_y = b1;
    case 2
        min_x = a1;
        min_y = b2;
    case 3
        min_x = a2;
        min_y = b1;
    case 4
        min_x = a2;
        min_y = b2;
end

end
% ======================== nearest ================================ %





% ======================== bilinear ================================ %
function result_img = Bilinear(origin_img, result_img, origin_size, target_size, scale, type)

% ��չԭʼͼƬ�����Ե
tmp_img = zeros(origin_size(1)+2,origin_size(2)+2,type);
tmp_img(2:origin_size(1)+1,2:origin_size(2)+1,:) = origin_img;
tmp_img(1,2:origin_size(2)+1,:) = origin_img(1,:,:); tmp_img(origin_size(1)+2,2:origin_size(2)+1,:) = origin_img(origin_size(1),:,:);
tmp_img(2:origin_size(1)+1,1,:) = origin_img(:,1,:); tmp_img(2:origin_size(1)+1,origin_size(2)+2,:) = origin_img(:,origin_size(2),:);
tmp_img(1,1,:) = origin_img(1,1,:); tmp_img(1,origin_size(2)+2,:) = origin_img(1,origin_size(2),:);
tmp_img(origin_size(1)+2,1,:) = origin_img(origin_size(1),1,:); tmp_img(origin_size(1)+2,origin_size(2)+2,:) = origin_img(origin_size(1),origin_size(2),:);


% ����ͼ��ĳ������(x,y) -ӳ��-> ԭʼͼ��(ii,jj)��������ֵ
for x=1:target_size(1)
    for y=1:target_size(2)
       ii = (x-1)/scale; jj = (y-1)/scale;
       i = floor(ii); j = floor(jj);
       u = ii-i; v = jj - j;
       i = i+1; j = j+1;
       result_img(x,y,:) = (1-u)*(1-v)*tmp_img(i,j,:) + (1-u)*v*tmp_img(i,j+1,:) + u*(1-v)*tmp_img(i+1,j,:) + u*v*tmp_img(i+1,j+1,:);
    end
end

end
% ======================== bilinear ================================ %




% ======================== bicubic ================================ %
% function result_img = Bicubic(origin_img, result_img, origin_size, target_size, scale, type)
% 
% m = round(origin_size(1)/2); n = round(origin_size(1)/2);
% f = zeros(m,n);
% 
% %��ͼ����и��г�ȡԪ�أ��õ���С��ͼ��f
% for i=1:m
%     for j=1:n
%         f(i,j)=origin_img(2*i,2*j);
%     end
% end
% 
% k=scale*2;%���÷Ŵ���
% a=f(1,:);%ȡf�ĵ�1��
% c=f(m,:);%ȡf�ĵ�m��
% 
% %������ֵͼ�����ǰ�����չ��������,����չ�������е�f1
% b=[f(1,1),f(1,1),f(:,1)',f(m,1),f(m,1)];
% d=[f(1,n),f(1,n),f(:,n)',f(m,n),f(m,n)];
% a1=[a;a;f;c;c];
% b1=[b;b;a1';d;d];
% ffff=b1';f1=double(ffff);
% 
% for i=1:k*m%����˫���β�ֵ��ʽ����ͼ���������ظ�ֵ
%     u=rem(i,k)/k;
%     i1=floor(i/k)+2;
%     A=[sw(1+u) sw(u) sw(1-u) sw(2-u)];
%     for j=1:k*n
%         v=rem(j,k)/k;j1=floor(j/k)+2;
%         C=[sw(1+v);sw(v);sw(1-v);sw(2-v)];
%         
%         B=[f1(i1-1,j1-1) f1(i1-1,j1) f1(i1-1,j1+1) f1(i1-1,j1+2); 
%            f1(i1,j1-1) f1(i1,j1) f1(i1,j1+1) f1(i1,j1+2);
%            f1(i1+1,j1-1) f1(i1+1,j1) f1(i1+1,j1+1) f1(i1+1,j1+2);
%            f1(i1+2,j1-1) f1(i1+2,j1) f1(i1+2,j1+1) f1(i1+2,j1+2)];
%        
%         A*B*C
%         result_img(i,j)=(A*B*C);
%     end
% end
% 
% 
% end

function result_img = Bicubic(origin_img, result_img, origin_size, target_size, scale, type)

[oh,ow,od] = size(origin_img);
zmf = scale; %��������

% initial target image TI
th = round(oh*zmf);
tw = round(ow*zmf);

% add original image with 2 rows and 2 cols
% expand the border to prevent calculation overflow
a = origin_img(1,:,:); b = origin_img(oh,:,:);
temp_I = [a;a;origin_img;b;b];
c = temp_I(:,1,:); d = temp_I(:,ow,:);
FI = [c,c,temp_I,d,d];

% fill target image with new pixels
for w = 1:tw
    j = floor(w/zmf)+2; v = rem(w,zmf)/zmf;
    for h = 1:th
        i = floor(h/zmf)+2;  u = rem(h,zmf)/zmf; 
        A = [s(u+1),s(u),s(u-1),s(u-2)];
        C = [s(v+1);s(v);s(v-1);s(v-2)];
        for d = 1:od   % image's 3 channels    
            try
                B = double(FI(i-1:i+2,j-1:j+2,d));
                result_img(h,w,d) = (A*B*C);    
            end
        end
    end
end


end


% ��ֵ�˺���
function w = s(wx)
    wx = abs(wx);
    if wx<1
        w = 1 - 2*wx^2 + wx^3;
    elseif wx>=1 && wx<2
        w = 4 - 8*wx + 5*wx^2 - wx^3;
    else
        w = 0;

    end
end

function A=sw(w1) 

w=abs(w1); 
if w<1 && w>=0 A =1-2*w^2+w^3; 
elseif w>=1 && w<2 A=4-8*w+5*w^2-w^3; 
else A=0; 
end

end

% ======================== bicubic ================================ %














