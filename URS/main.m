clear
close all
clc

size = 2;

inputMatrix = ceil(randn(size));
inputMatrix = inputMatrix*inputMatrix'

outputMatrix = CholeskySqrt(inputMatrix,size)


% outputMatrix2 = GramSchmidtOrth(inputMatrix)