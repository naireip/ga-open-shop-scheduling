%Procedure: Order-Based Crossover


function [newVa,newVb]=orderBasedOX(Va,Vb)

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
% Step2. The order of cities in the selected position in 1st parent is imposed on the corresponding 
%        cities in the other
% I say: find those position and fill them into the corresponding positions(to 2nd parent) of the proto-child
%        and fill the other empty position of proto-child with the 2nd other positions
protoChild=zeros(1,length(Va));
temp=Va(posSet);
for k=1:length(temp)
   [i,j]=find(Vb==temp(k)); 
   temp_j(k)=j;
end
temp_j=sort(temp_j);
protoChild(temp_j)=temp ;
L=setdiff([1:length(Va)],temp_j) ;
protoChild(L)=Vb(L);

%fprintf('The 1st offspring')
offspring1=protoChild;
newVa=offspring1;
%=========================================================================================
%For easily understanding, we do not write another subfunction, just do the step2 again here.
%--------------------------------------------------------------------------------
% Step2. The order of cities in the selected position in 1st parent is imposed on the corresponding 
%        cities in the other
% I say: find those position and fill them into the corresponding positions(to 2nd parent) of the proto-child
%        and fill the other empty position of proto-child with the 2nd other positions
protoChild=zeros(1,length(Vb));
temp=Vb(posSet);
for k=1:length(temp)
   [i,j]=find(Va==temp(k)) ;
   temp_j(k)=j;
end
temp_j=sort(temp_j);
protoChild(temp_j)=temp ;
L=setdiff([1:length(Vb)],temp_j) ;
protoChild(L)=Va(L);

%fprintf('The 2st offspring')
offspring2=protoChild;
newVb=offspring2;
