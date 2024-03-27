clc
clear
data=xlsread('水肿与时间表1.xlsx');
table1=[data(:,2) data(:,3) data(:,end);data(:,5) data(:,6) data(:,end);...
    data(:,8) data(:,9) data(:,end);data(:,11) data(:,12) data(:,end);data(:,14) data(:,15) data(:,end);...
    data(:,17) data(:,18) data(:,end);data(:,20) data(:,21) data(:,end);data(:,23) data(:,24) data(:,end);...
    data(:,26) data(:,27) data(:,end)];
for i=size(table1,1):-1:1
   if isnan(table1(i,1))
      table1(i,:)=[]; 
   end
end
table=cell(1,max(table1(:,3)));
for t=1:max(table1(:,3))
   table{1,t}=table1(table1(:,3)==t,:);
   table{1,t}=sort(table{1,t});
end
%颜色
color=[0/255,96/255,115/255;
    9/255,147/255,150/255;
    145/255,211/255,192/255;
    235/255,215/255,165/255;
    238/255,155/255,0/255;
    204/255,102/255,2/255;
    188/255,62/255,3/255;
    174/255,32/255,18/255;
    155/255,34/255,39/255];
%绘制

plot(table{1,2}(:,1),table{1,2}(:,2),'color',color(1,:),'LineWidth',1.5)
hold on
plot(table{1,4}(:,1),table{1,4}(:,2),'color',color(2,:),'LineWidth',1.5)
hold on
plot(table{1,8}(:,1),table{1,8}(:,2),'color',color(3,:),'LineWidth',1.5)
hold on
plot(table{1,9}(:,1),table{1,9}(:,2),'color',color(4,:),'LineWidth',1.5)
hold on
plot(table{1,10}(:,1),table{1,10}(:,2),'color',color(5,:),'LineWidth',1.5)
hold on
plot(table{1,13}(:,1),table{1,13}(:,2),'color',color(6,:),'LineWidth',1.5)
hold on
plot(table{1,14}(:,1),table{1,14}(:,2),'color',color(7,:),'LineWidth',1.5)
hold on
plot(table{1,15}(:,1),table{1,15}(:,2),'color',color(8,:),'LineWidth',1.5)
hold on
plot(table{1,16}(:,1),table{1,16}(:,2),'color',color(9,:),'LineWidth',1.5)
hold on

hXLabel = xlabel('时间/h');
hYLabel = ylabel('水肿体积');
legend('组别2','类别4','类别8','类别9','类别10','类别13','类别14','类别15','类别16')
set(gca, 'FontName', '宋体')
% set([hXLabel, hYLabel], 'FontName', 'Times New Roman')
set(gca, 'FontSize', 12)
set([hXLabel, hYLabel], 'FontSize', 15)
% set(hTitle, 'FontSize', 11, 'FontWeight' , 'bold')
% 背景颜色
set(gcf,'Color',[1 1 1])
xlim([0 1500])