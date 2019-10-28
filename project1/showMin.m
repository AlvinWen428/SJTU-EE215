function minCost = showMin ( parents , sizeOfChildren,data,numberOfPoints )
sizeOfParents = length(parents(:,1));
costList = zeros(1,sizeOfParents);;
for i = 1:sizeOfParents
    fittingList = fitting1(parents(i,:),data,numberOfPoints);
    costList(i) = cost(fittingList,numberOfPoints);
end
minCost = min(costList);
for i = 1:sizeOfParents
    if abs(costList(i) - minCost) < 0.001
        disp(parents(i,:));
        break;
    end
end
end