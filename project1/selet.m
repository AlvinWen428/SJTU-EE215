function children = selet ( parents , sizeOfChildren,data,numberOfPoints )
sizeOfParents = length(parents(:,1));
costList = zeros(1,sizeOfParents);
children = zeros(sizeOfChildren,numberOfPoints);
for i = 1:sizeOfParents
    fittingList = fitting1(parents(i,:),data,numberOfPoints);
    costList(i) = cost(fittingList,numberOfPoints);
end
fittnessList = fittness (costList);
disp(min(costList));
minCost = min(costList);
for i = 1:sizeOfParents
    if costList(i) == minCost
        disp(parents(i,:));
        break;
    end
end
for i = 1:sizeOfChildren
    k = rand();
    if k <= fittnessList(1);
        children(i,:) = parents(1,:);
    else
        for j = 2:sizeOfParents
        if k <= fittnessList(j) && k > fittnessList(j - 1)
            children(i,:) = parents(j,:);
        end
        end
    end  
end
end