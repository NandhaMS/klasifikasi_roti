clc; clear; close all;

if ~isfile('fitur.csv') % jika file fitur.csv belum ada
    segmentasi_ekstraksi; % jalankan script untuk segmentasi dan ekstraksi fitur
end

csv = readcell('fitur.csv'); % baca fitur.csv untuk mengambil data fitur dan nama kelas
X = cell2mat(csv(:, 1:end-1)); % mengambil data fitur
y = csv(:, end); % mengambil nama kelas
y = categorical(y); % membuat categorical untuk nama kelas

[idx, weights] = relieff(X, y, 1); % menghitung dan menentukan peringkat fitur paling penting untuk seleksi fitur

bar(weights(idx)) % menampilkan grafik bar skor
xlabel('Predictor rank')
ylabel('Predictor importance score')

fitur_terbaik = idx(1:5); % mengambil 5 fitur terbaik
writematrix(fitur_terbaik, 'fiturterbaik.csv'); % menyimpan 5 fitur terbaik ke dalam file csv