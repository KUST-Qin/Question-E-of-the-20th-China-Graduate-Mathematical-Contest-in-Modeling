clc
clear
data=xlsread('前100名患者预测与对照值.xlsx');
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

plot([1:1:100],data(:,1),'color',color(1,:),'LineWidth',1.5)
hold on
plot([1:1:100],data(:,2),'color',color(5,:),'LineWidth',1.5)
hold on

hXLabel = xlabel('患者');
hYLabel = ylabel('mRS');

set(gca, 'FontName', '宋体')
% set([hXLabel, hYLabel], 'FontName', 'Times New Roman')
set(gca, 'FontSize', 12)
set([hXLabel, hYLabel], 'FontSize', 15)
% set(hTitle, 'FontSize', 11, 'FontWeight' , 'bold')
% 背景颜色
set(gcf,'Color',[1 1 1])
legend('预测值','实际值')