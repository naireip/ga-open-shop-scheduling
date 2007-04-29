function GAT_statDraw()
global Pm
global Pc        %probability of crossover
global chromosome
global everyGenResult
global boundGen  %计絛瞅┪弧璶σ納计絛瞅
global numOfGen
global pop_size
global TotalGen
global jobInfo
global someValue
global swDynaGraph
global c          %every job of machine makespan
global NowGen
global Run
global EachRunResult
global EachRunResult
global EachRunChr


%figure(gcf+1)
 
subplot(3,1,1)
bar(EachRunResult(:,1) )
%xlabel('No. of Run ')
ylabel('# of generation')
title({['把计:','Pm=',num2str(Pm),',Pc=',num2str(Pc),',pop-size=',num2str(pop_size),...
         ',Total Generation=',num2str(TotalGen)],...
      ['材Ω㎝ヘ玡程ㄎ秆计: 程',num2str(max(EachRunResult(:,1))),...
         ' 程',num2str(min(EachRunResult(:,1))),' キА',num2str(sum(EachRunResult(:,1))/size(EachRunResult,1) ),...
        ' 夹非畉',num2str(std(EachRunResult(:,1))), ' Range=',num2str( max(EachRunResult(:,1))-min(EachRunResult(:,1))) ] })  
axis tight
grid on
%set(gca,'ylim',[min(EachRunResult(:,1))-1, max(EachRunResult(:,1))+5])

subplot(3,1,2)
bar(EachRunResult(:,2),'r' )
%xlabel('No. of Run')
ylabel('Objective value')
title(['程ㄎ秆(Best Value): 程',num2str(max(EachRunResult(:,2))),' 程',num2str(min(EachRunResult(:,2))),...
      ' キА',num2str(sum(EachRunResult(:,2))/size(EachRunResult,1) ),' 夹非畉',num2str(std(EachRunResult(:,2))),...
      ' Range=',num2str(max(EachRunResult(:,2))-min(EachRunResult(:,2)) )] )  
axis  tight
grid on
set(gca,'ylim',[min(EachRunResult(:,2))-10, max(EachRunResult(:,2))+10])

%text(size(EachRunResult,1)/2, max(EachRunResult(:,2))+16,['把计:','Pm=',num2str(Pm),...
%      ',Pc=',num2str(Pc),',pop-size=',num2str(pop_size),',Total Generation=',num2str(TotalGen)]...
%     ,'HorizontalAlignment','center')

subplot(3,1,3)
bar(EachRunResult(:,3),'g' )
xlabel('No. of Run')
ylabel('CPU time')
title([' Run磅︽丁(sec): 程',num2str(max(EachRunResult(:,3))),' 程',num2str(min(EachRunResult(:,3))),...
      ' キА',num2str(sum(EachRunResult(:,3))/size(EachRunResult,1) ),' 夹非畉',num2str(std(EachRunResult(:,3))),...
      ' Range=',num2str(max(EachRunResult(:,3))-min(EachRunResult(:,3)) )] )  
axis  tight
grid on
%set(gca,'ylim',[min(EachRunResult(:,2))-10, max(EachRunResult(:,2))+10])





set(gcf,'position',[ 1 29 1024 672 ]) %1024*768盢棵辊程璶猔種秆猂拜肈
%set(gcf,'Units','normalized')  
%gtext(['把计:','Pm=',num2str(Pm),...
%      ',Pc=',num2str(Pc),',pop-size=',num2str(pop_size),',Total Generation=',num2str(TotalGen)]...
%     ,'HorizontalAlignment','left')  
%---------------------------------------------------------------------------------------------------
patterns=[];
patterns=unique(EachRunResult(:,2),'rows');

for ix=1:size(patterns,1)
   patterns(ix,2)=length(find(EachRunResult(:,2)==patterns(ix,1) ));
end   

forPieData=[patterns(:,1),patterns(:,2)]

for ix=1:size(patterns,1)
   PieLabel{ix,1}=num2str(patterns(ix,1));
end   
drawnow


figure(gcf+1)
pie3( patterns(:,2),[1,zeros(1,length(patterns(:,2))-1) ],PieLabel);
suptitle(['┮ΤRunぇい,ヘ玡程ㄎ秆(best value)=',num2str(patterns(1,1)),' ,瞷ゑㄒ:',num2str(patterns(1,2)/sum(patterns(:,2))*100 ),'%'])
view(-26,68)
set(gcf,'position',[ 1 29 1024 672 ]) %1024*768盢棵辊程璶猔種秆猂拜肈
