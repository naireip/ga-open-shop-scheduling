function [ch1,ch2] = partmapXover(par1,par2)
% Partmap crossover takes two parents par1,par2 and performs a partially
% mapped crossover.  
%
% function [c1,c2] = partmapXover(p1,p2,bounds,Ops)
% p1      - the first parent ( [solution string function value] )
% p2      - the second parent ( [solution string function value] )

% Step 1. Select two positions alogn the string uniformly at random. The
%substrings defined by the two positions are called the mapping sections.
% Step 2. Exchange two substrings between parents to produce proto-children.
% Step 3. Determine the mapping relationship between two mapping sections.
% Step 4. Legalize offspring with the mapping relationship.

sz = size(par1,2)-1;
pos1 = round(rand*sz + 0.5);
pos2 = round(rand*sz + 0.5);
while pos2 == pos1
   pos2 = round(rand*sz + 0.5);
end
if pos1 > pos2
   t = pos1; pos1 = pos2; pos2 = t;
end    
ss1 = par1(pos1:pos2); ss2 = par2(pos1:pos2);
ch1 = par2; ch2 = par1;
for i = [1:pos1-1 pos2+1:sz]
   ch1(i) = par1(i);
   j = find(ch1(i) == ss2);
   while ~isempty(j)
      ch1(i) = ss1(j);
      j = find(ch1(i) == ss2);
   end
   ch2(i) = par2(i);
   j = find(ch2(i) == ss1);
   while ~isempty(j)
      ch2(i) = ss2(j);
      j = find(ch2(i) == ss1);
   end
end
