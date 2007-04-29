%shiftMut: shift mutation for one chromosome
%Randomly select two points and insert the righter one to the left and shift others to the right side
%For example: 1234 -> 1423  pos=(2,4)
%For example: 1234 -> 3124   pos=(1,3)
function newVa=shiftMut(Va)

%fprintf('original Va is:\n')
%Va= [  8   7   4   2   6   5   1   9   3  10 ];
original_Va=Va;

Ranpoint=[]; %initialize Ranpoint

while(length(Ranpoint)<2)
Ranpoint=sort(mod(floor(randn(1,2)*10),length(Va))+1);
end

if Ranpoint(1)~=1 
   tempVa=[Va(1:Ranpoint(1)-1),Va(Ranpoint(2)),Va(Ranpoint(1) : Ranpoint(2)-1 ), Va(Ranpoint(2)+1 :length(Va) ) ];
else 
   tempVa=[Va(Ranpoint(2)),Va(Ranpoint(1) : Ranpoint(2)-1 ), Va(Ranpoint(2)+1 :length(Va) ) ];
end   
%fprintf('After random mutation, Va is:\n')
%Va=tempVa;
newVa=tempVa;