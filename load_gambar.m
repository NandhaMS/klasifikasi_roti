clc; close all;
image_folder = 'training_img'; % nama folder dataset gambar
total_images=15; % total gambar per kelas
kelas = {'Burger', 'Croissants', 'Muffin', 'Pizza', 'RotiSobek', 'RotiTawar'}; % kelas klasifikasi jenis roti
total_kelas = 6; % total kelas

for i = 1:total_kelas % perulangan untuk i = 1 hingga 6 (total kelas)
    for j = 1:total_images % perulangan untuk j = 1 hingga 15 (total gambar)
        figure(i) % membuat figure untuk menampilkan gambar setiap kelas
        full_name = fullfile(strcat(image_folder, '\', kelas{i}), strcat(num2str(j),'.jpg')) ; % mengambil file j.jpg dari folder kelas index ke-i
        Img = imread(full_name); % baca gambar j.jpg yang telah diambil
        subplot(3,5,j), imshow(Img); % menampilkan gambar j.jpg pada subplot ke-j
    end
end