%find out the statistics of genetic algorithms
%and draw the bar chart or pie chart

%The statistics are:
%1. the 1st generation # that appear the optimal solution
%2. The optimal solution ratio
%3. The average CPU time
%4.
function GAT_stat()


global Pm
global Pc        %probability of crossover
global real_chromosome
global everyGenResult
global boundGen  %限制的世代數範圍，或說要考慮的世代數範圍
global numOfGen
global pop_size
global TotalGen
global swDynaGraph
global NowGen
global Run
global EachRunResult
global EachRunResult
global EachRunChr
global elapsedTime

for ix=1:size(everyGenResult,1)
   temp1(ix)=makespan(everyGenResult{ix,1}(1,:) );
end 
firstOptGen=find(temp1==min(temp1));
firstOptGen=min(firstOptGen);
EachRunResult(Run,1)=firstOptGen;
EachRunResult(Run,2)=min(temp1);
EachRunResult(Run,3)=elapsedTime;


%EachRunChr{Run,1}=chromosome
EachRunChr{Run}=chromosome;






chromosome=[];
everyGenResult=[];
ObjChromosome=[];

