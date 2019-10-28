function fitting = fitting(sample,data,numberOfPoints)
fitting = zeros(500,90);
sampley = zeros(500,numberOfPoints);
for i = 1:500
    for j = 1:numberOfPoints
        y = sample(j) + 21;
        sampley(i,j) = data(i,y);
    end
    fitting(i,:) = interp1(sampley(i,:),sample,data(i,:),'spline');
end
end