%Procedure: Position-Based Crossover
% Step1. Select a set of positions from one parent at random
% Step2. Produce a proto-child by copying the cities on these positions into the corresponding positions 
%        of the proto-child
% Step3. Delete the cities which are already selected from the second parent. The resulting sequence of 
%        cities contains the cities the proto-child needs.
% Step4. Place the cities into the unfixed positions of the proto-child from left to right according to
%        the order of the sequence to produce one offspring.


function [newVa,newVb]=PosBasedOX(Va,Vb)
%fprintf('original Va and Vb are:\n')
%Va= [  8   7   4   2   6   5   1   9   3  10 ]
%Vb= [  8   3   6  10   2   7   4   5   1   9 ]

%Va=1:9
%Vb=[5 4 6 3 1 9 2 7 8]
original_Va=Va;
original_Vb=Vb;

%--------------------------------------------------------------------------------
% Step1. Select a set of positions from one parent at random
RandNum=mod(floor(randn(1)*10),length(Va) )+1;
posSet=mod(floor( randn(1,RandNum)*10 ),length(Va) )+1;
posSet=unique(posSet);

%posSet=[2 5 6 9]

%--------------------------------------------------------------------------------
% Step2. Produce a proto-child by copying the cities on these positions into the corresponding positions 
%        of the proto-child
protoChild=zeros(1,length(Va));
protoChild(posSet)=Va(posSet);

% Step3. Delete the cities which are already selected from the second parent. The resulting sequence of 
%        cities contains the cities the proto-child needs.
temp=Va(posSet);
for k=1:length(temp )
    [i,j]=find(Vb==temp(k));
    Vb(j)=[];
end
Vb;


% Step4. Place the cities into the unfixed positions of the proto-child from left to right according to
%        the order of the sequence to produce one offspring.

for i=1:length(protoChild)
   if protoChild(i)==0
      protoChild(i)=Vb(1);
      Vb(1)=[];
   end   
end   
%fprintf('The 1st offspring')
offspring1=protoChild;
newVa=offspring1;

%======================================================================================================
%Let us do Step2 to Step 4 again to generate another chromosome, do not write subfunction for easily understanding

%--------------------------------------------------------------------------------
% Step2. Produce a proto-child by copying the cities on these positions into the corresponding positions 
%        of the proto-child
Va=original_Va;
Vb=original_Vb;

protoChild=zeros(1,length(Vb));
protoChild(posSet)=Vb(posSet);

% Step3. Delete the cities which are already selected from the second parent. The resulting sequence of 
%        cities contains the cities the proto-child needs.
temp=Vb(posSet);
for k=1:length(temp )
    [i,j]=find(Va==temp(k));
    Va(j)=[];
end
Va;


% Step4. Place the cities into the unfixed positions of the proto-child from left to right according to
%        the order of the sequence to produce one offspring.

for i=1:length(protoChild)
   if protoChild(i)==0
      protoChild(i)=Va(1);
      Va(1)=[];
   end   
end   
%fprintf('The 2nd offspring')
offspring2=protoChild;
newVb=offspring2;