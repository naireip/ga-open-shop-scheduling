function GATinit()
global Pm
global Pc
global chromosome
global everyGenResult
global numOfGen    %要跑的總世代數上限
global swCrossover %選擇各種交配的開關
global swMutation    %選擇各種突變的開關
global swDynaGraph
global pop_size
global NowGen
global jobInfo
global numOfMach
global numOfJob
global TotalGen
global EachRunResult
global EachRunChr
global TotalRun
%global AllRunChr
%global AllRunAns


close all
Ans=menu('你是否要使用隨機問題產生器?','是的，我要用','不用了，我讀取檔案中的範例即可');
if Ans==1
   %gaProblemgen
   load Problem
   jobInfo=Problem
else   
   load jobInfo.txt
end

chromosome=[];
everyGenResult=[];

numOfMach=size(jobInfo,1)-1
numOfJob=size(jobInfo,2)

 %prompt={'Enter the generations you want to run:'};
 %  def={'10'};
 %  dlgTitle=['Please input the generations you want to run'];
 %  lineNo=1;
 %  answer=inputdlg(prompt,dlgTitle,lineNo,def);
 %  AddOpts.Resize='on';
 %  AddOpts.WindowStyle='normal';
 %  AddOpts.Interpreter='tex';  
   
 %  numOfGen=str2num(answer{1})
 numOfGen=100 
 TotalGen=numOfGen;
 TotalRun=20

EachRunResult=[];
EachRunChr=[];
%AllRunChr=[];
%AllRunAns=[];
