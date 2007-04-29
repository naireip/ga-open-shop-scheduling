% PMX means Goldberg's Partially Mapped CroSsover)
% Procedure :PMX
% Step1. Select two positions along the string uniformly at random.
%        The substrings defined by the two positions are called the mapping sections.
%        Note:(You can write to select a start point and a length) 
% Step2. Exchange two substrings between parents to produce proto-children.
% Step3. Determine the mapping relationship between two mapping section.
% Step4. Legalize offspring with the mapping relationship.

function [newVa,newVb]=PMX(Va,Vb)
fprintf('original Va and Vb are:\n')
%Va= [ 1 6 10 3  9 4 5 2 7 8 ]
%Vb= [ 2 9  1 4 10 5 6 8 3 7 ]

%Va=1:9
%Vb=[5 4 6 9 2 1 7 8 3]

%--------------------------------------------------------------------------------
%Step1. Select two positions along the string uniformly at random.
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
fprintf('\n The (startXorPoint,endXorPoint)=(%d,%d)\n',startXorPoint,endXorPoint)
%startXorPoint=3
%endXorPoint=6

%--------------------------------------------------------------------------------
% Step2. Exchange two substrings between parents to produce proto-children.
temp1=Va(startXorPoint:endXorPoint);
temp2=Vb(startXorPoint:endXorPoint);
Va(startXorPoint:endXorPoint)=temp2;
Vb(startXorPoint:endXorPoint)=temp1;
clear temp1;
clear temp2;
fprintf('The exchanged Va and Vb are:\n')
Va
Vb

%--------------------------------------------------------------------------------
% Step3. Determine the mapping relationship between two mapping section.
temp1=Va(startXorPoint:endXorPoint);
temp2=Vb(startXorPoint:endXorPoint);

for ix=1:length(temp1)
    rawMapRelation(ix,1:2)=[Va(startXorPoint+ix-1),Vb(startXorPoint+ix-1)];
 end  
rawMapRelation
%rawMapRelation=[6 3;9 4;2 5;1 6;3 7]

rowIndex=1;
colIndex=1;

while( rowIndex<=size(rawMapRelation,1) )
   while( colIndex<=size(rawMapRelation,2) )
      rawMapRelation(rowIndex,colIndex ) 
      [i,j]=find(rawMapRelation==rawMapRelation(rowIndex,colIndex ) )  ; 
          if(length(i)>1)
              if( j(1)<j(2) )
                 tempResult=[rawMapRelation(i(2),:), rawMapRelation(i(1),:)];
                   k=1
                    while k<length(tempResult)
                          if tempResult(1,k)==tempResult(1,k+1)
                          tempResult(k:k+1)=[];
                          end   
                    k=k+1;
                    end
                   tempResult         
                  rawMapRelation(i,:)=[];
                  rawMapRelation(size(rawMapRelation,1)+1,1:2)=tempResult;                  
                  
              else 
                  tempResult=[rawMapRelation(i(1),:), rawMapRelation(i(2),:)];
                   k=1
                    while k<length(tempResult)
                          if tempResult(1,k)==tempResult(1,k+1)
                          tempResult(k:k+1)=[];
                          end   
                    k=k+1;
                    end
                   tempResult         
                  rawMapRelation(i,:)=[];
                  rawMapRelation(size(rawMapRelation,1)+1,1:2)=tempResult;  
       
              end
           end   
          if(length(i)==1 & length(j)==1) 
             colIndex=colIndex+1;
          else
             rowIndex=1
             colIndex=1;
          end   
   end 
      rowIndex=rowIndex+1;
   end   
      colIndex=1;%Reset
end   

rawMapRelation

tMap=[rawMapRelation;fliplr(rawMapRelation)]
Map=tMap'
fprintf('\n The (startXorPoint,endXorPoint)=(%d,%d)\n',startXorPoint,endXorPoint)

Va
Vb
%--------------------------------------------------------------------------------
% Step4. Legalize offspring with the mapping relationship.
if startXorPoint~=1
   for i=1:startXorPoint-1      
      [r,c]=find(Map(1,:)==Va(1,i)) ;  
      if ~isempty(r) & ~isempty(c)
         Va(1,i)=Map(r+1,c);
      end   
      [r1,c1]=find(Map(1,:)==Vb(1,i));   
      if ~isempty(r1) & ~isempty(c1)
         Vb(1,i)=Map(r1+1,c1);
      end   
   end
end

if endXorPoint~=length(Va)
   for i=endXorPoint+1:length(Va)
      [r,c]=find(Map(1,:)==Va(1,i));   
      if ~isempty(r) & ~isempty(c)
         Va(1,i)=Map(r+1,c);
      end   
      [r1,c1]=find(Map(1,:)==Vb(1,i)) ;  
      if ~isempty(r1) & ~isempty(c1)
         Vb(1,i)=Map(r1+1,c1);
      end   
   end   
end   
fprintf('The final Va and Vb are:\n')
newVa=Va
newVb=Vb

