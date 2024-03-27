clc
clear
data1=xlsread('表2-患者影像信息血肿及水肿的体积及位置.xlsx');
data2=xlsread('表3-患者影像信息血肿及水肿的形状及灰度分布.xlsx','Hemo');
table=[];
for i=1:size(data1,1)
    for ii=1:size(data2,1)
        if data2(ii,1)==data1(i,1)
            table=[table;data2(ii,:)];
            break
        end
        if ii==size(data2,1)
            table=[table;zeros(1,size(table,2))];
        end
    end
end