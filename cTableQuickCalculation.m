function cTable2 = cTableQuickCalculation()
global jobInfo
global numOfMach
global cTable
global numOfJob
global timeTable
global jobDealOrder
global cTable

pureJobInfo = jobInfo(2:end-1,:)
%initialize the necessary information

for rx = 1: numOfMach
    for cx = 1: numOfJob   
      tempTable(rx,cx)= struct('jobName',jobDealOrder(rx,cx),'procTime',pureJobInfo(rx,jobDealOrder(rx,cx)));
    end
end

cTable2 = cell(numOfMach, numOfJob);
%determined the processing order
for cx = 1: numOfJob
         boolAllDiffInCol = isThereAllDifferentJobInCol(tempTable,cx);         
          for R =1: numOfMach
             beComparedVal(R) = pureJobInfo(R, jobDealOrder(R,cx));
          end

    if (boolAllDiffInCol == 1)
        for rx =1: numOfMach           
            cTable2{rx,cx}=[tempTable(rx,cx).procTime, 1 ];
        end
    else  %there are same job name in col cx
         for job = 1: numOfJob
             sameJobIndex = find(jobDealOrder(:,cx) == job) 
             [orderVal, orderIdx] =sort(beComparedVal(sameJobIndex) );
             for sx =1 : length(sameJobIndex)
                 cTable2{sameJobIndex(sx),cx}=[tempTable(sameJobIndex(sx),cx).procTime, find(orderVal==tempTable(sameJobIndex(sx),cx).procTime)];
             end
         end   
    end
end

