function output = demoldulate_DSB_SC(input,LO,df)
    temp1 = input .* LO;
    temp2 = fftshift(fft(temp1));
    temp3 = lpf(temp2,22000,df);
    output = ifft(ifftshift(temp3));
end