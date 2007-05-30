%randExMut: random exchange mutation for one chromosome

function newVa=randExMut(Va)

%fprintf('original Va is:\n')
%Va= [  8   7   4   2   6   5   1   9   3  10 ];
original_Va=Va;

Ranpos=[];
while(length(Ranpos)<2)
Ranpos=sort(mod(floor(randn(1,2)*10),length(Va))+1);
end

temp=Va(Ranpos(1));
Va(Ranpos(1))=Va(Ranpos(2));
Va(Ranpos(2))=temp;
%fprintf('After random mutation, Va is:\n')
%Va
newVa=fliplr(Va);