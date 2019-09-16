% ======================== bicubic ================================ %
function result_img = Bicubic(origin_img, result_img, origin_size, target_size, scale, type)
% ˫���β�ֵ����Bicubic Interpolation Algorithm��

m = origin_size(1); n = origin_size(2);

% ��չԭʼͼƬ�����Ե
FI = SpendImg(origin_img, origin_size, type);

% ʹ��BiCubic�������в�ֵ
for x=1:target_size(1)
    for y=1:target_size(2)
        i = floor(x/scale)+2;  u = rem(x,scale)/scale; 
        j = floor(y/scale)+2; v = rem(y,scale)/scale;
        
        A = [Ws(u+1),Ws(u),Ws(u-1),Ws(u-2)];
        C = [Ws(v+1);Ws(v);Ws(v-1);Ws(v-2)];
        
        for z = 1:type    
            try
                B = double(FI(i-1:i+2,j-1:j+2,z));
                result_img(x,y,z) = (A*B*C);    
            end
        end
        
    end
end

end

function w = Ws(wx)
% BiCubic��ֵ����

wx = abs(wx);
if wx<1
    w = 1 - 2*wx^2 + wx^3;
elseif wx>=1 && wx<2
    w = 4 - 8*wx + 5*wx^2 - wx^3;
else
    w = 0;

end

end

function tmp_img = SpendImg(origin_img, origin_size, type)
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

% ======================== bicubic ================================ %