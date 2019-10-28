function sample = combine (sample,combRate,numberOfPoints)
sizeOfSample = length(sample(:,1));
times  = round(2 * sizeOfSample * combRate);
for i = 1:times;
    a = unidrnd(sizeOfSample);
    b = unidrnd(sizeOfSample);
    if a ~= b
        p = unidrnd(numberOfPoints);
        temp1 = sample(a,:);
        temp2 = sample(b,:);
        temp1(p:numberOfPoints) = sample(b,p:numberOfPoints);
        temp2(p:numberOfPoints) = sample(a,p:numberOfPoints);
        sample(a,:) = temp1;
        sample(b,:) = temp2;
        while (length(sample(a,:)) - length(unique(sample(a,:))) ~= 0)
            for k = 1:numberOfPoints - 1
                for j = k+1 : numberOfPoints
                    if sample(a,k) == sample(a,j)
                        sample(a,k) = unidrnd(90) - 21;
                    end
                end
            end
        end
        while (length(sample(b,:)) - length(unique(sample(b,:))) ~= 0)
            for k = 1:numberOfPoints - 1
                for j = k+1 : numberOfPoints
                    if sample(b,k) == sample(b,j)
                        sample(b,k) = unidrnd(90) - 21;
                    end
                end
            end
        end
    end
end

end
