%gen_chromosome(num,size)
%在此產生的染色體皆已符合FlowShop的編碼原則

function gen_chromosome(num,siz)
global chromosome
global numOfJob
%if nargin<1
%   chromosome=mod(ceil(abs(randn(10,10))*10),10)+1;
%elseif nargin ==2   
%   chromosome=mod(ceil(abs(randn(num,siz))*10),siz)+1;
%elseif nargin==1   
%   chromosome=mod(ceil(abs(randn(num,10))*10),10)+1;
%end   
for ix=1:num
  chromosome(ix,:)=randperm(siz);
end

chromosome;
%
%r=1;
%while r<=num   
%    while length(unique(chromosome(r,:) ))<siz
%        for i=1:siz          
%          for j=1:siz
%           if chromosome(r,j)==chromosome(r,i)          
%               if  j>i 
%                   chromosome(r,j)=mod(ceil(abs(randn(1))*10),siz)+1;
%               end   
%           end          
%        end          
%      end  
           
%     end   
%chromosome(r,:)=randperm(numOfJob)
%   r=r+1;
%end
strSymbol=' %4d';
for ix=1:siz
    strSymbol =strcat(strSymbol, ' %4d');
end


   fprintf('\n');
for ix=1:num
   fprintf(['job_seq_%3d=', strSymbol,'\n'],ix,chromosome(ix,1:siz))
   fprintf('\n')
end   