%randExMut: random exchange mutation between two points for one chromosome

function newVa=randExMut2(Va)

%fprintf('original Va is:\n')
%Va= [  8   7   4   2   6   5   1   9   3  10 ]
original_Va=Va;

RandPos=sort(mod(floor(randn(1,2)*10),length(Va))+1);
while(length(RandPos) < 2 | RandPos(1)==RandPos(2) )
    RandPos=sort(mod(floor(randn(1,2)*10),length(Va))+1);
end
%RandPos
if RandPos(1) < RandPos(2) 
        changePt(1) = RandPos(1)+1;
        changePt(2) = RandPos(2)-1;       
        newVa = [Va(1: changePt(1) -1 ) ,fliplr( Va(changePt(1):changePt(2))), Va(changePt(2)+1:length(Va)) ]   ;         
end
%fprintf('After random mutation, Va is:\n')

