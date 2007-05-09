function newVa=GAMut(Va)

global swMutation

switch(swMutation)
    case 1,  newVa=randExMut(Va); 
     %' randExMut '   
    case 2,  newVa=ShiftMut(Va);
      %,'ShiftMut' 
    case 3, newVa = orderMut(Va);
      %order mutation
    case 4, newVa = inversionMut(Va);
      %inversion mutation     
    case 5, newVa = InsertionMut(Va)
        % insertion mutation
end   