function newVa = InsertionMut(Va)
%Insertion mutation selects a gene at random and inserts it in a random
%position

%fprintf('original Va is:\n')
Va= [  8   7   4   2   6   5   1   9   3  10 ]
original_Va=Va;
randomVal=[]; %initialize randomVal

while(length(randomVal)  <2)
   randomVal=sort(mod(floor(randn(1,2)*10),length(Va))+1);
end
   toBeInsertVal = randomVal(1) ;
   toBeInsetPlace = randomVal(2);
   orignalPlaceOfTheInsertedValue = find(Va == toBeInsertVal)
   Va(orignalPlaceOfTheInsertedValue) = [];   
   tempVa = Va;
   if(orignalPlaceOfTheInsertedValue == 1)       
       Va = [toBeInsertVal, tempVa];
   elseif(orignalPlaceOfTheInsertedValue == length(Va))
       Va = [tempVa, toBeInsertVal];
   else
      tempLeft = Va(1:toBeInsetPlace -1);
      tempRight = Va(toBeInsetPlace:end);
       Va= [tempLeft,  toBeInsertVal, tempRight];
   end
%fprintf('After random mutation, Va is:\n')
newVa = Va;
%length(Va)
return