function [timeLength,c]=makespan(Va)
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

A (find(mod(A,numOfMach) ==0 ) )= numOfMach;
jobDealOrder = A
cTable = zeros(numOfMach, numOfJob);
%till now the order is distribute into the matrix

%Next, following the jobDealOrder , we will decide which job should be process first
%while in the same order, shortest processing time first

for ix = 1: numOfMach
    
        if ( length(unique(jobDealOrder(:,ix))) < numOfJob)  %mean there has the same jobOrder
           jobDealOrder(:,ix)
          % uniqueRows = unique(jobDealOrder(:,ix)) %find out row of the same value  in Col ix              
               [N,Bin] = histc(jobDealOrder(:,ix),1:max(jobDealOrder(:,ix)) );  %find out the larger multiple parts
               N
               % find out 1's ,then scheule it
               [cndIx] = find(N>0) %canNotDetermineNow 
               shouldBeScheduleNow = setdiff(1:numOfMach, cndIx )
               for nx = 1: length(shouldBeScheduleNow)
                   cTable(shouldBeScheduleNow,ix) = pureJobInfo(shouldBeScheduleNow, ix) 
               end
               multipart = find ( (N >1) >0 ) ;  %which numbers are multiple
               for mx = 1: length(multipart) 
                    multipartIdx{mx} = find(jobDealOrder(:,ix) == multipart(mx))
                    for kx = 1: length(multipart) 
                       needToCompareGroup{ix,kx} = min(pureJobInfo(ix, multipartIdx{mx} )  )
                    end
                    
               end
        else  % job order can be determined immediately
            tmpProcTime = pureJobInfo(:,ix);            
            cTable(:,ix) = tmpProcTime(jobDealOrder(:,ix)) 
        end
end



c(1,1)=jobInfo(2,Va(1) );





for k=2:size(jobInfo,1)-2
   c(1,k)=c(1,k-1)+jobInfo(k+1,Va(1));
end

for ix=2:size(jobInfo,2)
  c(ix,1)=c(ix-1,1)+jobInfo(2,Va(ix));
end


for ix=2:size(jobInfo,2)
   for k=2:size(jobInfo,1)-1
     c(ix,k)=max( c(ix-1,k),c(ix,k-1) )+jobInfo(k+1,Va(ix));
   end   
end

timeLength=c( size(jobInfo,2) ,size(jobInfo,1)-1 );