data_init;
retainRate = 0.99;
combineRate = 0.5;
variRate = 0.3;
for i = 1:50
    num = length(parents(:,1));
    size = populationSize(num,retainRate);
    parents = selet(parents,size,data1,numberOfPoints1);
    parents = combine(parents,combineRate,numberOfPoints1);
    parents = variation(parents,variRate,numberOfPoints1);
    end
parents = selet(parents,size,data1,numberOfPoints1);
minCost = showMin(parents,size,data1,numberOfPoints1);
disp(minCost);
