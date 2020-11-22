clc; clear; close all;

if ~isfile('fitur.csv')
    segmentasi_ekstraksi;
end

klasifikasi('fitur.csv');

function klasifikasi(namafile)
    csv = readcell(namafile);
    X = cell2mat(csv(:, 1:6));
    y = csv(:, end)';
    y = categorical(y);
    Z = X(1:90, :);
    yTest = y(1:90)';
    kelas = {'Burger', 'Croissants', 'Muffin', 'Pizza', 'RotiSobek', 'RotiTawar'}; % kelas klasifikasi jenis roti
    t = templateSVM('Standardize', true, 'KernelFunction', 'gaussian'); % membuat template svm terstandarisasi yang menyimpan support vector untuk model ecoc
    SVMModel = fitcecoc(X, y, 'Learners', t, 'ClassNames', kelas);
    CompactSVMModel = compact(SVMModel); % mengurangi ukuran SVMModel
    [labels,PostProbs] = predict(CompactSVMModel, Z); % melakukan pengujian model svm menggunakan data uji dari matriks Z
    table(Z, labels, PostProbs(:, 2),'VariableNames',...
        {'TrueLabels','PredictedLabels','PosClassPosterior'})
    acc = sum(labels == yTest) ./ numel(yTest)
    fclose('all');
end