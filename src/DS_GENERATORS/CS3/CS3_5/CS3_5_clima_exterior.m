
clear
range_days = [datetime('2016-01-01') datetime('2016-01-01')+days(366)]
%% OpenWeatherMap
load('CS3_2_ExteriorClima')

iTs = TableSeries(ds);
iTs   = subselect_date(iTs,range_days);
ds = iTs.DataSet;
Te = ds.temp;
Re = ds.RadCloud;
He = ds.humidity;
VV = ds.wind_speed;
day_of_year = day(iTs.DateTime,'dayofyear');
hour_of_day = hour(iTs.DateTime);

t0 = iTs.DateTime(1);
tspan = days(iTs.DateTime - t0);

%
new_tspan = linspace(tspan(1),tspan(end),3*length(tspan));
%%
Te_s = smoothdata(Te,'gaussian','SmoothingFactor',0.015);
newTe = interp1(tspan,Te_s,new_tspan,'spline');

%%
He_s = smoothdata(He,'gaussian','SmoothingFactor',0.05);
newHe = interp1(tspan,He_s,new_tspan,'pchip');

%%
Re_s = smoothdata(Re,'gaussian','SmoothingFactor',0.003);
newRe = interp1(tspan,Re_s,new_tspan,'makima');
%%
VV_s = smoothdata(VV,'gaussian','SmoothingFactor',0.02);
newVV = interp1(tspan,VV_s,new_tspan,'spline');
newVV(newVV<0) = 0;
%%
%

ods.T = newTe';
ods.R = newRe';
ods.H = newHe';
ods.V = newVV';
ods.DateTime = iTs.DateTime(1) + days(new_tspan)';
ods.tspan = new_tspan';
%
ods = struct2table(ods)
%%

file = 'CS3_5_clima_exterior.m';
%
file_path   = which(file);
folder_path = replace(file_path,file,'');

%%
pathsave = fullfile(folder_path,'..','..','..','..','data','MATLAB_FORMAT','CS3_5_ExteriorClima.mat');
save(pathsave,'ods')