%根據所得的最佳解繪製甘特圖

function drawGanttChart()
global chromosome
global everyGenResult
global TotalGen
global c
global jobInfo
global numOfGen
%可以根據makespan那裡所得的scheduling matrix來繪圖
%vector=everyGenResult{size(everyGenResult,1),1}
OnlyjobInfo=jobInfo(2:size(jobInfo,1),:);     
OnlyjobInfo

ganttMaxWidth=(makespan(chromosome(1,:))/10)*10;


Va=everyGenResult{TotalGen,1}(1,:);

%draw the gantt chart--------------------------------------------------------------------------------------------
figure(2)
whitebg(2,'w')
axis fill 
if size(jobInfo,1)-1<=20
   subplot(2,1,1)
end   

for ix=1:size(OnlyjobInfo,2)  
      r=rand(1);      
      g=rand(1);            
      b=rand(1);      
      color=[r, g, b] ;
   for jx=1:size(OnlyjobInfo,1)  %jx is the number of machines
      if ix==1& jx==1   
         fill([c(ix,jx)-OnlyjobInfo(jx,Va(ix)),c(ix,jx),c(ix,jx),c(ix,jx)-OnlyjobInfo(jx,Va(ix)) ],...
              [round(ganttMaxWidth/20)*(jx-1),round(ganttMaxWidth/20)*(jx-1),round(ganttMaxWidth/20)*(jx),round(ganttMaxWidth/20)*(jx)],...
              [r g b]);
         if size(jobInfo,2)<15  
            text((2*c(ix,jx)-OnlyjobInfo(1,Va(ix)) )/2, round(ganttMaxWidth/20)*( (jx-1)+(jx))/2,['j',num2str(Va(ix))] )  
         end
         hold on
      elseif ix==1 & jx~=1
         fill([c(ix,jx)-OnlyjobInfo(jx,Va(ix) ),c(ix,jx),c(ix,jx),c(ix,jx)-OnlyjobInfo(jx,Va(ix)) ],...
            [round(ganttMaxWidth/20)*(jx-1),round(ganttMaxWidth/20)*(jx-1),round(ganttMaxWidth/20)*(jx),round(ganttMaxWidth/20)*(jx)],...
            [r g b]);
          if size(jobInfo,2)<15  
             text((2*c(ix,jx)-OnlyjobInfo(jx,Va(ix)) )/2, round(ganttMaxWidth/20)*((jx-1)+(jx))/2  ,['j',num2str(Va(ix))] )  
          end 
        hold on
      else
         fill([c(ix,jx)-OnlyjobInfo(jx,Va(ix)),c(ix,jx),c(ix,jx),c(ix,jx)-OnlyjobInfo(jx,Va(ix)) ],...
              [round(ganttMaxWidth/20)*(jx-1),round(ganttMaxWidth/20)*(jx-1),round(ganttMaxWidth/20)*(jx),round(ganttMaxWidth/20)*(jx)],...
              [r g b]);
         if size(jobInfo,2)<15    
            text( (2*c(ix,jx)-OnlyjobInfo(jx,Va(ix)) )/2, round(ganttMaxWidth/20)*( (jx-1)+(jx))/2,['j',num2str(Va(ix))] )  
         end   
         hold on
      end       
   end   
end   



%Prepare for string output
StrResult{1,1}=num2str(chromosome(1,1) );
for ix=2:size(chromosome(1,:),2) 
  StrResult{1,ix}=strcat('-',num2str(chromosome(1,ix)));
end
Best_job_seq=strcat(StrResult{1,:});
ts=sprintf('The best job-seq till now is:%s',Best_job_seq);

axis tight ij
         
title({['The Gantt Chart ',' Total Iteration = ',num2str(TotalGen),'   complete time =',num2str(makespan(chromosome(1,:)))],...
        ts} );
xlabel(' time ')
shg
set(gca,'YTick',[round(ganttMaxWidth/20)*0.5:round(ganttMaxWidth/20):10000000])

for ix=1:size(OnlyjobInfo,1)
   MachineLabel{1,ix}=['Machine',num2str(ix)];
end   
set(gca,'YTickLabel',MachineLabel)
set(gcf,'position',[ 1 29 1024 672 ]) %1024*768將螢幕放到最大，要注意解析度的問題



%再加畫折線圖---------------------------------------------------------------


for ix=1:size(everyGenResult,1)
   temp(ix)=makespan(everyGenResult{ix,1}(1,:) );
end 

if size(jobInfo,1)-1<=20
   subplot(2,1,2)
else   
      figure(3)
end
%whitebg
for ix=1:size(everyGenResult,1)-1
   plot([ix,ix+1],[temp(ix),temp(ix+1)],'r-','LineWidth',3);
   hold on;
end
axis fill tight auto
grid on
firstOptGen=find(temp==min(temp));
firstOptGen=min(firstOptGen);

yt=min(get(gca,'YTick'));
%'\bullet\leftarrow 
%Set the Horizontal Alignment
if firstOptGen<=TotalGen/2
   LorR='left';
else   
   LorR='right';
end   

text(firstOptGen,min(temp)-5,['In the ',num2str(firstOptGen)...
      ,' the generaion we first find the solution as the best complete time = ',num2str(min(temp))],'VerticalAlignment','top'...
      ,'HorizontalAlignment',LorR,'FontSize',15)
xlabel('Generation Number')
ylabel('complete time')
title('The line chart of complete time by using Genetic Algorithm')
set(gcf,'position',[ 1 29 1024 672 ]) %1024*768將螢幕放到最大，要注意解析度的問題
%set(gcf,'Units','normalized')  

set(gca,'ylim',[min(temp)-10, max(temp)+10])

