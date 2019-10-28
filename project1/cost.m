function cost = cost( fitting,numberOfPoints )
costList = zeros(1,500);
for i = 1:500
    for j = 1:90
        delta = abs(fitting(i,j) - j + 21);
        if delta <= 0.5
            costList(i) = costList(i) + 0;
        elseif delta <= 1.0;
            costList(i) = costList(i) + 1;
        elseif delta <= 1.5;
            costList(i) = costList(i) + 4;
        elseif delta <= 2.0;
            costList(i) = costList(i) + 10;
        else
            costList(i) = costList(i) + 10000;
        end
    end
    
    costList(i) = costList(i) + 50 * numberOfPoints;
end
cost = sum(costList(1:500))/500;
end
