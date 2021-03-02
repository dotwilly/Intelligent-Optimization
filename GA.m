% Genetic Algorithms
a=-100; % Lower bound
b=100;% Upper bound
NP=1000;% Population Size
NG=50;% Evolution
Pc=0.99;% Crossover Rate
Pm=0.01;% Mutation Rate
c=0.01;% Accuracy

L=ceil(log2((b-a)/c+1)); % Coding length
x=zeros(NP,2*L);% 0-1 Coding
x1=zeros(NP,L);% 0-1 Coding
x2=zeros(NP,L);% 0-1 Coding
for i=1:NP
    x(i,:)=Initial(2*L);% Initial
    x1(i,:)=x(i,1:L);% Initial
    x2(i,:)=x(i,(L+1):2*L);% Initial
    fx(i)=JDS([tran(a,b,x1(i,:),L),tran(a,b,x2(i,:),L)]);
end
for k=1:NG
    sumfx=sum(fx);
    Px=fx/sumfx;
    PPx=0;
    PPx(1)=Px(1);
    for i=2:NP  % Proportional Selection Father
        PPx(i)=PPx(i-1)+Px(i);
    end
    for i=1:NP
        epsilon=rand();
        for n=1:NP
            if epsilon <= PPx(n)
                Father = n;
                break;
            end
        end
        Mother=floor(rand()*(NP-1))+1;   % Random Selection Mother
        posCut=floor(rand()*(L-2))+1;   % Random Cross Point
        r1=rand();
        if r1<=Pc  % Cross or NotCross
            tempx(i,1:posCut)=x(Father,1:posCut);
            tempx(i,(posCut+1):2*L)=x(Mother,(posCut+1):2*L);
            r2=rand();
            if r2<=Pm    % Mutation or NotMutation
                posMut=floor(rand()*(2*L-1)+1);% Random Mutation Point
                tempx(i,posMut)=~tempx(i,posMut);
            end
        else
            tempx(i,:)=x(Father,:);
        end
    end
    x=tempx;
    
    for i=1:NP
        x1(i,:) = x(i,1:L);
        x2(i,:) = x(i,(L+1):2*L);
        fx(i)=JDS([tran(a,b,x1(i,:),L),tran(a,b,x2(i,:),L)]);
    end
    fv=-inf;
    for i=1:NP
      fitx=JDS([tran(a,b,x1(i,:),L),tran(a,b,x2(i,:),L)]);
      if fitx > fv
          fv=fitx;
          xv=[tran(a,b,x1(i,:),L),tran(a,b,x2(i,:),L)];
      end
    end
disp([xv,fv]);
end
fprintf('Genetic Algorithms Results:\n');
fprintf('x1,x2: %f,%f \nValue: %f\n',xv,fv);

