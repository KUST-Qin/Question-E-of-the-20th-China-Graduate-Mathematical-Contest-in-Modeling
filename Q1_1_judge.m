clc
clear
data=xlsread('a表.xlsx');
for p=1:size(data,1)
   fv=data(p,3); %首次体积 
   for sf=1:8
       if isnan(data(p,3*(sf+1))) %判断是否为空
          break 
       end
       new_fv=data(p,3*(sf+1));
       if new_fv-fv>=6||(new_fv-fv)/fv>=0.33
           if data(p,3*(sf+1)-1)<=48
               table(p,1)=1;
               table(p,2)=data(p,3*(sf+1)-1);
           end
       end
   end
end
% for i=1:size(table,1)
%    for j=1:2
%       if ~table(i,j)
%          table(i,j)=NaN; 
%       end
%    end
% end