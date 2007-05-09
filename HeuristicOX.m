function    [newVa,newVb] = HeuristicOX(Va,Vb)
%try to find the same order continous ones and flip the order

%Va =1:9
%Vb=1:9
A = [];
B = [];
randStartPt = mod(floor(rand*length(Va)), length(Va))+1

idx = find(Vb == Va(randStartPt))
sameContinuousCnt =1;

A = Va(randStartPt: end);
B = Vb(idx: end);

if(length(intersect(A,B)) > sameContinuousCnt)
      Vb = randperm(length(Va))   ;
end

newVa = Vb;
newVb = Va;
return