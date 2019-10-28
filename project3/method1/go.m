P1=1-exp(-1/94500);%控制硬部件、接口部件、集线器部件的所有元件故障概率
P2=1-exp(-1/4700);%控制软部件的单元件故障概率
P3=1-exp(-1/10);%人工修理修理好的概率
P4=1-exp(-1);%控制软部件由Watchdog重启从故障状态中恢复的概率
Phard=56*P1;
Pinterface=25*P1;
Phub=20*P1;
Psoft=P2;

global waitingbigfault;
global lastbigfault;

repairtimes=0;
faulttimes=0;
bigfaulttimes=0;
wi=[];%每个系统在10年中的无故障运行总时间
Fi=[];%每个系统连续无故障运行的完整时间段落的个数
fi=[];%每个系统连续无故障运行的完整时间段落的总时长
Gi=[];%每个系统连续无重大故障运行的完整时间段落的个数
gi=[];%每个系统连续无重大故障运行的完整时间段落的总时长

pstate=[1 2 8 20 100 1000 8760 43800 87600; 0 0 0 0 0 0 0 0 0];%系统在1小时、2小时、8小时、20小时、100小时、1000小时、1年、5年、10年处于无故障状态的概率（以频率近似概率）
plotstate=[1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16;0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];%系统在以指数形式的小时处于无故障状态的概率（以频率近似概率）
plotstate(1,:)=2.^plotstate(1,:);
%故障的类型：通讯主机接口11，主机硬件12，主机软件人工修复13，软件重启14
%           通讯从机1接口21，从机1硬件22，从机1软件人工修复23，软件重启24
%           通讯从机2接口31，从机2硬件32，从机2软件人工修复33，软件重启34
%           通讯从机3接口41，从机3硬件42，从机3软件人工修复43，软件重启44
%           集线器故障51
%           人工修复好6

for i=1:1200
    Fi(i)=0;
    Gi(i)=0;
    fj=[];%每个系统每段连续无故障运行的完整时间段落的时长
    gj=[];%每个系统每段连续无重大故障运行的完整时间段落的时长
    fault=[];%记录当下存在的所有故障的队列，若出现新的故障则入队，若修好则出队
    index=1;%记录当前记录到pstate的第几项
    plotindex=1;%记录当前记录到plotstate的第几项
    waitingbigfault=[]; %记录当下等待修理的所有重大故障的队列
    lastbigfault=0;%记录上一个重大错误，用于判断处理一般错误时其前一个是否是重大错误
    lastrepairtime=0;%记录上一次修理完成的时间，用于计算无故障运行时间
    lastrepairbigfaulttime=0;%记录上一次修理重要故障完成的时间，用于计算无重要故障运行时间
    repairer=0;%记录人工修理的工作状态，0表示不在修理，1表示在修理
    waitforrepair=[];%记录连续发生的等待修理的故障
    %初始化每个部件出现各种故障的时间
    T=exprnd((1/25)*94500);
    fault=[fault [T;11]];
    T=exprnd((1/56)*94500);
    fault=[fault [T;12]];
    ran=rand();
    if ran<0.012
        T=exprnd(4700);
        fault=[fault [T;13]];
    else
        T=exprnd(4700);
        fault=[fault [T;14]];
    end
    for j=2:4
        T=exprnd((1/25)*94500);
        fault=[fault [T;j*10+1]];
        T=exprnd((1/56)*94500);
        fault=[fault [T;j*10+2]];
        ran=rand();
        if ran<0.012
            T=exprnd(4700);
            fault=[fault [T;j*10+3]];
        else
            T=exprnd(4700);
            fault=[fault [T;j*10+4]];
        end
    end
    T=exprnd((1/20)*94500);
    fault=[fault [T;51]];
    %将故障发生的时间按顺序排列
    fault=sortrows(fault',1)';
    
    %进入循环
    t=fault(1,1);
    faulttype=fault(2,1);
    while t<87600
        while index<=9 && pstate(1,index)<t
            if repairer==0
                pstate(2,index)=pstate(2,index)+1;
            end
            index=index+1;
        end
        while  plotindex<=16 && plotstate(1,plotindex)<t
            if repairer==0
                plotstate(2,plotindex)=plotstate(2,plotindex)+1;
            end
            plotindex=plotindex+1;
        end
        
        fault=fault(:,2:end);
        if fix(faulttype/100)==6
            if isempty(waitingbigfault)~=1
                    if waitingbigfault(2,1)==mod(faulttype,100)
                        waitingbigfault=waitingbigfault(:,2:end);
                        if isempty(waitingbigfault)==1
                            bigfaulttimes=bigfaulttimes+1;
                            Gi(i)=Gi(i)+1;
                            lastbigfault=0;
                            lastrepairbigfaulttime=t;
                        else
                            if waitingbigfault(1,1)>t
                                lastrepairbigfaulttime=t;
                            end
                        end
                    else
                        if lastbigfault==1
                            bigfaulttimes=bigfaulttimes+1;
                            Gi(i)=Gi(i)+1;
                            lastbigfault=0;
                        end
                    end
            end
            if isempty(waitforrepair)==1
                repairer=0;
                lastrepairtime=t;
                fault=nexttimefault(faulttype,fault,t,faulttimes);
                fault=sortrows(fault',1)';
                faulttimes=faulttimes+1;
            else
                fault=nexttimefault(faulttype,fault,t,faulttimes);
                repairer=1;
                if mod(waitforrepair(2,1),10)==4
                    T=t+exprnd(1);
                else
                    T=t+exprnd(10);
                end
                fault=[fault [T;6*100+waitforrepair(2,1)]];
                fault=sortrows(fault',1)';
                waitforrepair=waitforrepair(:,2:end);
            end
        else
            waitforrepair=[waitforrepair [t;faulttype]];
            tmp=isempty(waitingbigfault);
            flag=judgebigfaultandadd(t,faulttype,waitforrepair);
            if flag==1 && tmp==1
                gj=[gj t-lastrepairbigfaulttime];
            end
            if T<87600 && mod(faulttype,10)~=4
                repairtimes=repairtimes+1;
            end
            if repairer==0
                fj=[fj t-lastrepairtime];
                Fi(i)=Fi(i)+1;
                repairer=1;
                if mod(waitforrepair(2,1),10)==4
                    T=t+exprnd(1);
                else
                    T=t+exprnd(10);
                end
                fault=[fault [T;6*100+waitforrepair(2,1)]];
                fault=sortrows(fault',1)';
                waitforrepair=waitforrepair(:,2:end);
                
            end
        end
        t=fault(1,1);
        faulttype=fault(2,1);
    end
    if repairer==0
        pstate(2,9)=pstate(2,9)+1;
    end
    
    fi(i)=sum(fj);
    gi(i)=sum(gj);
    
end

plotstate(2,:)=plotstate(2,:)/1200;
plot(plotstate(1,:),plotstate(2,:));

pstate(2,:)=pstate(2,:)/1200;
disp(pstate);

averrepairtimes=repairtimes/1200;
averfaulttimes=faulttimes/1200;
averbigfaulttimes=bigfaulttimes/1200;
avernofaulttime=sum(fi)/1200;
avercontinuenofaulttime=sum(fi)/sum(Fi);
avercontinuenobigfaulttime=sum(gi)/sum(Gi);

disp(averrepairtimes);
disp(averfaulttimes);
disp(averbigfaulttimes);
disp(avernofaulttime);
disp(avercontinuenofaulttime);
disp(avercontinuenobigfaulttime);
