function gaProblemgen()
global numOfMach
global numOfJob


prompt={'How many machines in problem?',' How many jobs?','If the job''s process time is integer uniform distribution between [a,b] , a = ?','b = ?', ...
        'If the job''s weight is integer uniform distribution between [c,d], c = ?','d = ?'};

def={'10','10','1','10','1','10' };    % def specifies the default value to display for each prompt.
 dlgTitle=['Problem Generator'];
   lineNo=1;
   answer=inputdlg(prompt,dlgTitle,lineNo,def);
   AddOpts.Resize='on';
   AddOpts.WindowStyle='normal';
   AddOpts.Interpreter='tex';  
   
   numOfMach=str2num(answer{1});
   numOfJob=str2num(answer{2});
   distLHS=str2num(answer{3});
   distRHS=str2num(answer{4});
   distWeightLHS=str2num(answer{5});
   distWeightRHS=str2num(answer{6});
   
   Problem=ones(numOfMach+2,numOfJob);
   
   for ix=2:size(Problem, 1) -1  %the last row is weight
      for jx=1:size(Problem,2)
         tempVal=mod(abs(ceil(randn(1)*10)),distRHS+1)+distLHS-1;
         if tempVal~=distLHS-1
            Problem(ix,jx)=tempVal;
         else 
            Problem(ix,jx)=tempVal+1;
         end   
      end   
   end

   for ix=size(Problem, 1) :size(Problem, 1)   %determine the last row, which is weight
      for jx=1:size(Problem,2)
         tempVal=mod(abs(ceil(randn(1)*10)),distWeightRHS+1)+distWeightLHS-1;
         if tempVal > distWeightLHS-1
            Problem(ix,jx)=tempVal;
         else 
            Problem(ix,jx)=tempVal+1;
         end   
      end   
   end   


   Problem(1,:)=[1:numOfJob];
   Problem
   save Problem
  