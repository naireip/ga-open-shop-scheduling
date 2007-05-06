function maxSameJobEndTime = getTheSameJobEndTimeNow(idx,col, sameJob ,cTable)       
global timeTable
global jobDealOrder 

%since sameJobIndex need some deals to delete the first one cell
sameJobDealIndex = 1;
sameJob2 = cell(1,1); %initial the temp cell
if (length(sameJob) ==1)
    sameJob =sameJob{1} ; %sameJob = empty
else
    while( sameJobDealIndex <= length(sameJob)-1 )
         sameJob2{sameJobDealIndex} =  sameJob{sameJobDealIndex+1}
         sameJobDealIndex = sameJobDealIndex +1;
    end
    sameJob = sameJob2;
end
clear sameJob2 sameJobDealIndex
%=============================
% determind the max same Job End time now
maxSameJobEndTime = 0
for ix =1 :length(sameJob)
    rowValue = sameJob{ix}(1)
    colValue =  sameJob{ix}(2)
    if(~isempty(timeTable{rowValue, colValue}) && timeTable{rowValue,colValue}.end > maxSameJobEndTime )
       maxSameJobEndTime = timeTable{rowValue,colValue}.end;
    end    
end
maxSameJobEndTime
return