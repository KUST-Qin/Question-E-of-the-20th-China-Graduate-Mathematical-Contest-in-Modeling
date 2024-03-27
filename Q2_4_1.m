clc
clear
data=xlsread('BP神经网络读入.xlsx');
net=feedforwardnet([10]);%建立一个隐含层数为1，节点数为10的网络

%定义在训练集过程中不使用测试集，只保留训练集与验证集（用于验证泛化能力）
net.divideParam.trainRatio = 80/100;
net.divideParam.valRatio = 20/100;
net.divideParam.testRatio = 0/100;

%训练网络。
net=train(net,(data(:,1:(end-1)))',(data(:,end))');%注意，这里每一列为一个实例，所以需要转置