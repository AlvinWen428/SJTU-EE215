k=4;
RW=[];
ET=[];
for n=4:12
    sumtime=[];
    for s=1:10000
        Ta=exprnd(78500,1,n);
        Tb=exprnd(350000,1,n);
        brokena=0;
        brokenb=0;
        totaltime=0;
        for i=1:n
            x=rand();
            if x<=0.15
                brokena(i)=1;
            end
            if x>0.15 && x<=0.42
                brokena(i)=2;
            end
            if x>0.42 && x<=1
                brokena(i)=3;
            end
        end
        for i=1:n
            x=rand();
            if x<=0.65
                brokenb(i)=1;
            end
            if x>0.65 && x<=1
                brokenb(i)=2;
            end
        end
        Typea=zeros(1,n);
        Typeb=zeros(1,n);
        node=zeros(1,n);
        system=0;
    
     
        time=[Ta Tb];
        [time,index]=sort(time);
        for i=1:2*n
            if index(i)<=n
                brokennum=index(i);
                Typea(brokennum)=brokena(brokennum);
            end
            if index(i)>n
                if rem(index(i),4)~=0
                    brokennum=rem(index(i),4);
                end
                if rem(index(i),4)==0
                    brokennum=n;
                end
                Typeb(brokennum)=brokenb(brokennum);
            end
            
            if Typea(brokennum)==0 && Typeb(brokennum)==0
                node(brokennum)=0;
            elseif Typea(brokennum)==0 && Typeb(brokennum)==1
                node(brokennum)=3;
            elseif Typea(brokennum)==0 && Typeb(brokennum)==2
                node(brokennum)=1;
            elseif Typea(brokennum)==1 && Typeb(brokennum)==0
                node(brokennum)=1;
            elseif Typea(brokennum)==1 && Typeb(brokennum)==1
                node(brokennum)=5;
            elseif Typea(brokennum)==1 && Typeb(brokennum)==2
                node(brokennum)=1;
            elseif Typea(brokennum)==2 && Typeb(brokennum)==0
                node(brokennum)=2;
            elseif Typea(brokennum)==2 && Typeb(brokennum)==1
                node(brokennum)=3;
            elseif Typea(brokennum)==2 && Typeb(brokennum)==2
                node(brokennum)=4;
            elseif Typea(brokennum)==3 && Typeb(brokennum)==0
                node(brokennum)=4;
            elseif Typea(brokennum)==3 && Typeb(brokennum)==1
                node(brokennum)=4;
            elseif Typea(brokennum)==3 && Typeb(brokennum)==2
                node(brokennum)=4;
            end
        
            PF=0;
            MO=0;
            SO=0;
            FB=0;
            DM=0;
            DN=0;
            for m=1:n
                if node(m)==0
                    PF=PF+1;
                elseif node(m)==1
                    SO=SO+1;
                elseif node(m)==2
                    DM=DM+1;
                elseif node(m)==3
                    MO=MO+1;
                elseif node(m)==4
                    DN=DM+1;
                elseif node(m)==5
                    FB=FB+1;
                end
            end
            if FB>=1 || MO>=2 || (PF+MO+DN)==0 || (PF+SO+((MO+DM)>0))<k
                system=1;
            elseif FB==0 && ((MO==1 && (PF+SO)>k-1) || (MO==0 && PF==0 && DM>=1 && SO>=k-1))
                system=2;
            elseif FB+MO==0 && (PF>=1 && PF+SO==k-1 && DM>=1)
                p=DM/(DM+PF);
                x=rand();
                if x<=p
                    system=3;
                elseif x>p && x<=1
                    system=4;
                end
            end
            
            if system==1 || system==4
                totaltime=time(i);
                break;
            end
        end
        
        if totaltime==0
            totaltime=80000;
        end
        if totaltime>80000
            totaltime=80000;
        end
        
        sumtime=[sumtime totaltime];
    end
    w=25000;
    R=0;
    for ri=1:10000
        if sumtime(ri)>=w
            R=R+1;
        end
    end
    RW=[RW R/10000];
    ET=[ET sum(sumtime)/10000];
end

disp('RWÎª£º');
disp(RW);
disp('ETÎª£º');
disp(ET);
    
    
        
        
        
        
        
        
        
            
    
            