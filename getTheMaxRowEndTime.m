function maxRowEndTime = getTheMaxRowEndTime(idx,col, sameJob,cTable)
global timeTable
global jobDealOrder  

% maxRowEndTime denote the end time of previous element in the same row
for cx = 1: col
    for rx =1 : idx
        if col == 1
            maxRowEndTime = 0;
        else
            maxRowEndTime = timeTable{idx,col-1}.end;           
        end
    end
end

%maxRowEndTime
return