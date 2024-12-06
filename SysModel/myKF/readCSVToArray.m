function reshapedData = readCSVToArray(file_path)
    % CSV 파일 읽기
    data = readmatrix(file_path);

    % 데이터의 크기
    [numRows, numCols] = size(data);

    % 2행씩 끊어서 3차원 배열로 변환
    reshapedData = reshape(data', numCols, 2, []);
end