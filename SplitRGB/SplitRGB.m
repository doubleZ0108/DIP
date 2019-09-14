dirname = 'Resources/';
filename = 'her';
suffix = '.jpg';

% ��ȡͼƬ�ļ�
img = imread([dirname,filename,suffix]);

% ȡRGBͼƬ������ͨ��
imgR = img(:,:,1);
imgG = img(:,:,2);
imgB = img(:,:,3);

% ��������ͨ����ͼƬ
figure;
subplot(3,1,1);
imshow(imgR,[]);
subplot(3,1,2);
imshow(imgG,[]);
subplot(3,1,3);
imshow(imgB,[]);

% ��ͼƬд����jpg�ļ�
imwrite(imgR,[dirname,filename,'_R',suffix]);
imwrite(imgG,[dirname,filename,'_G',suffix]);
imwrite(imgB,[dirname,filename,'_B',suffix]);