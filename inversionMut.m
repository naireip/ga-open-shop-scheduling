function newVa = inversionMut(Va)
%Inverstion mutation selects two positions within a chrosome at random and
%then inverts the substring between there two positions.

%fprintf('original Va is:\n')
%Va= [  8   7   4   2   6   5   1   9   3  10 ]
original_Va=Va;
RandomPoints=[0 , 0]; %initialize Ranpoint

while(RandomPoints(1) == RandomPoints(2))
   temp =mod(floor(abs(randn(1,2)*10)),length(Va));
   temp(find(temp == 0)) =length(Va);
   RandomPoints = sort(temp);
end
   RandomPoints
   toBeInversed =   Va( RandomPoints(1):RandomPoints(2))  ;
   Va( RandomPoints(1):RandomPoints(2))   = fliplr(toBeInversed);

%fprintf('After random mutation, Va is:\n')
newVa = Va
return