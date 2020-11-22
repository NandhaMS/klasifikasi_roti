clc; clear; close all;

if ~isfile('fitur.csv') % jika file fitur.csv belum ada
    segmentasi_ekstraksi; % jalankan script untuk segmentasi dan ekstraksi fitur
end

csv = readcell('fitur.csv'); % baca fitur.csv untuk mengambil data fitur dan nama kelas
fitur_warna_tekstur = csv(2:end, 1:8); % kolom untuk fitur warna dan tekstur
fitur_tekstur_bentukukuran = csv(2:end, 5:12); % kolom untuk fitur tekstur, bentuk, dan ukuran
fitur_warna_bentukukuran = csv(2:end, [1:4 9:12]); % kolom untuk fitur warna, bentuk, dan ukuran
fitur_gabungan = csv(2:end, 1:12); % kolom untuk gabungan fitur warna, tekstur, bentuk, dan ukuran
X = cell2mat(fitur_gabungan); % mengambil data fitur
y = csv(2:end, end); % mengambil nama kelas
y = categorical(y); % membuat categorical untuk nama kelas

[idx, weights] = relieff(X, y, 1); % menghitung dan menentukan peringkat fitur paling penting untuk seleksi fitur

bar(weights(idx)) % menampilkan grafik bar skor
xlabel('Predictor rank')
ylabel('Predictor importance score')

fitur_terbaik = idx(1:5); % mengambil fitur terbaik
writematrix(fitur_terbaik, 'fiturterbaik.csv'); % menyimpan 5 fitur terbaik ke dalam file csv