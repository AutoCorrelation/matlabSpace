clear
close all
clc

size = 3;

inputMatrix = randi(5,size)
inputMatrix = inputMatrix*inputMatrix';

outputMatrix = CholeskySqrt(inputMatrix,size)