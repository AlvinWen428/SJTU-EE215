k=4;
w=25000;
Pa0=exp(-w*(1/78500));
Pa1=0.15*(1-exp(-w*(1/78500)));
Pa2=0.27*(1-exp(-w*(1/78500)));
Pa3=0.58*(1-exp(-w*(1/78500)));
Pb0=exp(-w*(1/350000));
Pb1=0.65*(1-exp(-w*(1/350000)));
Pb2=0.35*(1-exp(-w*(1/350000)));

availability=[];

Pnode=[Pa0*Pb0 Pa0*Pb1+Pa2*Pb1 Pa0*Pb2+Pa1*Pb0+Pa1*Pb2 Pa1*Pb1 Pa2*Pb0 Pa2*Pb2+Pa3*(Pb0+Pb1+Pb2)];


for n=4:12
    nodetype=[];
    for i1=0:n
        for i2=0:n-i1
            for i3=0:n-i1-i2
                for i4=0:n-i1-i2-i3
                    for i5=0:n-i1-i2-i3-i4
                        for i6=0:n-i1-i2-i3-i4-i5
                            if i1+i2+i3+i4+i5+i6==n
                                nodetype=[nodetype;i1 i2 i3 i4 i5 i6];
                            end
                        end
                    end
                end
            end
        end
    end
    [z,c]=size(nodetype);
    result=0;
    for i=1:z
        tmp=nodetype(i,:);
        if nodetype(i,4)==0 && ((nodetype(i,2)==1 && nodetype(i,1)+nodetype(i,3)>=k-1) || ((nodetype(i,2)==0 && nodetype(i,1)>=1 && nodetype(i,1)+nodetype(i,3)>=k) || (nodetype(i,2)==0 &&nodetype(i,1)==0 && nodetype(i,5)>=1 && nodetype(i,3)>=k-1)))
            pn=Pnode.^tmp;
            p=nchoosek(n,tmp(1))*nchoosek(n-tmp(1),tmp(2))*nchoosek(n-tmp(1)-tmp(2),tmp(3))*nchoosek(n-tmp(1)-tmp(2)-tmp(3),tmp(4))*nchoosek(n-tmp(1)-tmp(2)-tmp(3)-tmp(4),tmp(5))*nchoosek(n-tmp(1)-tmp(2)-tmp(3)-tmp(4)-tmp(5),tmp(6))*pn(1)*pn(2)*pn(3)*pn(4)*pn(5)*pn(6);
            result=result+p;
        end
        if tmp(4)+tmp(2)==0 && (tmp(1)>=1 && tmp(1)+tmp(3)==k-1 && tmp(5)>=1)
            pn=Pnode.^tmp;
            p=(tmp(5)/(tmp(5)+tmp(1)))*nchoosek(n,tmp(1))*nchoosek(n-tmp(1),tmp(2))*nchoosek(n-tmp(1)-tmp(2),tmp(3))*nchoosek(n-tmp(1)-tmp(2)-tmp(3),tmp(4))*nchoosek(n-tmp(1)-tmp(2)-tmp(3)-tmp(4),tmp(5))*nchoosek(n-tmp(1)-tmp(2)-tmp(3)-tmp(4)-tmp(5),tmp(6))*pn(1)*pn(2)*pn(3)*pn(4)*pn(5)*pn(6);
            result=result+p;
        end
    end
    availability=[availability result];
end
        
disp(availability);
        