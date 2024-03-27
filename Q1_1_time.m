clc
clear
data=xlsread('1.1时间计算.xlsx');
for p=1:size(data,1) %遍历每一个人
    y=data(p,3);
    m=data(p,4);
    d=data(p,5);
    h=data(p,6);
    min=data(p,7);
    s=data(p,8);
    %下面四舍五入小时
    if s>30
        if min<59
            min=min+1; 
        else %min为59
           min=0;
           h=h+1; %进一位
        end
    end
    if min>30
        h=h+1; %不用管是否超过24
    end
    max_sf=data(p,1)-1;
    if max_sf>8
       max_sf=8; 
    end
    for sf=1:max_sf %遍历每一个随访
        y_sf=data(p,sf*6+3);
        m_sf=data(p,sf*6+4);
        d_sf=data(p,sf*6+5);
        h_sf=data(p,sf*6+6);
        min_sf=data(p,sf*6+7);
        s_sf=data(p,sf*6+8);
        %下面四舍五入小时
        if s_sf>30
            if min_sf<59
                min_sf=min_sf+1;
            else %min为59
                min_sf=0;
                h_sf=h_sf+1; %进一位
            end
        end
        if min>30
            h_sf=h_sf+1; %不用管是否超过24
        end
        temp_table=[y m d h;y_sf m_sf d_sf h_sf];
        if temp_table(1,1)~=temp_table(2,1) %以防万一有隔年的
           error('停！') 
        end
        if temp_table(1,2)==temp_table(2,2) %如果月份相同
            if temp_table(1,3)==temp_table(2,3) %如果月相同日相同
                gap=temp_table(2,4)-temp_table(1,4); %直接相减
            else %如果月相同，日不同
                new_h=temp_table(2,4)+(temp_table(2,3)-temp_table(1,3))*24;
                gap=new_h-temp_table(1,4);
            end
        else %如果月份不同
            gap_m=[temp_table(1,2):1:temp_table(2,2)-1]; %获取间隔的月份
            t_day=get_mday(gap_m(1)); %获取第一个月的天数
            gap_day_1=t_day-temp_table(1,3); %计算第一个月的天数差额
            if size(gap_m,2)>=2 %如果中间还有间隔
                for mm=2:size(gap_m,2)
                    t_day=get_mday(gap_m(mm)); %获取第mm个月的天数
                    gap_day_1=gap_day_1+t_day;
                end
            end
            gap_day=gap_day_1+temp_table(2,3); %总日期间隔
            new_h=temp_table(2,4)+gap_day*24;
            gap=new_h-temp_table(1,4);
        end
        table(p,sf)=gap;
    end
end
for p=1:size(table,1)
    for j=1:size(table,2)
       if table(p,j)~=0
           table(p,j)=table(p,j)+data(p,2);
       else
           table(p,j)=NaN;
       end
    end
end

%% 获取每个月的日期数
function t_day=get_mday(m)
m31=[1 3 5 7 8 10 12];
if ismember(m,m31)
    t_day=31;
elseif m==2
    t_day=28;
else
    t_day=30;
end
end