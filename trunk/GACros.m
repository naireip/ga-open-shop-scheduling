function [newVa,newVb]=GACros(Va,Vb)
global swCrossover

switch(swCrossover)
   
case 1,      [newVa,newVb]=PMX(Va,Vb);
   
        %PMX
case 2,       [newVa,newVb]=OX(Va,Vb);

        %OX, Order Crossover
case 3,
        [newVa,newVb]=CyclicXover(Va,Vb);

      %CX 
case 4,       [newVa,newVb]=PosBasedOX(Va,Vb);

   %PosBasedOX

case 5,      [newVa,newVb]=orderBasedOX(Va,Vb);

   %'OrderBasedOX
case 6,   
         [newVa,newVb]=SubTourOX(Va,Vb);
    %subtour crossover     
case 7,
         [newVa,newVb] = HeuristicOX(Va,Vb);
   % heuristc crossover
end   

     

