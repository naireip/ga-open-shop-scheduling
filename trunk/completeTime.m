function  [maxTimeLength, timeTable] = completeTime(Va)
global jobInfo
global c
global numOfMach
global numOfJob
global timeTable
global jobDealOrder
%load jobInfo.txt
pureJobInfo = jobInfo(2:end-1,:)
jobWeight = jobInfo(end, :);
% Va = [5 2 3 4 6 7 8 9 1]; %max=39
%Va =[ 9 8 4 5 6 7 1 2 3]
%Va =[ 8 9 7 1 4 3 2 5 6]
%Va =[ 1 8 9 3 7 2 6 5 4]
%Va =[ 3 5 8 7 9 2 1 4 6]
%Va = [5,2,4,3,8,6,1,7,9]
%Va =[8,6,9,1,3,5,2,7,4]  %max=39
%Va=[ 5 8 2 4 7 1 6 9 3]   %max=70
save Va
%numOfMach =3
%numOfJob = 3
% Machine deal order
numOfMach 
numOfJob 


tmpReshape =reshape(Va, numOfMach, numOfJob)'
jobDealOrder = zeros(numOfJob, numOfMach);

for ix =1 : numOfMach    
    for jx = 1: length(Va)
       if ( Va(jx) <= length(Va)/numOfMach * ix   & Va(jx) >  length(Va)/numOfMach * (ix-1) )
           if (sum(jobDealOrder(ix, :)) == 0 ) % jobDealOrder IS EMPTY
               jobDealOrder(ix, 1) =  Va(jx);
           else               
               jobDealOrder(ix, sum(jobDealOrder(ix,:)~= 0)+1 ) =  Va(jx);
           end
       end 
    end
end
A = mod(jobDealOrder,numOfMach)

A (find(mod(A,numOfMach) ==0 ) )= numOfMach
jobDealOrder = A
clear A c tmpReshape
cTable = cell(numOfMach, numOfJob);  %by using cTable to determine the processing order of the same job (multiple groups)
%till now the order is distribute into the matrix
timeTable = cell(numOfMach, numOfJob); 
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
                 %  timeTable{shouldBeShceduleNowIndex(nx),ix} = struct('start',0,'end',pureJobInfo(shouldBeShceduleNowIndex(nx),shouldBeScheduleNow(nx)), 'job_no',shouldBeShceduleNowIndex(nx))
               end
               directOrderList =1:length(N);
               multipart = directOrderList(find ( (N >1) >0 ))   %which job numbers are multiple, can not be determine the order now
               for mx = 1: length(multipart) 
                   jobDealOrder(multipart(mx))
                   multipart(mx)
%                    multipartIdx{mx} = find(jobDealOrder(:,ix) == jobDealOrder(multipart(mx),ix))
                     multipartIdx{mx} = find(jobDealOrder(:,ix) == multipart(mx))
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
                   unique(jobDealOrder(emptyCellIndex,ix))
                     original_compareArray = pureJobInfo(:, unique(jobDealOrder(emptyCellIndex,ix)))
                   while(emptyCellCnt > 0 )  % while there  still some one is not deternined order
                       %find out the empty index and use the empty ones to find out the min to scheduling first                     
                      compareArray = pureJobInfo(emptyCellIndex, unique(jobDealOrder(emptyCellIndex,ix)))
                      multipartIdx{1}
                      find(original_compareArray == min(compareArray ) )
                       
                       for gx = 1: length(original_compareArray)
                           if (original_compareArray(gx) == min(compareArray) )
                                  scheduleFirstIndex  = gx;
                           end
                       end
                       
        %               scheduleFirstIndex =  find(original_compareArray == min(compareArray ) ) + multipartIdx{1}(1) -1  %kx denote the group number
                       %   needToCompareGroup{ix,kx} = min(pureJobInfo(ix, multipartIdx{kx} )  )
                        tmp = jobDealOrder(:,ix)
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
timeTable =cell(size(cTable))  %this time table is for draw the gantt chart
toBeDetermineOrderCol = cell(1,1)
toBeDetermineOrderCol=[];


for col =1:size(cTable,2)
    for row =1: size(cTable,1)
        toBeDetermineCol{row} = timeTable{row,col}
        toBeDetermineOrderCol(row) = cTable{row,col}(2)
    end   
        [emptyCnt, maxOrder] = getEmptyCountAndMaxOrder(toBeDetermineCol,toBeDetermineOrderCol)
        %=============
        dealOrder =1;                 
          while (dealOrder <= maxOrder & emptyCnt >0)
              %find out the index
              [idx]=find(toBeDetermineOrderCol == dealOrder)
             gx=[]
              for dx = 1: length(idx)
                  if (isempty(timeTable{idx(dx),col}) && length(idx) > 1 )
                      gx =[gx, idx(dx)]
                  end                  
              end
              if ~isempty(gx)
                 idx =gx
              end

               %find out the smallest time
              minTimeValue = cTable{idx(1),col}(1)
              TempIdx=idx(1)
              for dx =1:length(idx)
                  dx
                  fprintf('the col =%d\n',col)
                  fprintf('the row =%d\n',idx(dx))
                 if (cTable{idx(dx),col}(1) < minTimeValue && isempty(timeTable{idx(dx),col}) )
                     minTimeValue = cTable{idx(dx),col}(1)
                     TempIdx = idx(dx)
                 end                 
              end
               fprintf('the col =%d\n',col)
                  fprintf('the row =%d\n',idx(dx))
              idx = TempIdx
             
              minTimeValue
              
              
              
              
              idx
              sameJob = cell(1,1)
              %find out the max value of same job end time
                for  sameJobJdx =1:col
                     for sameJobIdx = 1:size(cTable,1)
                         if(jobDealOrder(sameJobIdx, sameJobJdx) == jobDealOrder(idx,col))
                             sameJob{length(sameJob)+1} = [sameJobIdx, sameJobJdx]
                         end
                     end
                end
             %=========================================
             %deal the find out             
                maxRowEndTime = getTheMaxRowEndTime(idx,col, sameJob ,cTable)
                maxSameJobEndTimeNow = getTheSameJobEndTimeNow(idx,col, sameJob ,cTable)              
                beginTime = max(maxRowEndTime, maxSameJobEndTimeNow)
                timeTable{idx,col}=struct('start',beginTime, 'end',beginTime + cTable{idx,col}(1),'job_no',jobDealOrder(idx,col) );                                                    
              % if the same order is deal finished dealOrder++, find the min dealOrder now
               dealOrderArray=[]
               for ixx =1:size(cTable,1)
                   if(isempty(timeTable{ixx,col}))
                       if(dealOrder <= toBeDetermineOrderCol(ixx) )
                           dealOrderArray = [dealOrderArray, toBeDetermineOrderCol(ixx)]; 
                       end
                   end
               end
               if (~isempty(dealOrderArray))
                  dealOrder = min(dealOrderArray)
               end
          %================
          for row =1: size(cTable,1)
            toBeDetermineCol{row} = timeTable{row,col}
            toBeDetermineOrderCol(row) = cTable{row,col}(2)
         end
          [emptyCnt, maxOrder] = getEmptyCountAndMaxOrder(toBeDetermineCol,toBeDetermineOrderCol)
        %=============          
        end
end

%================================================

maxTimeLength = timeTable{1,numOfJob}.end
for ix = 1: numOfMach   
    if (timeTable{ix, numOfJob}.end > maxTimeLength)
        maxTimeLength  = timeTable{ix, numOfJob}.end;
    end
end

end