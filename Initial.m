function result=Initial(length)     % Initial
    for i=1:length
        r=rand();
        result(i)=round(r);
    end
end