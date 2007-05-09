function GAMainProc()
global Pm
global Pc        %probability of crossover
global chromosome
global everyGenResult
global boundGen  % the limited generation bound, or say: the generation range we considered
global numOfGen
global pop_size
global TotalGen
global jobInfo
global someValue
global swDynaGraph
global temp
global c          %every job of machine makespan
global TotalGen
global swMutation
global objValue;

TotalGen = TotalGen+1;
fprintf('\n\n==================Now is the %d th generation==============================\n',TotalGen)
%Pc的用法是，你先產生pop_size個介於0與1之間的隨機數，這些隨機數若＞0.3則表示它們要crossover
%然後要crossover的，再＜隨機＞兩兩配對，當然囉，這並非目前我的作法
for i=1:(pop_size*Pc/2)  %因為crossover是以對為單位
     t=mod(abs(ceil(rand(1,2)*10)),size(chromosome,1))  ;   
     a=t(1);
     b=t(2);
     if a==0 
        a=a+1;
     elseif b==0
        b=b+1;
     end
     
     Va=chromosome(a,:);
     Vb=chromosome(b,:);
     [newVa,newVb]=GACros(Va,Vb);
     chromosome(size(chromosome,1)+1,:) = newVa;
     chromosome(size(chromosome,1)+1,:) = newVb;
end

for i=1:round(pop_size*Pm)
   a=abs(ceil(rand(1,1)*pop_size));
   if a==0
      a=a+1 ;  
   end
   Va=chromosome(a,:);
   newVa=GAMut(Va);
   chromosome(size(chromosome,1)+1,:)=newVa;
end

%GA_object            %計算所有染色體的目標值
%maxValue = 0;
%for ix=1:size(chromosome,1)
%    if maxValue < completeTime(chromosome(ix,:))
%       maxValue = completeTime(chromosome(ix,:));
%    end
%end

for ix=1:size(chromosome,1)
   objValue(ix)= completeTime(chromosome(ix,:));
end
objValue;
ObjChromosome=[objValue',chromosome];

%GA_selection         %會淘汰目標值較差的染色體
%sortedOandC=flipud(sortrows(ObjChromosome)) ;                %注意目前的染色體已排序 ，暫用如此的方式
sortedOandC=(sortrows(ObjChromosome)) ;                %注意目前的染色體已排序 ，暫用如此的方式
ObjChromosome=sortedOandC(1:pop_size,:);

chromosome=ObjChromosome(:,2:size(ObjChromosome,2) );

everyGenResult{TotalGen,1}=chromosome;
everyGenResult{TotalGen,2}=sortedOandC(1,1);

fprintf('到目前為止的最佳 complete time 是%d\n',  completeTime(chromosome(1,:)));
fprintf('到目前為止的最佳job_seq是 %d-%d-%d-%d-%d-%d-%d-%d-%d-%d-%d-%d-%d-%d-%d-%d-%d-%d-%d \n' ,  chromosome(1,:) );



%Draw the dynamic line---------------------------------------------------------------------
close all
if swDynaGraph==1
  shg
  %set(gcf,'')
  whitebg(1,'k')

  for ix=TotalGen:size(everyGenResult,1)
     temp(ix)=completeTime(everyGenResult{ix,1}(1,:) );
  end



  for ix=1:size(everyGenResult,1)-1
     plot([ix,ix+1],[temp(ix),temp(ix+1)],'y--');
     hold on;
  end
    drawnow

  for ix=TotalGen:size(everyGenResult,1)
     plot(ix,temp(ix),'gs--','LineWidth',2,'MarkerEdgeColor','b','MarkerFaceColor','y','MarkerSize',10);   
     hold on;   
  end
  grid on
  xlabel('世代數')
  ylabel('Weighted Complete Time')
  title(['使用基因演算法的Weighted Complete Time變化折線圖,  第1代到第',num2str(TotalGen),'代'] )

  %axis fill tight
  try
  graphYMin = min(temp(:));
  graphYMax = max(temp(:));
  set(gca,'ylim',[graphYMin-20,   graphYMax+20])
catch
    graphYMin
    graphYMax
end
end


