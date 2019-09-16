% �����㷨��ʱ��Ч�ʱȽ�

scales = 0.9:0.01:1.1;
t_library = zeros(size(scales));
t_nearest = zeros(size(scales));
t_bilinear = zeros(size(scales));
t_bicubic = zeros(size(scales));

for scale = 0.9:0.01:1.1
    k = floor((scale+0.1-1.00)/0.01)+1;
    
    tic;
    fresh_img = imresize(img,scale);        % �⺯��
    toc;
    t_library(1,k) = toc;
    
    tic;
    fresh_img = myimresize(img,scale,'nearest');    % nearest�㷨
    toc;
    t_nearest(1,k) = toc;
    
    tic;
    fresh_img = myimresize(img,scale,'bilinear');   % bilinear�㷨
    toc;
    t_bilinear(1,k) = toc;
    
    tic;
    fresh_img = myimresize(img,scale,'bicubic');    % bicubic�㷨
    toc;
    t_bicubic(1,k) = toc;
    
end

figure;
plot(scales, t_library);
hold on;

plot(scales, t_nearest);
plot(scales, t_bilinear);
plot(scales, t_bicubic);

xlabel('scale');
ylabel('time');
legend('library','nearest','bilinear','bicubic');