clear
clc

%% a
load data
Num=unique(Table(2:end,1),'stable');
T=[];%记录复查时间
ED=[];%记录水肿数据
A=[];%记录除此诊断信息
for i=1:length(Num)
    a=find(Table(:,1)==Num(i));
    A=[A;double(Table(a(1),4:end))];
    T=[T;double(Table(a,3))];
    ED=[ED;double(Table(a,34))];
end
figure
plot(T,ED,'*')
xlim([1,2000])
%高斯模型
hold on
gaussModel = fit(T, ED, 'gauss1')
plot(gaussModel)
xlabel('时间')
ylabel('水肿/10^-3ml')
%计算残差
ED_fit=gaussModel(T);
Error=[];
for i=1:length(Num)
    a=find(Table(:,1)==Num(i))-1;
    Error(i,1)=mean(abs(ED_fit(a)-ED(a)));
end
%% b
%个体差异用Tabel第4-15列的指标来进行聚类
cluster_n=5;%聚类中心
[center, U, obj_fcn] = fcm(double(A(:,1:12)), cluster_n);
figure%目标函数变化值
plot(obj_fcn)
xlabel('iteration')
ylabel('obj.fcn_value')
title('FCM聚类')
[~,u]=max(U);
ED_fit2=[];
for i=1:cluster_n
    a=find(u==i);
    b=find(ismember(Table(2:end,1),Num(a))==1);
    figure
    plot(T(b),ED(b),'*')
    xlim([1,2000])
    %高斯模型
    hold on
    disp('亚类1：')
    gaussModel = fit(T(b), ED(b), 'gauss1')
    plot(gaussModel)
    xlabel('时间')
    ylabel('水肿/10^-3ml')
    title(['亚类',num2str(i)])
    ED_fit2(b,1)=gaussModel(T(b));
end
%计算残差
Error2=[];
for i=1:length(Num)
    a=find(Table(:,1)==Num(i))-1;
    Error2(i,1)=mean(abs(ED_fit2(a)-ED(a)));
end
result2=[["患者","残差(全体)","残差(亚类)","亚类"];[Num,Error,Error2,u']];

%% b
load data
Num = unique(Table(2:end, 1), 'stable');
T = []; % 记录复查时间
ED = []; % 记录水肿数据
A = []; % 记录除此诊断信息
for i = 1:length(Num)
    a = find(Table(:, 1) == Num(i));
    A = [A; double(Table(a(1), 4:end))];
    T = [T; double(Table(a, 3))];
    ED = [ED; double(Table(a, 34))];
end
figure
plot(T, ED, '*')
xlim([1, 2000])
xlabel('时间')
ylabel('水肿/10^-3ml')
% 指数模型拟合函数
exponentialModel = @(beta, x) beta(1) * exp(beta(2) * x);
% 初始参数猜测
beta0 = [1, -0.01]; % 这里的初始猜测值可能需要根据你的数据进行调整
% 生成拟合曲线上的点
x = linspace(min(T), max(T), 1000);
% 非线性拟合
beta = lsqcurvefit(exponentialModel, beta0, T, ED);
% 计算拟合曲线上的值
y = exponentialModel(beta, x);
% 绘制拟合曲线
hold on
plot(x, y, 'r-', 'LineWidth', 2)
legend('原始数据', '指数模型拟合')
% 计算残差
ED_fit = exponentialModel(beta, T);
Error = zeros(length(Num), 1);
for i = 1:length(Num)
    a = find(Table(:, 1) == Num(i)) - 1;
    Error(i) = mean(abs(ED_fit(a) - ED(a)));
end

%% c
%计算水肿指标的变化率，在不同治疗方法下，改善效率
K=[];
for i=1:length(Num)
    a=find(Table(:,1)==Num(i));
    if length(a)>=5%至少五次检查数据才进行计算
        k=(double(Table(a(2:end),34))-double(Table(a(1:end-1),34)))./(double(Table(a(2:end),3))-double(Table(a(1:end-1),3)));
        kk=find(k<0);
        if length(kk)==0
            K(i,1)=0;
        else
            K(i,1)=mean(k(kk));
        end
    else
        K(i,1)=NaN;
    end
end
c=setdiff([1:length(K)],find(isnan(K)==1));
G=double(Table(2:end,16:22));
Z=Table(1,16:22);
for i=1:length(Z)
    [p(i),anovatab{i},stats{i}]=anova1(K(c),G(c,i)+1,'off');%单因素方差分析
    fa=finv(0.95,anovatab{i}{2,3},anovatab{i}{3,3});%计算fa
    F=anovatab{i}{2,5};%F值
    if p(i)<=0.01 && F>fa
        disp([Z(i)+"对水肿体积进展模式影响非常显著"])
        fprintf('p值为%.4f<0.01，F值为%.2f>%.2f\n',p(i),F,fa)
    elseif p(i)<=0.05 && F>fa
        disp([Z(i)+"对水肿体积进展模式影响显著"])
        fprintf('p值为%.4f<0.05，F值为%.2f>%.2f\n',p(i),F,fa)
    else
        disp([Z(i)+"对水肿体积进展模式影响不显著"])
        fprintf('p值为%.4f，F值为%.2f\n',p(i),F)
    end
end
disp('不同治疗对水肿进展模式的影响大小为：')
[~,q]=sort(p);
str=Z(q)+">";
disp(str)
%% d
%同上述步骤求血肿体积的
%计算水肿指标的变化率，在不同治疗方法下，改善效率
K2=[];
for i=1:length(Num)
    a=find(Table(:,1)==Num(i));
    if length(a)>=5%至少五次检查数据才进行计算
        k=(double(Table(a(2:end),23))-double(Table(a(1:end-1),23)))./(double(Table(a(2:end),3))-double(Table(a(1:end-1),3)));
        kk=find(k<0);
        if length(kk)==0
            K2(i,1)=0;
        else
            K2(i,1)=mean(k(kk));
        end
    else
        K2(i,1)=NaN;
    end
end
c=setdiff([1:length(K2)],find(isnan(K2)==1));
for i=1:length(Z)
    [p2(i),anovatab2{i},stats2{i}]=anova1(K2(c),G(c,i)+1,'off');%单因素方差分析
    fa=finv(0.95,anovatab2{i}{2,3},anovatab2{i}{3,3});%计算fa
    F=anovatab2{i}{2,5};%F值
    if p2(i)<=0.01 && F>fa
        disp([Z(i)+"对血肿肿体积进展模式影响非常显著"])
        fprintf('p值为%.4f<0.01，F值为%.2f>%.2f\n',p2(i),F,fa)
    elseif p2(i)<=0.05 && F>fa
        disp([Z(i)+"对血肿体积进展模式影响显著"])
        fprintf('p值为%.4f<0.05，F值为%.2f>%.2f\n',p2(i),F,fa)
    else
        disp([Z(i)+"对血肿体积进展模式影响不显著"])
        fprintf('p值为%.4f，F值为%.2f\n',p2(i),F)
    end
end
disp('不同治疗对血肿进展模式的影响大小为：')
[~,q2]=sort(p2);
str2=Z(q2)+">";
disp(str2)
%在算下血肿指标与水肿指标的相关性
x0=double(Table(2:end,23));
y0=double(Table(2:end,34));
theta=x0'*y0/(norm(x0)*norm(y0));%余弦相似度
fprintf('血肿指标与水肿指标的相关度为：%.4f\n',theta)