P1=1-exp(-1/94500);%����Ӳ�������ӿڲ���������������������Ԫ�����ϸ���
P2=1-exp(-1/4700);%���������ĵ�Ԫ�����ϸ���
P3=1-exp(-1/10);%�˹���������õĸ���
P4=1-exp(-1);%����������Watchdog�����ӹ���״̬�лָ��ĸ���
Phard=56*P1;
Pinterface=25*P1;
Phub=20*P1;
Psoft=P2;

global waitingbigfault;
global lastbigfault;

repairtimes=0;
faulttimes=0;
bigfaulttimes=0;
wi=[];%ÿ��ϵͳ��10���е��޹���������ʱ��
Fi=[];%ÿ��ϵͳ�����޹������е�����ʱ�����ĸ���
fi=[];%ÿ��ϵͳ�����޹������е�����ʱ��������ʱ��
Gi=[];%ÿ��ϵͳ�������ش�������е�����ʱ�����ĸ���
gi=[];%ÿ��ϵͳ�������ش�������е�����ʱ��������ʱ��

pstate=[1 2 8 20 100 1000 8760 43800 87600; 0 0 0 0 0 0 0 0 0];%ϵͳ��1Сʱ��2Сʱ��8Сʱ��20Сʱ��100Сʱ��1000Сʱ��1�ꡢ5�ꡢ10�괦���޹���״̬�ĸ��ʣ���Ƶ�ʽ��Ƹ��ʣ�
plotstate=[1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16;0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];%ϵͳ����ָ����ʽ��Сʱ�����޹���״̬�ĸ��ʣ���Ƶ�ʽ��Ƹ��ʣ�
plotstate(1,:)=2.^plotstate(1,:);
%���ϵ����ͣ�ͨѶ�����ӿ�11������Ӳ��12����������˹��޸�13���������14
%           ͨѶ�ӻ�1�ӿ�21���ӻ�1Ӳ��22���ӻ�1����˹��޸�23���������24
%           ͨѶ�ӻ�2�ӿ�31���ӻ�2Ӳ��32���ӻ�2����˹��޸�33���������34
%           ͨѶ�ӻ�3�ӿ�41���ӻ�3Ӳ��42���ӻ�3����˹��޸�43���������44
%           ����������51
%           �˹��޸���6

for i=1:1200
    Fi(i)=0;
    Gi(i)=0;
    fj=[];%ÿ��ϵͳÿ�������޹������е�����ʱ������ʱ��
    gj=[];%ÿ��ϵͳÿ���������ش�������е�����ʱ������ʱ��
    fault=[];%��¼���´��ڵ����й��ϵĶ��У��������µĹ�������ӣ����޺������
    index=1;%��¼��ǰ��¼��pstate�ĵڼ���
    plotindex=1;%��¼��ǰ��¼��plotstate�ĵڼ���
    waitingbigfault=[]; %��¼���µȴ�����������ش���ϵĶ���
    lastbigfault=0;%��¼��һ���ش���������жϴ���һ�����ʱ��ǰһ���Ƿ����ش����
    lastrepairtime=0;%��¼��һ��������ɵ�ʱ�䣬���ڼ����޹�������ʱ��
    lastrepairbigfaulttime=0;%��¼��һ��������Ҫ������ɵ�ʱ�䣬���ڼ�������Ҫ��������ʱ��
    repairer=0;%��¼�˹�����Ĺ���״̬��0��ʾ��������1��ʾ������
    waitforrepair=[];%��¼���������ĵȴ�����Ĺ���
    %��ʼ��ÿ���������ָ��ֹ��ϵ�ʱ��
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
    %�����Ϸ�����ʱ�䰴˳������
    fault=sortrows(fault',1)';
    
    %����ѭ��
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
