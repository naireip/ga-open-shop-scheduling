function GATDrawGantt()
%根據所得的最佳解繪製甘特圖

global TotalGen
global jobInfo
global numOfGen
global EachRunResult
global EachRunChr
global TotalRun
AllRunChr=[];
%可以根據makespan那裡所得的scheduling matrix c 來繪圖
%vector=everyGenResult{size(everyGenResult,1),1}
OnlyjobInfo=jobInfo(2:size(jobInfo,1),:);     

BestRun=find(EachRunResult(:,2)==min(EachRunResult(:,2)) );
for ix=1:TotalRun
  AllRunChr(size(AllRunChr,1)+1:size(AllRunChr,1)+size(EachRunChr{ix},1),:) =[EachRunChr{ix}];
end
for ix=1:size(AllRunChr,1)
   AllRunAns(ix,:)=[makespan(AllRunChr(ix,:)),AllRunChr(ix,:)   ];
end   
patterns=unique(AllRunAns,'rows');

Va=patterns(1,2:size(jobInfo,2)+1);
ganttMaxWidth=(makespan(Va)/10)*10;
[TimeLen,c]=makespan(Va);


%draw the gantt chart--------------------------------------------------------------------------------------------
figure(gcf+1)
whitebg(2,'w')
axis fill 
%subplot(2,1,1)
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
         text((2*c(ix,jx)-OnlyjobInfo(1,Va(ix)) )/2, round(ganttMaxWidth/20)*( (jx-1)+(jx))/2,['j'num2str(Va(ix))] )  
         hold on
      elseif ix==1 & jx~=1
         fill([c(ix,jx)-OnlyjobInfo(jx,Va(ix) ),c(ix,jx),c(ix,jx),c(ix,jx)-OnlyjobInfo(jx,Va(ix)) ],...
            [round(ganttMaxWidth/20)*(jx-1),round(ganttMaxWidth/20)*(jx-1),round(ganttMaxWidth/20)*(jx),round(ganttMaxWidth/20)*(jx)],...
            [r g b]);
          text((2*c(ix,jx)-OnlyjobInfo(jx,Va(ix)) )/2, round(ganttMaxWidth/20)*((jx-1)+(jx))/2  ,['j'num2str(Va(ix))] )  

        hold on
      else
         fill([c(ix,jx)-OnlyjobInfo(jx,Va(ix)),c(ix,jx),c(ix,jx),c(ix,jx)-OnlyjobInfo(jx,Va(ix)) ],...
              [round(ganttMaxWidth/20)*(jx-1),round(ganttMaxWidth/20)*(jx-1),round(ganttMaxWidth/20)*(jx),round(ganttMaxWidth/20)*(jx)],...
              [r g b]);
         text( (2*c(ix,jx)-OnlyjobInfo(jx,Va(ix)) )/2, round(ganttMaxWidth/20)*( (jx-1)+(jx))/2,['j'num2str(Va(ix))] )  
         hold on
      end       
   end      
end   
      
axis tight ij
         
Title(['The Gantt Chart ',' Total Iteration ='num2str(TotalGen*TotalRun),', Total Generation='num2str(TotalGen),...
       ', Total Run=',num2str(TotalRun),' makespan=',num2str(makespan(Va))] );
xlabel(' 時間 ')
shg
set(gca,'YTick',[round(ganttMaxWidth/20)*0.5:round(ganttMaxWidth/20):10000000])

for ix=1:size(OnlyjobInfo,1)
   MachineLabel{1,ix}=['Machine'num2str(ix)];
end   
set(gca,'YTickLabel',MachineLabel)

if size(jobInfo,1)<=20
   set(gca,'position',[ 0.15 0.25 0.775 0.5 ])  %甘特圖軸的大小   
end   
set(gcf,'position',[ 1 29 1024 672 ]) %1024*768將螢幕放到最大，要注意解析度的問題
%set(gcf,'Units','normalized')  


