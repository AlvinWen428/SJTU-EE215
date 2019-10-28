function [ flag ] = judgebigfaultandadd( t,faulttype,waitforrepair )
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
    global waitingbigfault;
    
    flag=0;
    if fix(faulttype/10)==1 || fix(faulttype/10)==5
        waitingbigfault=[waitingbigfault [t;faulttype]];
        flag=1;
       
    end
    if faulttype==21 || faulttype==31 || faulttype==41
        ran=rand();
        if ran<0.4
            waitingbigfault=[waitingbigfault [t;faulttype]];
            flag=1;
            
        end
    end
    if fix(faulttype/10)==2 || fix(faulttype/10)==3 || fix(faulttype/10)==4
        if size(waitforrepair,2)~=0
            for i=size(waitforrepair,2):1
                if (fix(waitforrepair(2,i)/10)==2 || fix(waitforrepair(2,i)/10)==3 || fix(waitforrepair(2,i)/10)==4) && (fix(waitforrepair(2,i)/10)~=fix(faulttype/10))
                    if ismember(waitforrepair(2,i),waitingbigfault)==1
                        [~,b]=find(waitingbigfault==waitforrepair(2,i));
                        waitingbigfault(:,b)=[];
                        waitingbigfault=[waitingbigfault [t;faulttype]];
                    else
                        waitingbigfault=[waitingbigfault [t;faulttype]];
                    end
                    flag=1;
                    
                    break;
                end
            end
        end
    end
    
    
end

