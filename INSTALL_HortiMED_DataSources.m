clear 

if ~verLessThan('matlab','9.10.1')
   error('YOUR MATLAB VERSION MUST BE LESS THAN 9.10.1') 
end

%% SETTIGS PATH
main_file = 'INSTALL_HortiMED_DataSources.m';
path_file = which(main_file);
path_file = replace(path_file,main_file,'');

path_depen = fullfile(path_file,'src','dependences');
path_data = fullfile(path_file,'data');


%% clean 
try rmdir(path_data,'s')
catch  err
end
try rmdir(path_depen,'s')
catch  err
end

%% CREATE FOLDERS 

mkdir(path_depen)
mkdir('data')
mkdir('data/GROSS')
mkdir('data/MATLAB_FORMAT')

%%
unzip('https://github.com/djoroya/MechanisticSolarRadiationModel/archive/refs/heads/main.zip',path_depen)
unzip('https://github.com/djoroya/ModellingAndControl/archive/refs/heads/master.zip',path_depen)

%% ADD FOLDERS
addpath(genpath(path_file))

