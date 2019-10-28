function fitting = fitting1(sample,data,numberOfPoints)
fitting = zeros(500,90);
sampley = zeros(500,numberOfPoints);
for i = 1:500
    for j = 1:numberOfPoints
        y = sample(j) + 21;
        sampley(i,j) = data(i,y);
    end
    fx = polyfit(sampley(i,:),sample,4);
    fitting(i,:) = polyval(fx,data(i,:));
end
end