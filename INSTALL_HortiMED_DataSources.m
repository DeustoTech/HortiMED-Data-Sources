clear 

if ~verLessThan('matlab','9.10.1')
   error('YOUR MATLAB VERSION MUST BE LESS THAN 9.10.1') 
end
%% SETTIGS PATH
main_file = 'INSTALL_HortiMED_DataSources.m';
path_file = which(main_file);
path_file = replace(path_file,main_file,'');

%% CREATE FOLDERS 
mkdir(fullfile('src','dependences'))
mkdir('data')
mkdir('data/GROSS')
mkdir('data/MATLAB_FORMAT')

pause(1)
%% DOWLOAD DEPENDENCES
unzip('https://github.com/djoroya/ModellingAndControl/archive/refs/heads/master.zip',fullfile(path_file,'src','dependences'))

%% ADD FOLDERS
addpath(genpath(path_file))

