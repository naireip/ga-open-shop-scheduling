function drawGanttChart2007()
global timeTable
global jobInfo
jobWeight = jobInfo(end, :);
%determine color
figure
for ix =1: size(timeTable,2)
      r=rand(1);      
      g=rand(1);            
      b=rand(1);      
      color{ix}=[r, g, b] ;
end


for ix = 1: size(timeTable,1)
    for jx = 1: size(timeTable,2)      
        fill([timeTable{ix,jx}.start, timeTable{ix,jx}.start,  timeTable{ix,jx}.end, timeTable{ix,jx}.end],[ix, ix+1, ix+1, ix], color{timeTable{ix,jx}.job_no})
        hold on
        drawnow
        text((timeTable{ix,jx}.start + timeTable{ix,jx}.end -1)/2, ((ix+ix+1)/2), ['J',num2str(timeTable{ix,jx}.job_no)])
    end
end

box on


set(gca,'YTick',[1.5:10000000])

for ix=size(timeTable,1):-1:1
   MachineLabel{1,ix}=['Machine',num2str(ix)];
end   
set(gca,'YTickLabel',MachineLabel)
set(gcf,'position',[ 1 29 1024 672 ]) %1024*768將螢幕放到最大，要注意解析度的問題
xlabel('Time')


% 計算weighted complete time
completeTime = zeros(1, size(timeTable,2));
%================================================
for ix =1: size(timeTable,2) 
    for jx = size(timeTable,1) :-1:1
        for kx = size(timeTable,2) :-1:1
            if (timeTable{jx, kx}.job_no == ix && timeTable{jx,kx}.end > completeTime(ix))
                completeTime(ix) = timeTable{jx,kx}.end;
            end
        end
    end
end
completeTime =completeTime(find(completeTime ~=0));

weightedCompleteTime = sum(completeTime.*jobWeight);
%========================================================

maxTimeLength = timeTable{1, size(timeTable,2)    }.end;
for ix = 1:  size(timeTable,1)         
    if (timeTable{ix,  size(timeTable,2)      }.end > maxTimeLength)
        maxTimeLength  = timeTable{ix,  size(timeTable,2)      }.end;
    end
end

title(['Weighted Complete Time is : ', num2str(weightedCompleteTime)])
grid on