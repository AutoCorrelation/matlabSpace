function output = demoldulate_FM(input,LO,Ts,k_f)
    temp1 = my_hilbert(input)./LO;
    temp2 = unwrap(angle(temp1));
    temp3 = getDerivative(temp2,Ts);
    output = temp3/(2*pi*k_f);
end
