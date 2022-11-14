clear 

load('/Users/djoroya/Dropbox/My Mac (Deyviss’s MacBook Pro)/Documents/GitHub/projects/HortiMED/code/D2.4-D2.5-HortiMED/src/dev/HortiMED-Data-Sources-main/data/MATLAB_FORMAT/CS1_7_niof_2019.mat')

%
ds = ds(2:end,:);

%%
dt_string = char(ds.dt_iso);

DateTime = datetime(dt_string(:,1:19),'Format','yyyy-MM-dd HH:mm:ss');
%%
T = ds.temp - 273.15;
H = ds.humidity;
W = ds.wind_speed;
C = ds.clouds_all;
%%
%%
Latitud = 30.45846869104686;
Longitud =  30.55153477683711;
%
rad =[];
HRA = [];
DGMT = +0; % Egypt
iter = 0;

R = DateTime2Rad(DateTime,Longitud,Latitud,DGMT);

%
RC = (1 - 0.5*C/100).*R;

%%
newds.temperature = T;
newds.humidity    = H;
newds.wind        = W;
newds.radiation   = RC;

%%
pathfile =     '/Users/djoroya/Dropbox/My Mac (Deyviss’s MacBook Pro)/Documents/GitHub/projects/HortiMED/code/D2.4-D2.5-HortiMED/src/dev/HortiMED-Data-Sources-main/data/MATLAB_FORMAT/CS1_8_niof_2019.mat';

save(pathfile,'newds')