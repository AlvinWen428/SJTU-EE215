function sample = variation(sample,variRate,numberOfPoints)
sizeOfSample = length(sample(:,1));
for i = 1:sizeOfSample
    j = rand();
    if j < variRate
        p = unidrnd(numberOfPoints);
        sample(i,p) = unidrnd(90) - 21;
        while (length(sample(i,:)) - length(unique(sample(i,:))) ~= 0)
            for k = 1:numberOfPoints - 1
                for l = k+1 : numberOfPoints
                    if sample(i,k) == sample(i,l)
                        sample(i,k) = unidrnd(90) - 21;
                    end
                end
            end
        end
    end
end
end