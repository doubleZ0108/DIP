rgb_img = imread('../Resources/tongji.png');
grey_img = rgb2gray(rgb_img);

salt_pepper_noise_img = imnoise(grey_img, 'salt & pepper', 0.5);        % �����ܶ�Ϊ0.5

% Median Filter
median_restoration_img = medfilt2(salt_pepper_noise_img);
% imshowpair(salt_pepper_noise_img, median_restoration_img, 'montage');

% Adaptive Median Filter
adaptivemedian_restoration_img = AdaptiveMedianFiltering(salt_pepper_noise_img, 10);
% imshowpair(salt_pepper_noise_img, adaptivemedian_restoration_img, 'montage');

subplot(1,3,1);
imshow(salt_pepper_noise_img);
subplot(1,3,2);
imshow(median_restoration_img);
subplot(1,3,3);
imshow(adaptivemedian_restoration_img);

function MedianFiltering(noise_img)
end

function restoration_img = AdaptiveMedianFiltering(noise_img, MaxSize)
S_max = MaxSize;
[M,N] = size(noise_img);

% ��չͼ��
img = zeros(M+S_max*2, N+S_max*2,'uint8');
restoration_img = img;
img(S_max+1:M+S_max, S_max+1:N+S_max) = noise_img;

% �����չλ����0��䣬��ͼ���Ե�������޷�ȥ��
img(1:S_max,S_max+1:S_max+N) = noise_img(1:S_max,1:N);      % �ϱ߽�
img(S_max+M+1:M+S_max*2,S_max+1:S_max+N) = noise_img(M-S_max+1:M,1:N);    % �±߽�
img(S_max+1:S_max+M,1:S_max) = noise_img(1:M,1:S_max);  % ��߽�
img(S_max+1:S_max+M,S_max+N+1:N+S_max*2) = noise_img(1:M,N-S_max+1:N);  % �ұ߽�

for ii = S_max+1:S_max+M
    for jj = S_max+1:S_max+N
        
        window_size = 1;
        while window_size<=S_max
            neighbor = img(ii-window_size:ii+window_size, jj-window_size:jj+window_size);    % ��ȡ����
            neighbor = neighbor(:);  % ת��Ϊ������
            
            z_med = median(neighbor);
            z_min = min(neighbor);
            z_max = max(neighbor);
            
            if z_min<z_med && z_med<z_max   % ��ǰ������ֵ��������
                break;
            else
                window_size = window_size + 1;
            end
        end
        
        if z_min<img(ii,jj) && img(ii,jj)<z_max
            restoration_img(ii,jj) = img(ii,jj);    % �����ǰ���ز���������ԭֵ���
        else
            restoration_img(ii,jj) = z_med;         % �����ǰ��������������ֵ�˲�
        end
        
    end
end

restoration_img = restoration_img(S_max+1:M+S_max, S_max+1:N+S_max);
end