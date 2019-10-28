file = csvread('dataform20160902.csv');
data1 = zeros(500,90);
for i = 1:500;
    data1(i,:) = file (2*i,:);
end
numberOfPoints1 = 5;

parents = zeros(100,numberOfPoints1);
for i = 1:100
    for j = 1:numberOfPoints1
        parents(i,j) = unidrnd(90) - 21;
    end
end
for i = 1:length(parents(:,1))
    while (length(parents(i,:)) - length(unique(parents(i,:))) ~= 0)
        for k = 1:numberOfPoints1 - 1
            for m = k+1 : numberOfPoints1
                if parents(i,k) == parents(i,m)
                    parents(i,k) = unidrnd(90) - 21;
                end
            end
        end
    end
end