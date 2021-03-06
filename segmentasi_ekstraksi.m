function s = segmentasi_ekstraksi(display_segmentation, fig)
    image_folder = 'training_img'; % nama folder dataset gambar
    total_images = 15; % total gambar per kelas
    kelas = {'Burger', 'Croissants', 'Muffin', 'Pizza', 'RotiSobek', 'RotiTawar', 'Donut'}; % kelas klasifikasi jenis roti
    total_kelas = 7; % total kelas
    featurename = {
        'meanHue' 'meanSat' 'meanValue' 'meanStdDev' ...
        'Contrast' 'Correlation' 'Energy' 'Homogeneity' ...
        'Perimeter' 'Area' 'Eccentricity' 'Metric' 'Kelas', 'Gambar'
    };
    d = loading("Sedang melakukan segmentasi dan ekstraksi", fig);
    for i = 1:total_kelas % perulangan untuk i = 1 hingga 6 (total kelas)
        for j = 1:total_images % perulangan untuk j = 1 hingga 15 (total gambar)
            full_name = fullfile(strcat(image_folder, '/', kelas{i}), strcat(num2str(j),'.jpg')); % mengambil file j.jpg dari folder kelas index ke-i
            Img = imread(full_name); % baca gambar j.jpg yang telah diambil
            [bw, RGB] = segmentasi(Img); % segmentasi Img dengan fungsi segmentasi untuk mendapatkan citra biner dan rgb
            [meanHue, meanSat, meanValue, meanStdDev] = ekstraksi_hsv(RGB); % ekstraksi fitur ruang warna hsv
            [CON, CORR, E, H] = ekstraksi_tekstur(bw); % ekstraksi fitur tekstur 
            [P, A, Ec, M] = ekstraksi_bentuk(bw); % ekstraksi fitur bentuk dan ukuran
            C = kelas{i}; % nama kelas
            ind = j + ((i - 1) * total_images); % menghitung index untuk dimasukkan ke cell X
            X{ind} = {meanHue meanSat meanValue meanStdDev CON CORR E H P A Ec M C full_name}; % melakukan input fitur ruang warna hsv, tekstur, bentuk, ukuran, dan nama kelas dari citra makanan
            if (display_segmentation) % jika hasil segmentasi ditampilkan (bernilai 1)
                figure(i) % membuat figure untuk menampilkan gambar setiap kelas
                subplot(3,5,j), imshow(RGB); % menampilkan gambar j.jpg pada subplot ke-j
            end
        end
    end
    featuretable = cell2table(X'); % konversi cell X transpose menjadi tabel
    writetable(featuretable, 'fitur.csv', 'WriteVariableNames', false); % tulis isi tabel fitur dan kelas ke dalam 'fitur.csv'
    featuretable = cell2table(readcell('fitur.csv')); % baca cell dari 'fitur.csv' kemudian konversi ke tabel
    featuretable.Properties.VariableNames = featurename; % atur header untuk variabel setiap fitur pada setiap kolom tabel
    writetable(featuretable, 'fitur.csv'); % tulis isi tabel fitur dan kelas ke dalam 'fitur.csv'
    fclose('all'); % tutup semua file yang dibuka oleh matlab
    close(d);
    s = 1; % return 1 sebagai penanda fungsi telah dijalankan
    
    function [biner, RGB] = segmentasi(I) % fungsi untuk segmentasi citra makanan
        hsv = rgb2hsv(I); % konversi gambar menjadi ruang warna hsv
        S = hsv(:, :, 2); % mengambil fitur saturasi dari gambar hsv
        level = graythresh(S); % menghitung thresholding untuk segmentasi
        bw = imbinarize(S, level); % konversi ruang warna saturasi menjadi biner dengan thresholding level
        bw = bwareaopen(bw, 1000); % menghilangkan objek kecil yang kurang dari 1000 pixel
        mask = strel('disk', 10); % membuat masking disk berukuran 10
        bw = imdilate(bw, mask); % dilasi gambar biner dengan masking mask
        bw = imfill(bw, 'holes'); % isi lubang pada gambar biner
        R = I(:, :, 1); % mengekstrak nilai komponen merah dari gambar
        G = I(:, :, 2); % mengekstrak nilai komponen hijau dari gambar
        B = I(:, :, 3); % mengekstrak nilai komponen biru dari gambar
        R(~bw) = 0; % mengubah nilai komponen warna merah dari citra diluar seleksi citra biner menjadi hitam (0)
        G(~bw) = 0; % mengubah nilai komponen warna hijau dari citra diluar seleksi citra biner menjadi hitam (0)
        B(~bw) = 0; % mengubah nilai komponen warna biru dari citra diluar seleksi citra biner menjadi hitam (0)
        biner = bw; % menyimpan komponen bw untuk mendapatkan citra biner
        RGB = cat(3, R, G, B); % menyimpan komponen warna merah, hijau, dan biru ke dalam variabel RGB
    end

    function [meanHue, meanSat, meanValue, meanStdDev] = ekstraksi_hsv(Img) % fungsi untuk ekstraksi fitur ruang warna hsv citra makanan
        HSV = rgb2hsv(Img); % konversi gambar menjadi ruang warna hsv
        meanHue = mean2(HSV(:, :, 1)); % rata-rata dari fitur hue
        meanSat = mean2(HSV(:, :, 2)); % rata-rata dari fitur saturasi
        meanValue = mean2(HSV(:, :, 3)); % rata-rata dari fitur value
        sdImage = stdfilt(HSV(:, :, 3)); % menerapkan filter standar deviasi ke fitur value
        meanStdDev = mean2(sdImage); % rata-rata dari standar deviasi
    end

    function [CON, CORR, E, H] = ekstraksi_tekstur(bw) % fungsi untuk ekstraksi tekstur citra makanan
        GLCM = graycomatrix(bw, 'Offset', [0 1; -1 1; -1 0; -1 -1]); % membuat matriks co-occurence tingkat abu-abu dari gambar n.gif
        stats = graycoprops(GLCM, {'contrast', 'correlation', 'energy', 'homogeneity'}); % menghitung statistik GLCM untuk mendapatkan nilai kontras, korelasi, energi, dan homogenitas
        CON = mean(stats.Contrast); % menghitung rata-rata dari matriks kontras
        CORR = mean(stats.Correlation); % menghitung rata-rata dari matriks korelasi
        E = mean(stats.Energy); % menghitung rata-rata dari matriks energi
        H = mean(stats.Homogeneity); % menghitung rata-rata dari matriks homogeneity
    end

    function [P, A, Ec, M] = ekstraksi_bentuk(bw) % fungsi untuk ekstraksi bentuk dan ukuran citra makanan
        stats = regionprops(bw, 'Perimeter', 'Area', 'Eccentricity'); % menghitung fitur bentuk gambar n.gif berdasarkan daerah pada gambar
        P = stats.Perimeter; % menyimpan nilai perimeter
        A = stats.Area; % menyimpan nilai area
        Ec = stats.Eccentricity; % simpan eccentricity ke dalam matriks E indeks ke-n
        M = 4 * pi * A / P^2; % hitung nilai metric, simpan ke dalam matriks M index ke-n
    end
end