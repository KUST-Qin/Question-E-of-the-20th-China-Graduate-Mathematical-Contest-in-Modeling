clear
clc
warning off
load data
%% a
Num=unique(Table(2:end,1),'stable');
A=[];%患者第一次诊断时的指标
B=[];%记录拟合参数
Y=[];%是否发病
T=zeros(length(Num),1);%静脉扩张时间
for i=1:length(Num)
    a=find(Table(:,1)==Num(i));
    A=[A;double(Table(a(1),4:end))];
    t=double(Table(a,3));
    HM_volume=double(Table(a,23));
    if length(HM_volume>0)
        b=regress(HM_volume,[ones(length(t),1),t]);%线性回归，可以自己换算法
    else%如果只有一个数据，则用样本数据匹配最接近的其他样本对应的参数
        AA=mapminmax(A',0,1)';
        d=pdist2(AA(end,:),AA(1:end-1,:));
        [~,o]=min(d);
        b=B(:,o);
    end
    B=[B,b];
    t1=[t(1):0.1:48]';%将时间网格化，精度为0.1
    HM_volume_48=[ones(length(t1),1),t1]*b;%时间设为第一次诊断到发病第48小时内
    a1=find(HM_volume_48./HM_volume(1)>1.33);
    a2=find(HM_volume_48-HM_volume(1)>6000);
    aa=union(a1,a2);
    if length(aa)>0
        Y(i,1)=1;
        T(i,1)=t1(aa(1));
    else
        Y(i,1)=0;
    end
end
result1=[Num,Y,T];
%% b
%变量
In=mapminmax(A',0,1);
Out=Y';
%bp神经网络
Xtrain = In(:,1:100);
Ytrain = Out(:,1:100);
Xtest1 = In(:,101:130);
Ytest1= Out(:,101:130);
Xtest2 = In(:,131:160);
Ytest2= Out(:,131:160);
% 1. 创建网络
net = newff(Xtrain,Ytrain,[fix(size(Xtrain,1)/2),fix(size(Xtrain,1)/4)],{'tansig','tansig'});
% 2. 设置训练参数
net.trainParam.epochs = 1000;%最大迭代次数，到达最大迭代次数则终止
net.trainParam.goal = 1e-100;%训练误差，达到目标误差则终止
net.trainParam.min_grad = 1e-100;%性能函数的最小梯度
net.trainParam.lr = 1e-5;%学习速率
net.trainParam.max_fail=100;%最大确认失败次数，终止条件之一
% 3. 训练网络
net = train(net,Xtrain,Ytrain);
% 4. 仿真测试
t_sim = max(sim(net,Xtrain),0);
t_sim1 = max(sim(net,Xtest1),0);
t_sim2 = max(sim(net,Xtest2),0);
T_sim = round(t_sim);
T_sim1 = round(t_sim1);
T_sim2 = round(t_sim2);
%混淆矩阵
figure
plotconfusion(categorical(Ytrain),categorical(T_sim));
title('训练集')
figure
plotconfusion(categorical(Ytest1),categorical(T_sim1));
title('测试集1')
figure
plotconfusion(categorical(Ytest2),categorical(T_sim2));
title('测试集2')

result1=[["患者","是否发生血肿扩张","血肿扩张时间","血肿扩张预测概率"];[result1,[t_sim';t_sim1';t_sim2']]];