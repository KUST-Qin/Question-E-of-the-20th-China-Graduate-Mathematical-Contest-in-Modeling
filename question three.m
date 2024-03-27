clear
clc

load data
Num=unique(Table(2:end,1),'stable');
A=[];%首检
Y=[];%首检Rms
B=[];%随检
N1=[];
N2=[];
Z=[Table(1,[4:5,7:end])];
for i=1:length(Num)
    a=find(Table(:,1)==Num(i));
    A=[A;double(Table(a(1),[4:5,7:end]))];
    Y=[Y;double(Table(a(1),6))];
    N1=[N1;Table(a(1),1:2)];
    B=[B;double(Table(a(2:end),[4:5,7:end]))];
    N2=[N2;Table(a(2:end),1:2)];
end
%% a
[In,ps_in]=mapminmax(A',0,1);
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
%% b
Xyuce = mapminmax(B','apply',ps_in);
t_sim3 = max(sim(net,Xyuce),0);
T_sim3 = round(t_sim3);
result3="";
for i=1:length(Num)
    a=find(N2==Num(i));
    for j=1:length(a)
        result3(i,j)=string(T_sim3(a(j)));
    end
end
result3=string(result3);
result3(ismissing(result3)==1)="";
z=[];
for i=1:size(result3,2)
    z=[z,"第"+num2str(i)+"次随访"];
end
result3=[["患者","首次检测";Num,[T_sim';T_sim1';T_sim2']],[z;result3]];
%% c
%相关性分析
X=double(Table(2:end,[4:5,7:end]));
P=[];
for i=1:size(X,2)
    for j=1:size(X,2)
        P(i,j)=X(:,i)'*X(:,j)/(norm(X(:,i))*norm(X(:,j)));
    end
end
figure%热图
set(gca,'position',[0.05 0.05 0.9 0.9])
h=heatmap(P,'ColorbarVisible', 'on');
h.FontSize = 8;
h.CellLabelFormat = '%0.2g';
resultp=["",Z;Z',P];%自行分析相关性结果

disp('预测结果见result3，相关性结果见resultp')