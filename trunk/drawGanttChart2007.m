function drawGanttChart2007()
global timeTable

timeTable

for ix = 1: size(timeTable,1)
    for jx = 1: size(timeTable,2)
        plot([timeTable{ix,jx}.begin, timeTable{ix,jx}.end], timeTable{ix,jx}.job, 'r')
        hold on
        drawnow
        text([timeTable{ix,jx}.begin, timeTable{ix,jx}.end], [J,num2str(timeTable{ix,jx}.job)])
    end
end