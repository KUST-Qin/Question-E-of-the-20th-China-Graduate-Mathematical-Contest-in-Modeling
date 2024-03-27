clc
clear
d=xlsread('spss输出相关性表.xlsx');
data=d(1:3:end,:);


string_name={'年龄','发病到首次影像检查时间间隔','收缩压','舒张压','HM_volume','HM_ACA_R_Ratio','HM_MCA_R_Ratio','HM_PCA_R_Ratio','HM_Pons_Medulla_R_Ratio','HM_Cerebellum_R_Ratio','HM_ACA_L_Ratio','HM_MCA_L_Ratio','HM_PCA_L_Ratio','HM_Pons_Medulla_L_Ratio','HM_Cerebellum_L_Ratio','ED_volume','ED_ACA_R_Ratio','ED_MCA_R_Ratio','ED_PCA_R_Ratio','ED_Pons_Medulla_R_Ratio','ED_Cerebellum_R_Ratio','ED_ACA_L_Ratio','ED_MCA_L_Ratio','ED_PCA_L_Ratio','ED_Pons_Medulla_L_Ratio','ED_Cerebellum_L_Ratio','original_shape_Elongation_HM','original_shape_Flatness_HM','original_shape_LeastAxisLength_HM','original_shape_MajorAxisLength_HM','original_shape_Maximum2DDiameterColumn_HM','original_shape_Maximum2DDiameterRow_HM','original_shape_Maximum2DDiameterSlice_HM','original_shape_Maximum3DDiameter_HM','original_shape_MeshVolume_HM','original_shape_MinorAxisLength_HM','original_shape_Sphericity_HM','original_shape_SurfaceArea_HM','original_shape_SurfaceVolumeRatio_HM','original_shape_VoxelVolume_HM','NCCT_original_firstorder_10Percentile_HM','NCCT_original_firstorder_90Percentile_HM','NCCT_original_firstorder_Energy_HM','NCCT_original_firstorder_Entropy_HM','NCCT_original_firstorder_InterquartileRange_HM','NCCT_original_firstorder_Kurtosis_HM','NCCT_original_firstorder_Maximum_HM','NCCT_original_firstorder_MeanAbsoluteDeviation_HM','NCCT_original_firstorder_Mean_HM','NCCT_original_firstorder_Median_HM','NCCT_original_firstorder_Minimum_HM','NCCT_original_firstorder_Range_HM','NCCT_original_firstorder_RobustMeanAbsoluteDeviation_HM','NCCT_original_firstorder_RootMeanSquared_HM','NCCT_original_firstorder_Skewness_HM','NCCT_original_firstorder_Uniformity_HM','NCCT_original_firstorder_Variance_HM','original_shape_Elongation_ED','original_shape_Flatness_ED','original_shape_LeastAxisLength_ED','original_shape_MajorAxisLength_ED','original_shape_Maximum2DDiameterColumn_ED','original_shape_Maximum2DDiameterRow_ED','original_shape_Maximum2DDiameterSlice_ED','original_shape_Maximum3DDiameter_ED','original_shape_MeshVolume_ED','original_shape_MinorAxisLength_ED','original_shape_Sphericity_ED','original_shape_SurfaceArea_ED','original_shape_SurfaceVolumeRatio_ED','original_shape_VoxelVolume_ED','NCCT_original_firstorder_10Percentile_ED','NCCT_original_firstorder_90Percentile_ED','NCCT_original_firstorder_Energy_ED','NCCT_original_firstorder_Entropy_ED','NCCT_original_firstorder_InterquartileRange_ED','NCCT_original_firstorder_Kurtosis_ED','NCCT_original_firstorder_Maximum_ED','NCCT_original_firstorder_MeanAbsoluteDeviation_ED','NCCT_original_firstorder_Mean_ED','NCCT_original_firstorder_Median_ED','NCCT_original_firstorder_Minimum_ED','NCCT_original_firstorder_Range_ED','NCCT_original_firstorder_RobustMeanAbsoluteDeviation_ED','NCCT_original_firstorder_RootMeanSquared_ED','NCCT_original_firstorder_Skewness_ED','NCCT_original_firstorder_Uniformity_ED','NCCT_original_firstorder_Variance_ED','90天mRS'};
xvalues = string_name;
yvalues = string_name;
h=heatmap(xvalues,yvalues,data, 'FontSize',10, 'FontName','宋体');
color = ncl_colormap('cmocean_gray');
% color = [250/255,127/255,111/255;
%     130/255,176/255,210/255;
%     190/255,184/255,220/255;
%     231/255,218/255,210/255;
%     153/255,153/255,153/255];
colormap(color)
set(gcf,'Color',[1 1 1])
function color = ncl_colormap(colorname)

temp = import_ascii([colorname '.rgb']);
temp(1:2) = [];
temp = split(temp,'#');
temp = temp(:,1);
% color = deblank(color);
temp = strtrim(temp);
temp = regexp(temp, '\s+', 'split');
for i=1:size(temp,1)
    color(i,:) = str2double(temp{i});    
end
color = color/255;
end

function ascii = import_ascii(file_name)
i = 1;
fid = fopen(file_name);
while feof(fid) ~= 1
    tline = fgetl(fid);
    ascii{i,1} = tline; i = i + 1;
end
fclose(fid);
end