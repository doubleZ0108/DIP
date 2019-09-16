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
