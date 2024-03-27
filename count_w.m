clc
clear
C=xlsread('BP参数表.xlsx','parameters C');
W=xlsread('BP参数表.xlsx','parameters W');
C=abs(C);
W=abs(W);
I=C'*W;
P=I./sum(I);