function [timeLength,c]=completeTime(Va)
global jobInfo
global c
global numOfMach
global numOfJob

load jobInfo.txt
pureJobInfo = jobInfo(2:end-1,:)
jobWeight = jobInfo(end, :);
Va = [5 2 3 4 6 7 8 9 1];
numOfMach =3
numOfJob = 3
% Machine deal order
tmpReshape =reshape(Va, numOfMach, numOfJob)'
jobDealOrder = zeros(numOfJob, numOfMach);

for ix =1 : numOfMach    
    for jx = 1: length(Va)
       if ( Va(jx) <= length(Va)/numOfMach * ix   && Va(jx) >  length(Va)/numOfMach * (ix-1) )
           if (sum(jobDealOrder(ix, :)) == 0 ) % jobDealOrder IS EMPTY
               jobDealOrder(ix, 1) =  Va(jx);
           else               
               jobDealOrder(ix, sum(jobDealOrder(ix,:)~= 0)+1 ) =  Va(jx);
           end
       end 
    end
end
A = mod(jobDealOrder,numOfMach);

A (find(mod(A,numOfMach) ==0 ) )= numOfMach
jobDealOrder = A
cTable = cell(numOfMach, numOfJob);  %by using cTable to determine the processing order of the same job (multiple groups)
%till now the order is distribute into the matrix

%Next, following the jobDealOrder , we will decide which job should be process first
%while in the same order, shortest processing time first

for ix = 1: numOfMach
    
        if ( length(unique(jobDealOrder(:,ix))) < numOfJob)  % if there has the same jobOrder
           jobDealOrder(:,ix)
          % uniqueRows = unique(jobDealOrder(:,ix)) %find out row of the same value  in Col ix              
               [N,Bin] = histc(jobDealOrder(:,ix),1:max(jobDealOrder(:,ix)) );  %find out the larger multiple parts
               N
               % find out 1's ,then scheule it
               [cndIx] = find(N>1) %canNotDetermineNow
               find(N == 1 )
               shouldBeScheduleNow = find(N == 1 )
               %find out the location in jobDealOrder
               kxx =1;
               shouldBeShceduleNowIndex=[];
               for nxx = 1: length(shouldBeScheduleNow)
                   shouldBeShceduleNowIndex(kxx)  = find (jobDealOrder(:,ix) == shouldBeScheduleNow(kxx) )
                   kxx = kxx+1;
               end
               for nx = 1: length(shouldBeScheduleNow)
                   %the content in cTable{,} is [processing time , processing order]
                   
                   cTable{shouldBeShceduleNowIndex(nx),ix} = [ pureJobInfo(shouldBeShceduleNowIndex(nx),shouldBeScheduleNow(nx)) , 1] % the latest 1 denote to be scheduling first 
               end
               directOrderList =1:length(N);
               multipart = directOrderList(find ( (N >1) >0 ))   %which job numbers are multiple, can not be determine the order now
               for mx = 1: length(multipart) 
                   jobDealOrder(multipart(mx))
                   multipart(mx)
                    multipartIdx{mx} = find(jobDealOrder(:,ix) == jobDealOrder(multipart(mx),ix))
               end 
               
               %find out the processing order of same job 
               length(multipartIdx) 
               for kx = 1: length(multipartIdx) 
                   %find out the original index of the min time job
                   %judge to a while loop for rank out the order 1,2, 3,,..... 
                   orderIndex =1;
                   % HOW MANY empty cell in cTable{ix, multipartIdx}
                   %-==============================
                   emptyCellCnt =0;
                   emptyCellIndex=[];
                   jxx =1;
                   multipartIdx{kx}
                   for ixx=1:numOfMach
                       if(isempty(cTable{ixx,ix}) )
                          emptyCellCnt = emptyCellCnt + 1;
                          emptyCellIndex(jxx)=ixx;
                          jxx = jxx +1;
                       end
                   end
                   %-==============================
                   orderIndex = 1;
                   while(emptyCellCnt > 0 )  % while there  still some one is not deternined order
                       %find out the empty index and use the empty ones to find out the min to scheduling first                     
                      compareArray = pureJobInfo(emptyCellIndex, unique(jobDealOrder(emptyCellIndex,ix)))
                       scheduleFirstIndex =  find(compareArray == min(compareArray ) )  %kx denote the group number
                       %   needToCompareGroup{ix,kx} = min(pureJobInfo(ix, multipartIdx{kx} )  )
                        tmp = jobDealOrder(:,ix);
                       cTable{scheduleFirstIndex, ix} = [pureJobInfo(scheduleFirstIndex, tmp(scheduleFirstIndex) ), orderIndex]
                       orderIndex = orderIndex +1;  
                       
                       %-==============================
                       emptyCellCnt =0;
                       emptyCellIndex=[];
                       jxx =1;
                     %   for ixx=1:length(multipartIdx{kx})
                         for ixx= 1: numOfMach  
                               if(isempty(cTable{ixx,ix}) )
                                  emptyCellCnt = emptyCellCnt + 1;
                                  emptyCellIndex(jxx)=ixx;
                                  jxx = jxx +1;
                               end
                        end                   
                      %-==============================
                   end
               end
        else  % job order can be determined immediately
            %tmpProcTime = pureJobInfo(:,ix);
            for i =1: numOfMach
           temp(i) =  pureJobInfo(i,jobDealOrder(i, ix))
            end
           for idx = 1: size(pureJobInfo,1)                
                cTable{idx, ix} = [temp(idx),1];   % the latest 1 denote to be scheduling first
            end
        end
end
 
% Till now, we use cTable to record the processing time and processing order, and the determing process is finished. 
timeTable =cell(size(cTable));  %this time table is for draw the gantt chart

for col = 1: size(cTable,2)
  for row = 1: size(cTable,1)
      while( isempty(timeTable{row,col}) )
         if(cTable{row,1}(2) == 1)  %col == 1
             timeTable{row,1}= struct('start',0, 'end',cTable{row,1}(1),'job_no',jobDealOrder(row,1) );
         elseif( cTable{row,col}(2) == 1 )             
                timeTable{row,col}= struct('start',0, 'end',cTable{row,col}(1),'job_no',jobDealOrder(row,col) );
         end
      end
  end
end

%c(1,1)=jobInfo(2,Va(1) );




% 
% for k=2:size(jobInfo,1)-2
%    c(1,k)=c(1,k-1)+jobInfo(k+1,Va(1));
% end
% 
% for ix=2:size(jobInfo,2)
%   c(ix,1)=c(ix-1,1)+jobInfo(2,Va(ix));
% end
% 
% 
% for ix=2:size(jobInfo,2)
%    for k=2:size(jobInfo,1)-1
%      c(ix,k)=max( c(ix-1,k),c(ix,k-1) )+jobInfo(k+1,Va(ix));
%    end   
% end
% 
% timeLength=c( size(jobInfo,2) ,size(jobInfo,1)-1 );