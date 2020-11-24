function s = feature_selection(kombinasifitur, displaybar, fig)
    d = loading("Sedang melakukan seleksi fitur", fig);
    csv = readcell('fitur.csv'); % baca fitur.csv untuk mengambil data fitur dan nama kelas
    fitur_warna_tekstur = csv(:, 1:8); % kolom untuk fitur warna dan tekstur
    fitur_tekstur_bentukukuran = csv(:, 5:12); % kolom untuk fitur tekstur, bentuk, dan ukuran
    fitur_warna_bentukukuran = csv(:, [1:4 9:12]); % kolom untuk fitur warna, bentuk, dan ukuran
    fitur_gabungan = csv(:, 1:12); % kolom untuk gabungan fitur warna, tekstur, bentuk, dan ukuran
    if (kombinasifitur == 1) % jika kombinasi fitur yang dipilih adalah 1
        fiturpilihan = fitur_warna_tekstur; % pilih kombinasi fitur warna dan tekstur
    elseif (kombinasifitur == 2) % jika kombinasi fitur yang dipilih adalah 2
        fiturpilihan = fitur_tekstur_bentukukuran; % pilih kombinasi fitur tekstur, bentuk dan ukuran
    elseif (kombinasifitur == 3) % jika kombinasi fitur yang dipilih adalah 3
        fiturpilihan = fitur_warna_bentukukuran; % pilih kombinasi fitur warna, bentuk dan ukuran
    elseif (kombinasifitur == 4) % jika kombinasi fitur yang dipilih adalah 4
        fiturpilihan = fitur_gabungan; % pilih kombinasi semua fitur
    end
    featurevalue = fiturpilihan(2:end, :); % mengambil nilai fitur pilihan
    featurename = fiturpilihan(1, :); % mengambil nama fitur pilihan
    X = cell2mat(featurevalue); % mengambil data fitur
    y = csv(2:end, end-1); % mengambil nama kelas
    y = categorical(y); % membuat categorical untuk nama kelas

    [idx, weights] = relieff(X, y, 1); % menghitung dan menentukan peringkat fitur paling penting untuk seleksi fitur
    
    if (displaybar)
        figure('Name','Peringkat Fitur','NumberTitle','off')
        bar(weights(idx)) % menampilkan grafik bar skor
        xlabel('Predictor rank')
        ylabel('Predictor importance score')
        xticklabels(featurename(idx)); % atur label setiap bar dengan nama fitur
        xtickangle(45); % atur kemiringan tulisan label menjadi 45 derajat
    end

    keseluruhan_fitur = csv(1, 1:end-1); % mengambil nama keseluruhan fitur dari dataset csv
    % mengambil index kolom fitur terbaik
    for i = 1:5 % perulangan dari i = 1 hingga 5
        id(i) = find(strcmp(keseluruhan_fitur, featurename(idx(i)))); % simpan index kolom ke dalam matrix id ke-i
    end
    fitur_terbaik = id; % mengambil fitur terbaik
    writematrix(fitur_terbaik, 'fiturterbaik.csv'); % menyimpan 5 fitur terbaik ke dalam file csv
    close(d);
    s = 1; % return 1 untuk penanda fitur telah berhasil dijalankan
end