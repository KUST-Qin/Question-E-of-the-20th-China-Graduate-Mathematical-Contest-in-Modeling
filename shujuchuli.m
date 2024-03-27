clear
clc

%读取数据
[~,~,data_a]=xlsread('表1-患者列表及临床信息.xlsx','A1:W161');
data_a=string(data_a);
data_a(find(ismissing(data_a)==1))="";
data_a=[data_a(:,1:15),[["血压最大值","血压最小值"];split(data1(2:end,16),"/")],data_a(:,17:end)];
data_a(find(data_a=="男"))="1";
data_a(find(data_a=="女"))="0";
[~,~,data_b]=xlsread('表2-患者影像信息血肿及水肿的体积及位置.xlsx','A1:GZ161');
data_b=string(data_b);
data_b(find(ismissing(data_b)==1))="";
[~,~,data_c]=xlsread('表3-患者影像信息血肿及水肿的形状及灰度分布.xlsx','B1:AG577');
data_c=string(data_c);
data_c(find(ismissing(data_c)==1))="";
[~,~,data_d]=xlsread('附表1-检索表格-流水号vs时间.xlsx','C2:AB161');
data_d=string(data_d);
data_d(find(ismissing(data_d)==1))="";

%整理数据
Table=["患者","流水号","时间/小时",data_a(1,[5:14,16:24]),data_b(1,3:24),data_b(1,2:32)];%记录指标数据
for i=1:size(data_a,1)-1
    delta_t0=double(data_a(i+1,15));%从发病到第一次诊断时的时间长度
    a=find(data_d==data_a(i+1,4));
    a1=mod(a,160);
    if a1==0
        a1=160;
    end
    a2=ceil(a/160);
    t1=data_d(a1,a2-1);%第一次诊断日期
    table1=data_a(i+1,[5:14,16:24]);
    table2=data_b(i+1,2:208);
    %识别检查了多少次
    a=find(table2=="");
    if length(a)==0
        a=length(table2);
    else
        a=a(1);
    end
    n=(a-1)/23;
    %统计每次检查的数据，如果有缺失则不记录
    for j=1:n
        a=find(data_d==table2((j-1)*23+1));
        a1=mod(a,160);
        if a1==0
            a1=160;
        end
        a2=ceil(a/160);
        t2=data_d(a1,a2-1);
        time=max((datenum(t2)-datenum(t1))*24+delta_t0,0);%以刚发病时刻为0，计算时间轴上第j次随诊距离发病的时间长度
        if length(find(data_c(:,1)==table2((j-1)*23+1))>0)
            x=[data_a(i+1,1),table2((j-1)*23+1),time,table1,table2((j-1)*23+2:j*23),data_c(find(data_c(:,1)==table2((j-1)*23+1)),2:end)];
        else%如果缺失则取样本差距前三个数据集的附件3指标取平均值补充
            x1=[double(table2((j-1)*23+2:j*23));double(Table(2:end,23:44))];
            x1=mapminmax(x1',0,1)';%数据标准化
            d=pdist2(x1(1,:),x1(2:end,:));
            [~,o]=sort(d);
            o=o(1:min(3,length(o)));
            x=[data_a(i+1,1),table2((j-1)*23+1),time,table1,table2((j-1)*23+2:j*23),mean(double(Table((o+1),45:75)),1)];
        end
        Table=[Table;x];
    end
end
save data Table
