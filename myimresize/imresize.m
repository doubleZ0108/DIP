clear
clc

img = imread('Resources/gray2.jpg');
figure;
imshow(img, []);

small_img = myimresize(img, 0.5, 'bilinear');
figure;
imshow(small_img,[]);      % �ڶ������� -> �Զ��������ݵķ�Χ�Ա�����ʾ��������ӵڶ����������������ȷ�ģ�����ͼ����ȫ�׵�

big_img = myimresize(img, 2, 'bilinear');
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
        ;
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















