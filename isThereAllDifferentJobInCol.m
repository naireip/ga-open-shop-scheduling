function  answer = isThereAllDifferentJobInCol(tempTable,col)
global numOfMach
global numOfJob
col
theColumnWeConsidered=[];
for rx = 1: numOfMach
   theColumnWeConsidered(rx) = tempTable(rx,col).jobName
end

if length(unique(theColumnWeConsidered)) < length(theColumnWeConsidered)
    answer = 0;
else
    answer = 1;
end
return 