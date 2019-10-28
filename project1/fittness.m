function fittness = fittness (costList)
cMax = max(costList);
cMin = min(costList);
size = length(costList);
valueList = zeros(1,size);
for i = 1:size
    valueList(i) = ((cMax - costList(i))/(cMax-cMin))^20;
end
sumValue = sum(valueList);
fittness = zeros(1,size);
fittness(1) = valueList(1) / sumValue;
for i = 2:size
    fittness(i) = fittness(i-1) + valueList(i) / sumValue;
end;
end