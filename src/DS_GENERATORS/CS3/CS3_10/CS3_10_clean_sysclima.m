clear 
%% create exterior climate signal
load('CS3_8_sysclima_clean.mat')
%%
figure(1)
clf
idx = 6;
ids = ds_cell{idx};
%
subplot(3,1,1)
plot(ids.DateTime,ids.EstadoCenitalE)
%
tspan = seconds(ids.DateTime - ids.DateTime(1));
%
subplot(3,1,2)
%
subplot(3,1,3)
%% selecionamos 
logical_ind = (datetime('01-Jan-2017') < ids.DateTime).*(datetime('01-Feb-2017') > ids.DateTime);
logical_ind = logical(logical_ind);

%%
ids = ids(logical_ind,:);
%%

file = 'INSTALL_HortiMED_DataSources.m';
%
file_path   = which(file);
folder_path = replace(file_path,file,'');

save(fullfile(folder_path,'data','MATLAB_FORMAT','CS3_9_sysclima_no_heater.mat'),'ids')

