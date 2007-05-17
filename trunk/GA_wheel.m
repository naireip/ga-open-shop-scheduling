function new_popu=GA_wheel(fitness, popu)
% function new_popu=GA_wheel(fitness, popu)
% GA_wheel.m
% Use of Roulette wheel selection method to get
% new_popu.

% PenChen Chou, 6-30-2001

% Remove the negative fitness values
 Y=min(fitness);
 if Y<0
     fitness=fitness-Y;
 end;
 popu_n=length(fitness);
% calculate ratio of fitness
 fit_sum=sum(fitness);
 fit_mean=fit_sum/popu_n;
% Select the parent population
 popu_select=fitness/fit_mean;
% Amplify the popu_select to make the first gene being
% selected twice
 if popu_select(1)<2
     popu_select=popu_select.^2;
 end;
 popu_select=round(popu_select);
% If no enough popu size to make the parent, make up
 Y=sum(popu_select);
 while (Y<popu_n)
     I=find(popu_select==0);
     popu_select(I(1))=popu_select(I(1))+1;
     Y=sum(popu_select);
 end;
 %disp('===>New select population index table:');
 %popu_select'
% Get the new population
 K=1;
 for I=1:popu_n
     if popu_select(I)>0
         for J=1:popu_select(I)
           new_popu(K,:)=popu(I,:);
           K=K+1;
           if K>popu_n, break; end; %Enough popu size
         end;
     end;
     if K>popu_n, break; end; %Enough popu size
 end;