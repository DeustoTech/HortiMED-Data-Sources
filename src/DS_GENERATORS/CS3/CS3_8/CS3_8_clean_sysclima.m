
clear 

load('CS3_2_ExteriorClima');
external_ds = ds;

load('CS3_1_Sysclima')
% remove no uniques 
external_ds(diff(external_ds.DateTime ) == 0,:) = [];
%
%
ds.('Aerotermo1Activo')=[];
ds.('Sonda1')=[];
ds.('Sonda2')=[];
ds.('Sonda3')=[];
ds.('Sonda5')=[];
ds.('Sonda6')=[];
ds.('Ventiladores2Activo')=[];
ds.('EstadoLateralE')=[];
ds.('HRExt')=[];
ds.('MinHR')=[];
ds.('DemPant1')=[];
ds.('RadAcumExt')=[];
ds.('Troco')=[];
ds.('DeltaT')=[];
ds.('DeltaX')=[];
ds.('DPV')=[];

%%
ds(ds.Tinv < -7,:) = [];
ds(ds.Tinv >  50,:) = [];
%%
t0 = ds.DateTime(1);
tspan = seconds(external_ds.DateTime - t0);
new_tspan = seconds(ds.DateTime - t0);

HRExt = external_ds.humidity;
sm_HRExt = smoothdata(HRExt,'SmoothingFactor',0.035) ;
inter_HRExt = interp1(tspan,sm_HRExt,new_tspan,'spline');

%
new_id = logical((new_tspan > 0).*(new_tspan < 3600*24*10));
clf
hold on
plot(new_tspan(new_id),inter_HRExt(new_id))

old_id = logical((tspan > 0).*(tspan < 3600*24*10));
plot(tspan(old_id),HRExt(old_id),'.')

plot(tspan(old_id),sm_HRExt(old_id),'.')

%%
ds.HRExt = inter_HRExt;
%% histogram 
iTs = TableSeries(ds);
clf
ShowData(iTs)
%%
iTs_cell = cut(iTs,hours(6));
%%
iTs_cell = UniformTimeStamp(iTs_cell,minutes(5));
%%
clf
ShowData(iTs_cell)
%
%%

clear ds_cell
for ids = 1:length(iTs_cell)
    ds_cell{ids} = iTs_cell(ids).DataSet;
    ds_cell{ids}.DateTime = iTs_cell(ids).DateTime';
end
%%
%%

%%
file = 'INSTALL_HortiMED_DataSources.m';
%
file_path   = which(file);
folder_path = replace(file_path,file,'');

save(fullfile(folder_path,'data','MATLAB_FORMAT','CS3_8_sysclima_clean.mat'),'ds_cell')
