function    [newVa,newVb] = SubTourOX(Va,Vb)
%try to find the max common and flip the order
A = [];
B = [];
randStartPt = mod(floor(rand*length(Va)), length(Va))+1


idx = find(Vb == Va(randStartPt))
cLen = min( length(Vb)-idx+1, length(Va) - randStartPt+1)

maxSameCnt = length(intersect( Va(randStartPt:end), Vb(idx:end)  ))

loopCnt = 0
while( maxSameCnt > 1 && loopCnt <= length(Va))
    A = Va(randStartPt: randStartPt + maxSameCnt -1 )
    B = Vb(idx: idx + maxSameCnt -1 )
    if(length(intersect(A,B)) == maxSameCnt)
       Vb(idx: idx + maxSameCnt -1 ) = A;
        Va(randStartPt: randStartPt + maxSameCnt -1 ) =fliplr(B)
    else
        maxSameCnt =  maxSameCnt -1; 
    end
    loopCnt = loopCnt+1;
end
newVa = Va
newVb = Vb
return
