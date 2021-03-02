% Tabu Search
a=-100;% Lower bound
b=100;% Upper bound 
NG=200;% Maximum iterations 
L=round(sqrt(NG));% Tabu length
tabu=[];% Taboo list
x1=(b-a)*(rand()-0.5);
x2=(b-a)*(rand()-0.5);% Initial value
value=JDS([x1,x2]);
x10=x1;
x20=x2;% Initial value assigne to Optimal value
value0=JDS([x10,x20]);
s=1;%scale
k=1;
 while k<NG
     sx=[];
     s=s*0.99;
 % Current solution generate five domain points 
 for i=1:5
     sx(i,1)=x1+(rand()-0.5)*s*(b-a);
     sx(i,2)=x2+(rand()-0.5)*s*(b-a);
     JDS_s(i)=JDS(sx(i,:)); % Calculate fitness of domain points
 end
[candidate_v,temp]=max(JDS_s);% Candidate fitness values and locations
candidate_x=sx(temp,:);

enddelta1=candidate_v-value; % Difference between candidate and current
delta2=candidate_v-value0;  % Difference between candidate and current optimal

if enddelta1<=0   % The candidate is assigned to the current in the next iteration. When the candidate is better than the current, the candidate is called the improved.
    x1=candidate_x(1);
    x2=candidate_x(2);
    value=JDS([x1,x2]);
    tabu=[tabu;[x1,x2]];% Update taboo list
    if size(tabu,1)>L  % When the taboo elements more than the taboo list, they are removed from the list first
        tabu(1,:)=[];
    end
    k=k+1; % After tabu table is updated, iterations increases by 1
else % If there is improvement to the current, it should be compared with the current optimal 
    if delta2>0  % candidate is better than the current optimal 
     % improved (candidate) is assigned to the current of the next iteration
     x1=candidate_x(1);
     x2=candidate_x(2);
     value=JDS([x1,x2]);
     tabu=[tabu;[x1,x2]];% Update taboo list
    if size(tabu,1)>L  % When the taboo elements more than the taboo list, they are removed from the list first
        tabu(1,:)=[];
    end
   
     % The improved (candidate) is assigned to the current optimal of the next iteration, where the contempt rule is included
     x10=x1;
     x20=x2;
     value0= value;
     k=k+1;% After tabu table is updated, iterations increases by 1
    % The improved (candidate) is assigned to the current optimal of the next iteration
    else
       if sum(ismember((candidate_x),tabu)) % Whether the improved (candidate) is in the tabu list, 0 means not, 1 means in
          x1=x1; % If the improved is in the tabu list, the current is used to regenerate the domain points and find the candidate 
          x2=x2;
          value=JDS([x1,x2]);
       else
        %The improved is not in tabu list, the improved (candidate) is assigned to the current of the next iteration
         x1=candidate_x(1);
         x2=candidate_x(2);
         value=JDS([x1,x2]);
         tabu=[tabu;[x1,x2]];% Update taboo list
         if size(tabu,1)>L  % When the taboo elements more than the taboo list, they are removed from the list first
         tabu(1,:)=[];
         end
         k=k+1;% After tabu table is updated, iterations increases by 1
       end
    end
end  
disp(k);
disp([x10,x20,value0]);
end

fprintf('Tabu Search Results:\n');
fprintf('x1,x2: %f,%f \nValue: %f\n',x10,x20,value0);

