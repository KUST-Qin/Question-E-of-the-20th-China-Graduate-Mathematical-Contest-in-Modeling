clc
clear
data1=xlsread('因子得分预测表.xlsx');
train1=data1(1:100,:);
test1=data1(1:end,1:30);


net=feedforwardnet([10 10 10]);%建立一个隐含层数为1，节点数为10的网络

%定义在训练集过程中不使用测试集，只保留训练集与验证集（用于验证泛化能力）
net.divideParam.trainRatio = 80/100;
net.divideParam.valRatio = 20/100;
net.divideParam.testRatio = 0/100;

%训练网络。
net=train(net,(train1(:,1:(end-1)))',(train1(:,end))');%注意，这里每一列为一个实例，所以需要转置
%测试效果
test_out=sim(net,(test1)');%测试
test_out=test_out';
for i=1:size(test_out,1)
   if test_out(i,1)<0
      test_out(i,1)=0; 
   end
   if test_out(i,1)>1
      test_out(i,1)=1; 
   end
end
% test_error=test_out-test1(:,end);
% test_mse = mse(test_error);
% fprintf('%d',test_mse)

%% 读出Excel
%观察值（实际值）：test1的最后一列
%预测值：test_out。
