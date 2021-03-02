function y=tran(a,b,x,L)     % Binary to decimal
    base=2.^((L-1):-1:0);
    y=dot(base,x);
    y=a+y*(b-1)/(2^L-1)';
end