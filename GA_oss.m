%GA_oss denote the Genetic Algorithm Open Shop Scheduling Problem

function GA_oss()
global Pm
global Pc        %probability of crossover
global chromosome
global everyGenResult
global boundGen  % limited generation bound, or just meaning the generations we considered
global numOfGen
global pop_size
global TotalGen
global jobInfo
%global someValue
global c          %every job of machine makespan
global temp

GA_init            % to generate the initial chromosome, and just iniialize some variables

%狦程「200程ㄎ跑て琘计┪羆计笷璶―玥氨ゎ
%if TotalGen>boundGen
%   if  everyGenResult{TotalGen,2}-everyGenResult{TotalGen-boundGen,2}<someValue | TotalGen==numOfGen
%       return
%   end   
%end



while TotalGen < numOfGen
    GAMainProc
end

%Graphical Interface output------------------
%Tell the user what kind of Crossover & Mutation they used
drawGanttChart
%draw lineChart
%saveToFile