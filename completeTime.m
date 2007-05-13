function  [weightedCompleteTime, timeTable] = completeTime(Va)
global jobInfo
global cTable
global numOfMach
global numOfJob
global timeTable
global jobDealOrder
%load jobInfo.txt
%load Va
% jobInfo =[1 2 3 4 5;1 2 3 4 5;6 7 8 9 10;11 12 13 14 15;16 17 18 19 20;21 22 23 24 25;2 1 5 3 4]
%jobInfo =[1 2 3 4 5;1 20 18 21 6;10 2 25 7 12;14 17 3 16 15;13 8 24 4 11; 9 22 19 23 5; 2 1 5 3 4]
%Va = [  24     8    21    25    15     2    22    16    19    10     7     4     3    11    14     6    12    23     9    5    20    18    13    17     1]
%  

% jobInfo =[1 2 3;1 20 18; 10 2 25; 14 17 3; 13 8 24; 9 22 19; 6 8 7; 2 1 3]
% Va =[8 15 2 16 10 7 4 3 11 14 6 12 9 5 18 13 17 1]
pureJobInfo = jobInfo(2:end-1,:);
jobWeight = jobInfo(end, :);
%Va = [5 2 3 4 6 7 8 9 1]; %max=44
%Va =[ 9 8 4 5 6 7 1 2 3] %51
%Va =[ 8 9 7 1 4 3 2 5 6]
%Va =[ 1 8 9 3 7 2 6 5 4]
%Va =[ 3 5 8 7 9 2 1 4 6]
%Va = [5,2,4,3,8,6,1,7,9]
%Va =[5 2 3 4 6 7 8 9 1]
%Va =[8,6,9,1,3,5,2,7,4]  %max=39
%Va=[ 5 8 2 4 7 1 6 9 3]   %max=70
%save Va
%  numOfMach =6
%  numOfJob = 3
% Machine deal order
% numOfMach 
% numOfJob 

%length(Va)
tmpReshape =reshape(Va, numOfJob, numOfMach)';
jobDealOrder = zeros(numOfMach, numOfJob);

for ix =1 : numOfMach    
    for jx = 1: length(Va)
       if ( Va(jx) <= length(Va)/numOfMach * ix   & Va(jx) >  length(Va)/numOfMach * (ix-1) )
           if (sum(jobDealOrder(ix, :)) == 0 ) % jobDealOrder IS EMPTY
               %ix
               jobDealOrder(ix, 1) =  Va(jx);
           else               
               jobDealOrder(ix, sum(jobDealOrder(ix,:)~= 0)+1 ) =  Va(jx);
           end
       end 
    end
end
A = mod(jobDealOrder,numOfJob);

A (find(mod(A,numOfJob) ==0 ) )= numOfJob;
jobDealOrder = A;
clear A c tmpReshape 

cTable = cell(numOfMach, numOfJob);  %by using cTable to determine the processing order of the same job (multiple groups)
%till now the order is distribute into the matrix
timeTable = cell(numOfMach, numOfJob); 
%Next, following the jobDealOrder , we will decide which job should be process first
%while in the same order, shortest processing time first

 cTable = cTableQuickCalculation;   %the other quick method  to calculate 
% Till now, we use cTable to record the processing time and processing order, and the determing process is finished. 
timeTable =cell(size(cTable))  ;%this time table is for draw the gantt chart
toBeDetermineOrderCol = cell(1,1);
toBeDetermineOrderCol=[];



for col =1:size(cTable,2)
    for row =1: size(cTable,1)
        toBeDetermineCol{row} = timeTable{row,col};
        toBeDetermineOrderCol(row) = cTable{row,col}(2);
    end   
        [emptyCnt, maxOrder] = getEmptyCountAndMaxOrder(toBeDetermineCol,toBeDetermineOrderCol);
        %=============
        dealOrder =1;                 
          while (dealOrder <= maxOrder & emptyCnt >0)
              %find out the index
              [idx]=find(toBeDetermineOrderCol == dealOrder);
             gx=[];
              for dx = 1: length(idx)
                  if (isempty(timeTable{idx(dx),col}) && length(idx) > 1 )
                      gx =[gx, idx(dx)];
                  end                  
              end
              if ~isempty(gx)
                 idx =gx;
              end

               %find out the smallest time
              minTimeValue = cTable{idx(1),col}(1);
              TempIdx=idx(1);
              for dx =1:length(idx)
                 % dx;
                 % fprintf('the col =%d\n',col);
                 % fprintf('the row =%d\n',idx(dx));
                 if (cTable{idx(dx),col}(1) < minTimeValue && isempty(timeTable{idx(dx),col}) )
                     minTimeValue = cTable{idx(dx),col}(1);
                     TempIdx = idx(dx);
                 end                 
              end
%                fprintf('the col =%d\n',col)
%                   fprintf('the row =%d\n',idx(dx))
              idx = TempIdx;         
              sameJob = cell(1,1);
              %find out the max value of same job end time
                for  sameJobJdx =1:col
                     for sameJobIdx = 1:size(cTable,1)
                         if(jobDealOrder(sameJobIdx, sameJobJdx) == jobDealOrder(idx,col))
                             sameJob{length(sameJob)+1} = [sameJobIdx, sameJobJdx];
                         end
                     end
                end
             %=========================================
             %deal the find out             
                maxRowEndTime = getTheMaxRowEndTime(idx,col, sameJob ,cTable);
                maxSameJobEndTimeNow = getTheSameJobEndTimeNow(idx,col, sameJob ,cTable)              ;
                beginTime = max(maxRowEndTime, maxSameJobEndTimeNow);
                timeTable{idx,col}=struct('start',beginTime, 'end',beginTime + cTable{idx,col}(1),'job_no',jobDealOrder(idx,col) );                                                    
              % if the same order is deal finished dealOrder++, find the min dealOrder now
               dealOrderArray=[];
               for ixx =1:size(cTable,1)
                   if(isempty(timeTable{ixx,col}))
                       if(dealOrder <= toBeDetermineOrderCol(ixx) )
                           dealOrderArray = [dealOrderArray, toBeDetermineOrderCol(ixx)]; 
                       end
                   end
               end
               if (~isempty(dealOrderArray))
                  dealOrder = min(dealOrderArray);
               end
          %================
          for row =1: size(cTable,1)
            toBeDetermineCol{row} = timeTable{row,col};
            toBeDetermineOrderCol(row) = cTable{row,col}(2);
         end
          [emptyCnt, maxOrder] = getEmptyCountAndMaxOrder(toBeDetermineCol,toBeDetermineOrderCol);
        %=============          
        end
end

% ­pºâweighted complete time
completeTime = zeros(1,numOfJob);
%================================================
for ix =1: numOfJob
    for jx = numOfMach:-1:1
        for kx = numOfJob:-1:1
            if (timeTable{jx, kx}.job_no == ix && timeTable{jx,kx}.end > completeTime(ix))
                completeTime(ix) = timeTable{jx,kx}.end;
            end
        end
    end
end
completeTime =completeTime(find(completeTime ~=0));

weightedCompleteTime = sum(completeTime.*jobWeight);

%=============================================

maxTimeLength = timeTable{1,numOfJob}.end;
for ix = 1: numOfMach   
    if (timeTable{ix, numOfJob}.end > maxTimeLength)
        maxTimeLength  = timeTable{ix, numOfJob}.end;
    end
end
maxTimeLength;
%drawGanttChart2007
end