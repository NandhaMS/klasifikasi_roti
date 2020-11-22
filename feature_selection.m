clc; clear; close all;

if ~isfile('fitur.csv') % jika file fitur.csv belum ada
    segmentasi_ekstraksi; % jalankan script untuk segmentasi dan ekstraksi fitur
end

csv = readcell('fitur.csv'); % baca fitur.csv untuk mengambil data fitur dan nama kelas
fitur_warna_tekstur = csv(:, 1:8); % kolom untuk fitur warna dan tekstur
fitur_tekstur_bentukukuran = csv(:, 5:12); % kolom untuk fitur tekstur, bentuk, dan ukuran
fitur_warna_bentukukuran = csv(:, [1:4 9:12]); % kolom untuk fitur warna, bentuk, dan ukuran
fitur_gabungan = csv(:, 1:12); % kolom untuk gabungan fitur warna, tekstur, bentuk, dan ukuran
fiturpilihan = fitur_warna_bentukukuran;
featurevalue = fiturpilihan(2:end, :);
featurename = fiturpilihan(1, :);
X = cell2mat(featurevalue); % mengambil data fitur
y = csv(2:end, end); % mengambil nama kelas
y = categorical(y); % membuat categorical untuk nama kelas

[idx, weights] = relieff(X, y, 1); % menghitung dan menentukan peringkat fitur paling penting untuk seleksi fitur

bar(weights(idx)) % menampilkan grafik bar skor
xlabel('Predictor rank')
ylabel('Predictor importance score')
xticklabels(featurename(idx)); % atur label setiap bar dengan nama fitur
xtickangle(45); % atur kemiringan tulisan label menjadi 45 derajat

keseluruhan_fitur = csv(1, 1:end-1);
for i = 1:5
    id(i) = find(strcmp(keseluruhan_fitur, featurename(idx(i))));
end
fitur_terbaik = id; % mengambil fitur terbaik
writematrix(fitur_terbaik, 'fiturterbaik.csv'); % menyimpan 5 fitur terbaik ke dalam file csv