function newVa=GAMut(Va)

global swMutation

switch(swMutation)
case 1,  newVa=randExMut(Va); 
     %' randExMut '   
case 2,  newVa=ShiftMut(Va);
   %,'ShiftMut' 
       
end   