clc
clear
data=xlsread('水肿与时间表1.xlsx');
table=[data(:,2) data(:,3);data(:,5) data(:,6);...
    data(:,8) data(:,9);data(:,11) data(:,12);data(:,14) data(:,15);...
    data(:,17) data(:,18);data(:,20) data(:,21);data(:,23) data(:,24);...
    data(:,26) data(:,27)];
for i=size(table,1):-1:1
   if isnan(table(i,1))
      table(i,:)=[]; 
   end
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
table=sort(table);
plot(table(:,1),table(:,2),'color',color(1,:),'LineWidth',1.5)
hold on

hXLabel = xlabel('时间/h');
hYLabel = ylabel('水肿体积');

set(gca, 'FontName', '宋体')
% set([hXLabel, hYLabel], 'FontName', 'Times New Roman')
set(gca, 'FontSize', 12)
set([hXLabel, hYLabel], 'FontSize', 15)
% set(hTitle, 'FontSize', 11, 'FontWeight' , 'bold')
% 背景颜色
set(gcf,'Color',[1 1 1])
