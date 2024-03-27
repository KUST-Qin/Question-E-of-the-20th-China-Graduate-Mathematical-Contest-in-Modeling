clc
clear
data=xlsread('水肿与时间表2.xlsx');
for p=1:size(data,1) %遍历每一个人
    e=[]; %用于记录每次测试的误差
    tt=data(p,1);
    if tt>9
        tt=9;
    end
    for t=1:tt %遍历每一次测试
        [y]=hanshu(data(p,t*2));
        e=[e abs(y-data(p,t*2+1))];
    end
    table(p,1)=mean(e);
end
%% 定义函数
function [y]=hanshu(x)
p1     = 	-2841.14525157266;
p2    =  	3844.05914112997;
p3    =  	-237.788401408496;
p4     = 	13.3412851194662;
p5     = 	-0.279519545646171;
p6      =	0.00190344785905017;
y = p1+p2*x.^0.5+p3*x+p4*x.^1.5+p5*x.^2+p6*x.^2.5;
end
