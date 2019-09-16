% ======================== bilinear ================================ %
function result_img = Bilinear(origin_img, result_img, origin_size, target_size, scale, type)
% ˫���Բ�ֵ�� (Bilinear Interpolation Algorithm)

% ��չԭʼͼƬ�����Ե
extended_img = ExtendImg(origin_img, origin_size, type);

% ����ͼ��ĳ������(x,y) -ӳ��-> ԭʼͼ��(ii,jj)��������ֵ
for x=1:target_size(1)
    for y=1:target_size(2)
        
       ii = (x-1)/scale; jj = (y-1)/scale;
       i = floor(ii); j = floor(jj);
       
       u = ii-i; v = jj - j;
       i = i+1; j = j+1;
       
%        result_img(x,y,:) = (1-u)*(1-v)*extended_img(i,j,:) + (1-u)*v*extended_img(i,j+1,:) + u*(1-v)*extended_img(i+1,j,:) + u*v*extended_img(i+1,j+1,:);
       
       U = [1-u, u];
       V = [1-v; v];
       
       for z=1:type
           F = [extended_img(i,j,z),extended_img(i,j+1,z);
               extended_img(i+1,j,z),extended_img(i+1,j+1,z)];
            
           try
               result_img(x,y,z) = (U*F*V);
           end
           
       end
      
    end
end

end

function tmp_img = ExtendImg(origin_img, origin_size, type)
% ��ԭʼ�����������Ҹ���һ��ױߣ�������Ӧ��ԭʼֵ���

m = origin_size(1); n = origin_size(2);
tmp_img = zeros(m+2,n+2,type);              % �������Ҹ���һ���ױ�
tmp_img(2:m+1,2:n+1,:) = origin_img;        % ��ԭʼͼƬ�ŵ����м䣬��������Ϊ��
tmp_img(1,2:n+1,:) = origin_img(1,:,:);     % ԭ����ĵ�һ������ϱߵĿ�
tmp_img(m+2,2:n+1,:) = origin_img(m,:,:);   % ԭ��������һ������±ߵĿ�
tmp_img(2:m+1,1,:) = origin_img(:,1,:);     % ԭ����ĵ�һ�������ߵĿ�
tmp_img(2:m+1,n+2,:) = origin_img(:,n,:);   % ԭ��������һ������ұߵĿ�
tmp_img(1,1,:) = origin_img(1,1,:);         % ���Ͻ�
tmp_img(1,n+2,:) = origin_img(1,n,:);       % ���Ͻ�
tmp_img(m+2,1,:) = origin_img(m,1,:);       % ���½�
tmp_img(m+2,n+2,:) = origin_img(m,n,:);     % ���½�

end
% ======================== bilinear ================================ %