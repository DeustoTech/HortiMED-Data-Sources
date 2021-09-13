clear

%% Dowload Sysclima DataSet on XLSX Format

file = 'CS3_3_production.m';
%
file_path   = which(file);
folder_path = replace(file_path,file,'');

XLSX_path = fullfile(folder_path,'..','..','..','data/GROSS/Producción_Menaka.xlsx');
%
opts = weboptions;
opts.Timeout = 25;

id = '1dOcKpT-ZnOsbi2XhQtvEdFLUugvOdkke';
websave(XLSX_path,"https://drive.google.com/u/0/uc?id="+id+"&export=download")

%% From XLSX to date
%


opts = spreadsheetImportOptions("NumVariables", 8);

% Specify sheet and range
opts.Sheet = "Datos brutos";
opts.DataRange = "A4:H329";

% Specify column names and types
opts.VariableNames = ["FechaDeEntrega", "CdProducto", "DescripcinProducto", "Envase", "CantidadEnvases", "Bruto", "TaraEnvases", "Netokg"];
opts.VariableTypes = ["datetime", "categorical", "categorical", "categorical", "double", "double", "double", "double"];

% Specify variable properties
opts = setvaropts(opts, ["CdProducto", "DescripcinProducto", "Envase"], "EmptyFieldRule", "auto");
opts = setvaropts(opts, "FechaDeEntrega", "InputFormat", "");

% Import the data
ProduccinMenaka = readtable(XLSX_path, opts, "UseExcel", false);

ProduccinMenaka = ProduccinMenaka(:,[1 8]);

% save
folder_path = fullfile(folder_path,'..','..','..','data/MATLAB_FORMAT/CS3_3_production.mat');

save(folder_path,'ProduccinMenaka')
