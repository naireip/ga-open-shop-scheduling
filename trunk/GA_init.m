function GA_init()

global Pm
global Pc
global chromosome
global everyGenResult
global numOfGen    %要跑的總世代數上限
global swCrossover %選擇各種交配的開關
global swMutation    %選擇各種突變的開關
global swDynaGraph
global pop_size
global TotalGen
global scheduMatrix
global jobInfo
global boundGen
global someValue
global numOfMach
global numOfJob

close all
Ans=menu('Do you want to use the random generator?','Yes，I wanna use.','No, just load the file sample is ok.');
if Ans==1
   gaProblemgen
   load Problem
   jobInfo=Problem
else   
   load jobInfo.txt
end


boundGen= numOfGen ;  %目前是設為要跑的總世代數上限
%someValue = 0.001  %判別最佳解是否已經收斂


TotalGen=0;     %到目前為止的總世代數  
chromosome=[];
everyGenResult=[];
NowGen=1; %目前是初代染色體

numOfMach=size(jobInfo,1)-2
numOfJob=size(jobInfo,2)

   %Pm=input('Probability of mutation =?\n')
   %Pc=input('Probability of crossover =?\n')
   %numOfMach=input('How many machine do you have\n')  %這行可能不需要了
   %numOfJob=input('How many jobs do you have ?\n')    %這行可能不需要了
   %numOfGen=input('How many generations you want to run ?\n')
   %pop_size=input('How many chromosomes you want to generate in a generation?, What is your population size ?\n');

   prompt={'Enter the Probability of mutation (Pm) :','Enter the Probability of crossover (Pc):',...
           'Enter the generations you want to run:','Enter the population size(pop_size):' };
   def={'0.1','0.3','10','30'};
   dlgTitle='Input initial parameters for Genetic Algorithm ';
   lineNo=1;
   answer=inputdlg(prompt,dlgTitle,lineNo,def);
   AddOpts.Resize='on';
   AddOpts.WindowStyle='normal';
   AddOpts.Interpreter='tex';
   
   
   Pm=str2num(answer{1})
   Pc=str2num(answer{2})
   numOfGen=str2num(answer{3})
   pop_size=str2num(answer{4})
   
   swCrossover=menu('Which CrossOver method you wanna use?','PartialMapXover','OrderXover','CyclicXover','PosBasedOX','OrderBasedOX')
   %swCrossover=2
   swMutation=menu('Which mutation method you want to use ? ', ' randExMut ','ShiftMut' )
   %swMutation=1
   swDynaGraph=menu('Do you want dynamic graph plotting?','YES','NO')
   %swDynaGraph=1
   gen_chromosome(pop_size,numOfJob * numOfMach)   %size denote how many jobs
%debug====================================================


%ask which kind of Crossover the user want
