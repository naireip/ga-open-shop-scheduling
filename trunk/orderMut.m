%orderMut: order mutation for one chromosome
%Randomly select two points and change the to point's gene
%For example: 1234 -> 1432   pos=(2,4)
%For example: 1234 -> 3214   pos=(1,3)
function newVa=orderMut(Va)

%fprintf('original Va is:\n')
Va= [  8   7   4   2   6   5   1   9   3  10 ]
original_Va=Va;
Ranpoint=[]; %initialize Ranpoint

while(length(Ranpoint)<2)
   Ranpoint=sort(mod(floor(randn(1,2)*10),length(Va))+1);
end
   tempPtValue = Va(Ranpoint(1));
%   Ranpoint
  
   Va(Ranpoint(1)) = Va(Ranpoint(2));
   Va(Ranpoint(2)) = tempPtValue;

%fprintf('After random mutation, Va is:\n')
newVa = Va;
return