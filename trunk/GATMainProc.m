function GATMainProc()
% This program is the project of jiing in 2002

global Pm
global Pc        %probability of crossover
global chromosome
global everyGenResult
global boundGen  %限制的世代數範圍，或說要考慮的世代數範圍
global numOfGen
global pop_size
global TotalGen
global jobInfo
global someValue
global swDynaGraph
global temp
global c          %every job of machine makespan
global elapsedTime
global NowGen
global ObjChromosome
global Run

fprintf('\n\n==================現在是第%d回合===第%d代==========================\n',Run,NowGen)

%Pc的用法是，你先產生pop_size個介於0與1之間的隨機數，這些隨機數若＞0.3則表示它們要crossover
%然後要crossover的，再＜隨機＞兩兩配對，當然囉，這並非目前我的作法

%now, I randomly choose two chromosome and let them crossover
%GA_crossover----------------------------------------------------------------
for i=1:(pop_size*Pc/2)  %因為crossover是以對為單位
     t=mod(abs(ceil(rand(1,2)*10)),size(chromosome,1))  ;   
     a=t(1);
     b=t(2);
     if a==0      %let a and b do not equal to 0
        a=a+1;
     elseif b==0
        b=b+1;
     end
     
     Va=chromosome(a,:);
     Vb=chromosome(b,:);
     [newVa,newVb]=GACros(Va,Vb);
     chromosome(size(chromosome,1)+1,:)=newVa;
     chromosome(size(chromosome,1)+1,:)=newVb;
  end
  
%GA_mutation----------------------------------------------------------------
for i=1:round(pop_size*Pm)
   a=abs(ceil(rand(1,1)*10));
   if a==0
      a=a+1 ;  
   end
   Va=chromosome(a,:);
   newVa=GAMut(Va);
   chromosome(size(chromosome,1)+1,:)=newVa;
end

%GA_object            %計算所有染色體的目標值--------------------------------
for ix=1:size(chromosome,1)
   objValue(ix)=1/makespan(chromosome(ix,:));
end

ObjChromosome=[objValue',chromosome];

%GA_selection         %會淘汰目標值較差的染色體-------------------------------------
sortedOandC=flipud(sortrows(ObjChromosome))  ;               %注意目前的染色體已排序 ，暫用如此的方式
ObjChromosome=sortedOandC(1:pop_size,:);

chromosome=ObjChromosome(:,2:size(ObjChromosome,2) );
everyGenResult{NowGen,1}=chromosome;
everyGenResult{NowGen,2}=sortedOandC(1,1);
elapsedTime=toc;                     %record the execution time of run #TotalGen 
everyGenResult{NowGen,3}=elapsedTime;

fprintf('到目前為止的最佳makespan是%d\n',  makespan(chromosome(1,:)));

StrResult{1,1}=num2str(chromosome(1,1) );
for ix=2:size(chromosome(1,:),2) 
  StrResult{1,ix}=strcat('-',num2str(chromosome(1,ix)));
end
Best_job_seq=strcat(StrResult{1,:});
fprintf('到目前為止的最佳job_seq是:%s',Best_job_seq);




