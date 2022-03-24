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