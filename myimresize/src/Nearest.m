% ======================== nearest ================================ %
function result_img = Nearest(origin_img, result_img, origin_size, target_size, scale, type)
% ��������ڲ巨(Nearest Neighbor Interpolation Algorithm)

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
             try
                 % �����������ظ����ֵ��
                 result_img(x,y,z) = origin_img(min_x,min_y,z);
             end
        end
        
    end
end


end

function [a1,a2,b1,b2] = growNearest(a, b, width, height)
% �ҵ�������4��λ�ã��߽��飩

a1 = round(a);
if a1>width-1, a1 = width-1; end
a2 = a1 + 1;

b1 = round(b);
if b1>height-1, b1 = height-1; end
b2 = b1 + 1;

end

function length = distance(x, y, a, b)
% ���ص�(x,y)����(a,b)��ŷ������ƽ��
% ֻ��Ҫ�ȽϾ����С����ѡ������ʡȥ��������

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