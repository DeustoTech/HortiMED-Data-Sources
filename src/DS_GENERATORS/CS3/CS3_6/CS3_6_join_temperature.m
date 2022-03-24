clear
load('CS3_4_production')
load('CS3_3_production')

%%
prod2_2017_2019(prod2_2017_2019.FechaDeEntrega > datetime('01-Jan-2020'),:) = [];
%% 
clear ds
ds.DateTime =    [ prod2_2017_2019.FechaDeEntrega  ; prod2_2020_2021.FechaDeEntrega];
ds.MatureFruit = [ prod2_2017_2019.Neto            ; prod2_2020_2021.Neto	        ];
%%
ds = struct2table(ds);
%%
clf
subplot(2,1,1)
hold on
plot(prod2_2017_2019.FechaDeEntrega,prod2_2017_2019.Neto,'.-')
plot(prod2_2020_2021.FechaDeEntrega,prod2_2020_2021.Neto,'.--')
subplot(2,1,2)
plot(ds.DateTime,ds.MatureFruit,'.-')
grid on

%%

file = 'INSTALL_HortiMED_DataSources.m';
%
file_path   = which(file);
folder_path = replace(file_path,file,'');

ds_prod = ds;
save(fullfile(folder_path,'data','MATLAB_FORMAT','CS3_6_all_production.mat'),'ds_prod')