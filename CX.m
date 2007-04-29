% CX means Olives, Smith, and Hollands' Cycle Crossover(CX)
% Procedure :CX
% Step1. Find the cycle which is defined by the corresponding positions of cities between parents
% Step2. Copy the cities in the cycle to a child with the corresponding positions of one parent.
% Step3. Determine the remaining cities for the child by deleting those cities which are already 
%        in the cycle from the other parent.
% Step4. Fulfill the child with the remaining cities.

function CX%(Va,Vb)
Va=1:9
Vb=[5 4 6 9 2 3 7 8 1]

%--------------------------------------------------------------------------------
% Step1. Find the cycle which is defined by the corresponding positions of cities between parents

for ix=1:length(Va)
    rawMapRelation(ix,1:2)=[Va(ix),Vb(ix)];
 end  
 
rawMapRelation

rowIndex=1;
colIndex=1;


tMap=[rawMapRelation;fliplr(rawMapRelation)]
Map=tMap'
