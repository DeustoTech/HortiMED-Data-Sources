clear 

load('CS3_1_Sysclima')

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
%% histogram 
iTs = TableSeries(ds);
clf
ShowData(iTs)
%%
iTs_cell = cut(iTs,hours(6));
%%
clf
ShowData(iTs_cell)
%%
ds_cell = arrayfun(@(iTs) iTs.DataSet,iTs_cell,'UniformOutput',0);

for ids = 1:length(ds_cell)
    ds_cell{ids}.DateTime = iTs_cell(ids).DateTime;
end
%%

file = 'INSTALL_HortiMED_DataSources.m';
%
file_path   = which(file);
folder_path = replace(file_path,file,'');

save(fullfile(folder_path,'data','MATLAB_FORMAT','CS3_8_sysclima_clean.mat'),'ds_cell')
