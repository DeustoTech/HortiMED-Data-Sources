%%
clear
%time = [datetime('01-Feb-2022'),datetime('28-Mar-2022')];
time = [datetime('13-Oct-2021'),datetime('06-Dec-2021')];

data = NIOFDataCall(time);
%%
DateTime = data.DateTime;
Te    = data.ambient_temp_Biological_filter_P_5;
T_GH3 = data.ambient_temp_Fish_Pond_P_1;
T_GH1 = data.ambient_temp_NFT_P_9;
T_GH2 = data.ambient_temp_RT_P_6;

%%
Latitud = 30.45846869104686;
Longitud =  30.55153477683711;
%
rad =[];
HRA = [];
DGMT = +0; % Egypt
iter = 0;
for iLT = DateTime'
    iter = iter + 1;
    rad(iter) = DateTime2Rad(iLT,Longitud,Latitud,DGMT);
end

%%
%%
figure(1)
clf
hold on
plot(DateTime,Te)
%
% plot(DateTime,T_GH3)
% %
% plot(DateTime,T_GH2)
% %
% plot(DateTime,T_GH1)
%
%
yyaxis right

plot(DateTime,rad)


legend('T_e','T_{GH_3}','T_{GH_2}','T_{GH_1}')


%%
data.Rad = rad';
%
file = 'INSTALL_HortiMED_DataSources.m';

file_path   = which(file);
folder_path = replace(file_path,file,'');

save(fullfile(folder_path,'data','MATLAB_FORMAT','CS1_3_renile.mat'),'data')
