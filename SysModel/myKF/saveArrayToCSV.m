function saveArrayToCSV(array, filename)
    % 배열을 CSV 파일로 저장하는 함수
    % array: 저장할 배열
    % filename: 저장할 CSV 파일 이름 (확장자 포함)

    % CSV 파일 열기
    fileID = fopen(filename, 'w');

    % 배열을 CSV 파일에 쓰기
    for k = 1:size(array, 3)
        for i = 1:size(array, 1)
            for j = 1:size(array, 2)
                fprintf(fileID, '%f', array(i, j, k));
                if j < size(array, 2)
                    fprintf(fileID, ',');
                end
            end
            fprintf(fileID, '\n');
        end
        % 3번째 차원을 구분하기 위해 빈 줄 추가
        if k < size(array, 3)
            fprintf(fileID, '\n');
        end
    end

    % 파일 닫기
    fclose(fileID);
end