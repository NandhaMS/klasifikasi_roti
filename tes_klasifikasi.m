clc; clear; close all;

if ~isfile('fiturterbaik.csv') || ~isfile('fitur.csv')
    feature_selection;
end

klasifikasi('fitur.csv');

function klasifikasi(namafile)
    csv = readcell(namafile);
    fitur_terbaik = readmatrix('fiturterbaik.csv');
    X = cell2mat(csv(:, fitur_terbaik));
    y = csv(:, end)';
    y = categorical(y);
    Z = X;
    yTest = y';
    kelas = {'Burger', 'Croissants', 'Muffin', 'Pizza', 'RotiSobek', 'RotiTawar', 'Donut'}; % kelas klasifikasi jenis roti
    t = templateSVM('Standardize', true, 'KernelFunction', 'gaussian'); % membuat template svm terstandarisasi yang menyimpan support vector untuk model ecoc
    SVMModel = fitcecoc(X, y, 'Learners', t, 'ClassNames', kelas);
    CompactSVMModel = compact(SVMModel); % mengurangi ukuran SVMModel
    [labels, PostProbs] = predict(CompactSVMModel, Z); % melakukan pengujian model svm menggunakan data uji dari matriks Z
    table(Z, labels, PostProbs(:, 2),'VariableNames',...
        {'TrueLabels','PredictedLabels','PosClassPosterior'})
    acc = sum(labels == yTest) ./ numel(yTest)
    fclose('all');
end