function [emptyCnt, maxOrder] = getEmptyCountAndMaxOrder(toBeDetermineCol,toBeDetermineOrderCol)
global timeTable
global jobDealOrder    

        emptyCnt = 0;
        maxOrder = 1;
        for ixx= 1: size(timeTable,1)  
          if( isempty(toBeDetermineCol{ixx}) )
               emptyCnt = emptyCnt + 1;
               if toBeDetermineOrderCol(ixx) > maxOrder
                   maxOrder = toBeDetermineOrderCol(ixx)
               end
          end            
        end        
         emptyCnt 
        maxOrder
        return