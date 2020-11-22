clc; clear; close all;

gunakan_fitur_terbaik = 1;

if gunakan_fitur_terbaik && ~isfile('fiturterbaik.csv') % jika menggunakan fitur terbaik, namun file fiturterbaik.csv tidak ada
    feature_selection; % jalankan script feature_selection
elseif ~isfile('fitur.csv') % jika file fitur.csv tidak ada
    segmentasi_ekstraksi; % jalankan script segmentasi_ekstraksi
end

klasifikasi('fitur.csv', gunakan_fitur_terbaik); % lakukan klasifikasi terhadap data sampel

function klasifikasi(namafile, bestfeatures)
    csv = readcell(namafile); % baca cell dari file
    fitur_warna = csv(2:end, 1:4); % kolom untuk fitur warna
    fitur_tekstur = csv(2:end, 5:8); % kolom untuk fitur warna
    fitur_bentukukuran = csv(2:end, 9:12); % kolom untuk fitur warna
    if bestfeatures % jika menggunakan fitur terbaik
        fitur_terbaik = readmatrix('fiturterbaik.csv'); % baca matrix dari file fiturterbaik.csv
        X = cell2mat(csv(2:end, fitur_terbaik)); % konversi cell dari csv ke matrix yang berisi fitur-fitur terbaik
    else
        X = cell2mat(fitur_bentukukuran); % konversi cell dari csv ke matrix yang berisi fitur yang ingin digunakan
    end
    y = csv(2:end, end)'; % mengambil nama kelas dari csv
    y = categorical(y); % membuat categorical untuk nama kelas
    sample = [6:10 26:30 41:45 56:60 71:75 86:90 101:105]; % mengambil data sampel, diambil 5 sampel setiap kelas
    XTest = X(sample, :); % membuat variabel untuk data uji
    yTest = y(sample)'; % membuat variabel untuk kelas dari data uji
    kelas = {'Burger', 'Croissants', 'Muffin', 'Pizza', 'RotiSobek', 'RotiTawar', 'Donut'}; % kelas klasifikasi jenis roti
    t = templateSVM('Standardize', true, 'KernelFunction', 'gaussian'); % membuat template svm terstandarisasi yang menyimpan support vector untuk model ecoc
    SVMModel = fitcecoc(X, y, 'Learners', t, 'ClassNames', kelas); % membuat model multi class svm menggunakan ecoc dan template svm yang telah dibuat
    CompactSVMModel = compact(SVMModel); % mengurangi ukuran SVMModel
    [labels, PostProbs] = predict(CompactSVMModel, XTest); % melakukan pengujian model svm menggunakan data uji dari matriks Z
    table(yTest, labels, PostProbs(:, 2),'VariableNames',...
        {'TrueLabels','PredictedLabels','PosClassPosterior'}) % menampilkan tabel hasil klasifikasi dan nilai posterior
    acc = sum(labels == yTest) ./ numel(yTest) % menghitung akurasi dari model multi class svm
    fclose('all'); % menutup semua file yang digunakan
end