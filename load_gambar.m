clc; close all;
image_folder = 'training_img'; % nama folder dataset gambar
total_images = 15; % total gambar per kelas
kelas = {'Burger', 'Croissants', 'Muffin', 'Pizza', 'RotiSobek', 'RotiTawar'}; % kelas klasifikasi jenis roti
total_kelas = 1; % total kelas

for i = 1:total_kelas % perulangan untuk i = 1 hingga 6 (total kelas)
    for j = 1:total_images % perulangan untuk j = 1 hingga 15 (total gambar)
        figure(i) % membuat figure untuk menampilkan gambar setiap kelas
        full_name = fullfile(strcat(image_folder, '\', kelas{i}), strcat(num2str(j),'.jpg')) ; % mengambil file j.jpg dari folder kelas index ke-i
        Img = imread(full_name); % baca gambar j.jpg yang telah diambil
        RGB = segmentasi(Img, i);
        gray = rgb2gray(RGB);
        GLCM = graycomatrix(gray, 'Offset', [0 1; -1 1; -1 0; -1 -1]); % membuat matriks co-occurence tingkat abu-abu dari gambar n.gif
        stats = graycoprops(GLCM, {'contrast', 'correlation', 'energy', 'homogeneity'}); % menghitung statistik GLCM untuk mendapatkan nilai kontras, korelasi, energi, dan homogenitas
        ind = j + ((i - 1) * total_images);
        CON = mean(stats.Contrast); % menghitung rata-rata dari matriks kontras, kemudian disimpan ke dalam matriks CON indeks ke-n
        CORR = mean(stats.Correlation); % menghitung rata-rata dari matriks korelasi, kemudian disimpan ke dalam matriks CORR indeks ke-n
        C = kelas{i};
        X{ind} = {CON CORR C};
        subplot(3,5,j), imshow(RGB); % menampilkan gambar j.jpg pada subplot ke-j
    end
end

writetable(cell2table(X'), 'fitur.csv', 'WriteVariableNames', 0);

function RGB = segmentasi(I, kelas)
    HSV = rgb2hsv(I);
    S = HSV(:, :, 2);
    if (kelas == 1 || kelas == 2 )
        bw = im2bw(S, 0.3);
    elseif (kelas == 3 || kelas == 6)
        bw = im2bw(S, 0.2);
    elseif (kelas == 4)
        bw = im2bw(S, 0.4);
    else
        bw = im2bw(S, 0.5);
    end
    bw = bwareaopen(bw, 1000);
    mask = strel('disk', 10);
    bw = imdilate(bw, mask);
    bw = imfill(bw, 'holes');
    R = I(:, :, 1); % mengekstrak nilai komponen merah dari gambar
    G = I(:, :, 2); % mengekstrak nilai komponen hijau dari gambar
    B = I(:, :, 3); % mengekstrak nilai komponen biru dari gambar
    R(~bw) = 0; % mengubah nilai komponen warna merah dari citra diluar seleksi citra biner menjadi hitam (0)
    G(~bw) = 0; % mengubah nilai komponen warna hijau dari citra diluar seleksi citra biner menjadi hitam (0)
    B(~bw) = 0; % mengubah nilai komponen warna biru dari citra diluar seleksi citra biner menjadi hitam (0)
    RGB = cat(3, R, G, B); % menyimpan komponen warna merah, hijau, dan biru ke dalam variabel RGB
end