function [ flag ] = judgebigfaultandadd( t,faulttype,waitforrepair,brokenmain )
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    global waitingbigfault;
    
    flag=0;
    if fix(faulttype/10)==1 && faulttype~=11 && brokenmain==7
        waitingbigfault=[waitingbigfault [t;faulttype]];
        flag=1;
       
    end
    
    if fix(faulttype/10)==7 && faulttype~=71 && brokenmain==1
        waitingbigfault=[waitingbigfault [t;faulttype]];
        flag=1;
       
    end
    
    if (fix(faulttype/10)==1 || fix(faulttype/10)==7) && faulttype~=11 && faulttype~=71 && brokenmain==17
        waitingbigfault=[waitingbigfault [t;faulttype]];
        flag=1;
       
    end
    if faulttype==11 || faulttype==71
        ran=rand();
        if ran<0.4
            waitingbigfault=[waitingbigfault [t;faulttype]];
            flag=1;
            
        end
    end
    if fix(faulttype/10)==5
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

