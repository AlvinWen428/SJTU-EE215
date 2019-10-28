function [ fault ] = nexttimefault( faulttype,fault,t,faulttimes )
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
    if mod(faulttype,100)==11
        T=t+exprnd((1/25)*94500);
        fault=[fault [T;11]];
    elseif mod(faulttype,100)==12
        T=t+exprnd((1/56)*94500);
        fault=[fault [T;12]];
    elseif mod(faulttype,100)==13
        ran=rand();
        if ran<0.012
            T=t+exprnd(4700);
            fault=[fault [T;13]];
        else
            T=t+exprnd(4700);
            fault=[fault [T;14]];
        end
    elseif mod(faulttype,100)==14
        ran=rand();
        if ran<0.012
            T=t+exprnd(4700);
            fault=[fault [T;13]];
        else
            T=t+exprnd(4700);
            fault=[fault [T;14]];
        end
    elseif mod(faulttype,100)==51
        T=t+exprnd((1/20)*(94500));
        fault=[fault [T;51]];
    elseif mod(faulttype,100)==21 || mod(faulttype,100)==31 || mod(faulttype,100)==41
        T=t+exprnd((1/25)*94500);
        fault=[fault [T;fix(mod(faulttype,100)/10)*10+1]];
    elseif mod(faulttype,100)==22 || mod(faulttype,100)==32 || mod(faulttype,100)==42
        T=t+exprnd((1/56)*94500);
        fault=[fault [T;mod(faulttype,100)]];
    elseif mod(faulttype,100)==23 || mod(faulttype,100)==33 || mod(faulttype,100)==43 || mod(faulttype,100)==24 || mod(faulttype,100)==34 || mod(faulttype,100)==44
        ran=rand();
        if ran<0.012
            T=t+exprnd(4700);
            fault=[fault [T;fix(mod(faulttype,100)/10)*10+3]];
        else
            T=t+exprnd(4700);
            fault=[fault [T;fix(mod(faulttype,100)/10)*10+4]];
        end
    end
end

