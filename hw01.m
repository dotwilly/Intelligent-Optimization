A1=uniform(32679,17,65536,1);%multiplier 32679¡Aincrement 17¡Amodulus 65536¡Ainitial value 1
A2=uniform(32679,17,65536,90);%multiplier 32679¡Aincrement 17¡Amodulus 65536¡Ainitial value 90
A3=uniform(32679,17,65536,300);%multiplier 32679¡Aincrement 17¡Amodulus 65536¡Ainitial value 300
A4=uniform(32679,17,65536,500);%multiplier 32679¡Aincrement 17¡Amodulus 65536¡Ainitial value 500
A5=uniform(32679,17,65536,700);%multiplier 32679¡Aincrement 17¡Amodulus 65536¡Ainitial value 700
A6=uniform(32679,17,65536,1000);%multiplier 32679¡Aincrement 17¡Amodulus 65536¡Ainitial value 1000
A7=uniform(32679,17,65536,1300);%multiplier 32679¡Aincrement 17¡Amodulus 65536¡Ainitial value 1300
A8=uniform(32679,17,65536,1800);%multiplier 32679¡Aincrement 17¡Amodulus 65536¡Ainitial value 1800
A9=uniform(32679,17,65536,3400);%multiplier 32679¡Aincrement 17¡Amodulus 65536¡Ainitial value 3400
A10=uniform(32679,17,65536,5000);%multiplier 32679¡Aincrement 17¡Amodulus 65536¡Ainitial value 5000
A11=uniform(32679,17,65536,10000);%multiplier 32679¡Aincrement 17¡Amodulus 65536¡Ainitial value 10000
A12=uniform(32679,17,65536,14000);%multiplier 32679¡Aincrement 17¡Amodulus 65536¡Ainitial value 14000

Z=(A1+A2+A3+A4+A5+A6+A7+A8+A9+A10+A11+A12)-6*ones(65536,1); %Generate a normal distribution satisfy N(0,1)
X=2*ones(65536,1)+3*Z; %Generate a normal distribution satisfy N(2,9)

%Use 0-1 uniform distribution random A1,A9 to estimate pi
NC=0;
NS=65536; %1*1 square number (total points)
for i=1:65536
if sqrt((A1(i,1)-1/2)^2+(A9(i,1)-1/2)^2)<=1/2 %the distance to circle center <= 1/2
NC=NC+1;%record the points
end
end;
p=4*NC/NS;%estimate the pi value
P=vpa(p,5);%output the accuracy to five decimal
fprintf(' Approximation ans: %5.5f\n', P);