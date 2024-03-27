clc
clear
data=xlsread('分组表.xlsx');
d=1000000*data(:,1)+100000*data(:,2)+10000*data(:,3)+1000*data(:,4)+100*data(:,5)+10*data(:,6)+data(:,7);
u_d=unique(d);
for t=1:size(u_d,1)
   for i=1:size(d,1)
      if d(i,1)==u_d(t,1)
         table(i,1)=t; 
      end
   end
end