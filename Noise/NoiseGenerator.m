% �������͵�����������

origin_img = imread('Resources/origin.png');

%% ��˹����
avg = 0;        % ��ֵ
sigma = 25;     % ��׼��
gaussian_noise_img = imnoise(origin_img, 'gaussian', avg, (sigma/255)^2);
% imshow(gaussian_noise_img);

%% ���ɷֲ�����
poisson_noise_img = imnoise(origin_img, 'poisson');
% imshow(poisson_noise_img);

%% ��������
noisy_density = 0.1;    % �����ܶȣ���Լ��d*numel(img)�������յ���Ⱦ
salt_pepper_noise_img = imnoise(origin_img, 'salt & pepper', noisy_density);
% imshow(salt_pepper_noise_img);

%% �ߵ�����
% g = f + n*f
% n�Ǿ�ֵΪ0������Ϊsigma�ľ��ȷֲ��������
sigma = 0.1;
speckle_noise_img = imnoise(origin_img, 'speckle', sigma);
% imshow(speckle_noise_img)
