function sizeOfChildren = populationSize (sizeOfParent,retainRate)
sizeOfChildren = round(sizeOfParent * retainRate);
if sizeOfChildren < 15
    sizeOfChildren = 15;
end
end