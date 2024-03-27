clc
clear
data=xlsread('水肿与时间表1.xlsx');
table=[data(:,2) data(:,3) data(:,end);data(:,5) data(:,6) data(:,end);...
    data(:,8) data(:,9) data(:,end);data(:,11) data(:,12) data(:,end);data(:,14) data(:,15) data(:,end);...
    data(:,17) data(:,18) data(:,end);data(:,20) data(:,21) data(:,end);data(:,23) data(:,24) data(:,end);...
    data(:,26) data(:,27) data(:,end)];
for i=size(table,1):-1:1
   if isnan(table(i,1))
      table(i,:)=[]; 
   end
end
table1=table(table(:,3)==1,:);
table2=table(table(:,3)==2,:);
table3=table(table(:,3)==3,:);
table4=table(table(:,3)==4,:);

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
table1=sort(table1);
table2=sort(table2);
table3=sort(table3);
table4=sort(table4);
plot(table1(:,1),table1(:,2),'color',color(1,:),'LineWidth',1.5)
hold on
plot(table2(:,1),table2(:,2),'color',color(2,:),'LineWidth',1.5)
hold on
plot(table3(:,1),table3(:,2),'color',color(3,:),'LineWidth',1.5)
hold on
plot(table4(:,1),table4(:,2),'color',color(4,:),'LineWidth',1.5)
hold on

hXLabel = xlabel('时间/h');
hYLabel = ylabel('水肿体积');
legend('类别1','类别2','类别3','类别4')
set(gca, 'FontName', '宋体')
% set([hXLabel, hYLabel], 'FontName', 'Times New Roman')
set(gca, 'FontSize', 12)
set([hXLabel, hYLabel], 'FontSize', 15)
% set(hTitle, 'FontSize', 11, 'FontWeight' , 'bold')
% 背景颜色
set(gcf,'Color',[1 1 1])

