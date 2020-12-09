function s = klasifikasi(fiturpilihan, kombinasifitur, acaksampel, displaybar, fig)
    if ~isfile('fitur.csv') % jika file fitur.csv belum ada
        s = segmentasi_ekstraksi(0, fig); % jalankan script untuk segmentasi dan ekstraksi fitur
    end
    d = loading("Sedang melakukan klasifikasi", fig);
    csv = readcell('fitur.csv'); % baca cell dari file
    if (fiturpilihan == 1) % jika menggunakan fitur warna
        fitur_warna = csv(2:end, 1:4); % kolom untuk fitur warna
        X = cell2mat(fitur_warna); % konversi cell dari csv ke matrix yang berisi fitur warna
    elseif (fiturpilihan == 2) % jika menggunakan fitur tekstur
        fitur_tekstur = csv(2:end, 5:8); % kolom untuk fitur tekstur
        X = cell2mat(fitur_tekstur); % konversi cell dari csv ke matrix yang berisi fitur warna
    elseif (fiturpilihan == 3) % jika menggunakan fitur bentukukuran
        fitur_bentukukuran = csv(2:end, 9:12); % kolom untuk fitur bentuk dan ukuran
        X = cell2mat(fitur_bentukukuran); % konversi cell dari csv ke matrix yang berisi fitur warna
    elseif (fiturpilihan == 4) % jika menggunakan fitur kombinasi
        s = feature_selection(kombinasifitur, displaybar, fig); % jalankan script seleksi fitur
        fitur_kombinasi = readmatrix('fiturterbaik.csv'); % baca matrix dari file fiturterbaik.csv
        X = cell2mat(csv(2:end, fitur_kombinasi)); % konversi cell dari csv ke matrix yang berisi fitur-fitur terbaik
    end
    y = csv(2:end, end-1)'; % mengambil nama kelas dari csv
    y = categorical(y); % membuat categorical untuk nama kelas
    if (acaksampel)
        burger = randperm(15, 5); % ambil 5 sampel acak dari burger
        croissant = randperm(15, 5) + 15; % ambil 5 sampel acak dari croissant
        muffin = randperm(15, 5) + 30; % ambil 5 sampel acak dari muffin
        pizza = randperm(15, 5) + 45; % ambil 5 sampel acak dari pizza
        rotisobek = randperm(15, 5) + 60; % ambil 5 sampel acak dari rotisobek
        rotitawar = randperm(15, 5) + 75; % ambil 5 sampel acak dari rotitawar
        donat = randperm(15, 5) + 90; % ambil 5 sampel acak dari donat
        sample = [burger croissant muffin pizza rotisobek rotitawar donat]; % gabung semua sampel acak menjadi satu
    else
        sample = [6:10 26:30 41:45 56:60 71:75 86:90 101:105];
    end
    XTest = X(sample, :); % membuat variabel untuk data uji
    yTest = y(sample)'; % membuat variabel untuk kelas dari data uji
    kelas = {'Burger', 'Croissants', 'Muffin', 'Pizza', 'RotiSobek', 'RotiTawar', 'Donut'}; % kelas klasifikasi jenis roti
    t = templateSVM('Standardize', true, 'KernelFunction', 'gaussian'); % membuat template svm terstandarisasi yang menyimpan support vector untuk model ecoc
    SVMModel = fitcecoc(X, y, 'Learners', t, 'ClassNames', kelas); % membuat model multi class svm menggunakan ecoc dan template svm yang telah dibuat
    CompactSVMModel = compact(SVMModel); % mengurangi ukuran SVMModel
    [labels, ~] = predict(CompactSVMModel, XTest); % melakukan pengujian model svm menggunakan data uji dari matriks Z
    gambarTest = csv(sample, end); % path gambar sampel
    acc = sum(labels == yTest) ./ numel(yTest); % menghitung akurasi dari model multi class svm
    acc = "Akurasi :" + " " + num2str((round(acc * 100) / 100) * 100) + "%"; % konversi akurasi menjadi string
    figure('Name', acc, 'NumberTitle', 'off')
    for i = 1:numel(sample)
        Img = imread(gambarTest{i});
        subplot(5, 7, i), imshow(Img), title(labels{i});
    end
    fclose('all'); % menutup semua file yang digunakan
    close(fig);
    close(d);
    s = 1;
end