clear 
%% create exterior climate signal
load('CS3_9_sysclima_no_heater.mat')
%%
figure(1)
clf
hold on

plot(ids.DateTime,ids.EstadoPant1)
%%
log_inx = (ids.DateTime < datetime('06-Jan-2017'));

ids = ids(logical(log_inx),:);
%%
%%
figure(1)
plot(ids.DateTime,ids.EstadoPant1,'--','color','r')
%%
file = 'INSTALL_HortiMED_DataSources.m';
%
file_path   = which(file);
folder_path = replace(file_path,file,'');

save(fullfile(folder_path,'data','MATLAB_FORMAT','CS3_12_sysclima_no_heater_with_screen.mat'),'ids')

%%
