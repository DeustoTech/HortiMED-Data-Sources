clear 

if ~verLessThan('matlab','9.10.1')
   error('YOUR MATLAB VERSION MUST BE LESS THAN 9.10.1') 
end

%% SETTIGS PATH
main_file = 'INSTALL_HortiMED_DataSources.m';
path_file = which(main_file);
path_file = replace(path_file,main_file,'');


%% clean 
try 
    rmdir('data','s')
catch  err
    err
end


%% CREATE FOLDERS 
mkdir(fullfile('src','dependences'))
mkdir('data')
mkdir('data/GROSS')
mkdir('data/MATLAB_FORMAT')

%%

%% ADD FOLDERS
addpath(genpath(path_file))

