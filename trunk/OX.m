%OX represent Davis's Order Crossover
%OX was proposed by Davis. It can be viewed as a kind of variation of PMX with a different repairing procedure. 
%OX works as follows:
%
%Procedure: OX
%Step 1. Select a substring from one parent at random
%Step 2. Produce a proto-child by copying the substring into the corresponding position of it
%Step 3. Delete the cities which are already in the substring from the second parent. The resulted sequence of
%        cities contains the cities that the proto-child needs.
%Step 4. Place the cities into the unfixed positions of the proto-child from left to right according to the
%        order of the sequence to produce an offspring.

function [newVa,newVb]=OX(Va,Vb)
%function OX%(Va,Vb)

%Va=1:9
%Vb=[5 7 4 9 1 3 6 2 8]

%Va= [  8   7   4   2   6   5   1   9   3  10 ]
%Vb= [  8   3   6  10   2   7   4   5   1   9 ]

%--------------------------------------------------------------------------------
%Step1. Select a substring from one parent at random
startXorPoint=mod(ceil(rand(1)*10),length(Va) );
if startXorPoint==0
   startXorPoint=startXorPoint+1;
end   
xorLength=mod(floor(rand(1)*10),length(Va));
endXorPoint=startXorPoint+xorLength;
while(endXorPoint>length(Vb) )
   xorLength=mod(floor(rand(1)*10),length(Va));
   endXorPoint=startXorPoint+xorLength;
end   

%startXorPoint=3
%endXorPoint=6

%fprintf('\n The (startXorPoint,endXorPoint)=(%d,%d)\n',startXorPoint,endXorPoint)
for randParent=1:2
   if randParent==1
      firstParent=Va;
      subString=Va(startXorPoint:endXorPoint);
      %------------------------------------------
%  fprintf('\n The substring is ')
subString;
%fprintf('\n from parent') 
firstParent;

%--------------------------------------------------------------------------------
%Step 2. Produce a proto-child by copying the substring into the corresponding position of it
protoChild=zeros(1,length(Va) );
protoChild(startXorPoint:endXorPoint)=subString;

%--------------------------------------------------------------------------------
%Step 3. Delete the cities which are already in the substring from the second parent. The resulted sequence of
%        cities contains the cities that the proto-child needs.
if randParent==1
   secondParent=Vb;
   for k=1:length(subString)
       [i,j]=find(secondParent==subString(k));
       secondParent(j)=[];
   end
else
   secondParent=Va;
   for k=1:length(subString)
       [i,j]=find(secondParent==subString(k));
       secondParent(j)=[];
   end
end 
secondParent;
%--------------------------------------------------------------------------------
%Step 4. Place the cities into the unfixed positions of the proto-child from left to right according to the
%        order of the sequence to produce an offspring.

if startXorPoint~=1
   protoChild(1:startXorPoint-1)=secondParent(1:startXorPoint-1);
end   

if endXorPoint~=length(Va)
   protoChild(endXorPoint+1:length(Va))=secondParent(startXorPoint:length(secondParent)) ;  
end   
offspring=protoChild;
newVa=offspring;
      %------------------------------------------
   else
      firstParent=Vb;
      subString=Vb(startXorPoint:endXorPoint);
      %-------------------------------------------
%fprintf('\n The substring is ')
subString;
%fprintf('\n from parent') 
firstParent;

%--------------------------------------------------------------------------------
%Step 2. Produce a proto-child by copying the substring into the corresponding position of it
protoChild=zeros(1,length(Va) );
protoChild(startXorPoint:endXorPoint)=subString;

%--------------------------------------------------------------------------------
%Step 3. Delete the cities which are already in the substring from the second parent. The resulted sequence of
%        cities contains the cities that the proto-child needs.
if randParent==1
   secondParent=Vb;
   for k=1:length(subString)
       [i,j]=find(secondParent==subString(k));
       secondParent(j)=[];
   end
else
   secondParent=Va;
   for k=1:length(subString)
       [i,j]=find(secondParent==subString(k));
       secondParent(j)=[];
   end
end 
secondParent;
%--------------------------------------------------------------------------------
%Step 4. Place the cities into the unfixed positions of the proto-child from left to right according to the
%        order of the sequence to produce an offspring.

if startXorPoint~=1
   protoChild(1:startXorPoint-1)=secondParent(1:startXorPoint-1);
end   

if endXorPoint~=length(Va)
   protoChild(endXorPoint+1:length(Va))=secondParent(startXorPoint:length(secondParent)) ;  
end   
offspring=protoChild;
newVb=offspring;

      %--------------------------------------------
   end 
end


