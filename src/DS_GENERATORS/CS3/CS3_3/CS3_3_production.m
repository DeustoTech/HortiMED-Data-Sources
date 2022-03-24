clear

%% Dowload Sysclima DataSet on XLSX Format

file = 'INSTALL_HortiMED_DataSources.m';
%
file_path   = which(file);
folder_path = replace(file_path,file,'');

XLSX_path = fullfile(folder_path,'data/GROSS/Producción_Menaka.xlsx');
%
opts = weboptions;
opts.Timeout = 25;
if ~exist(XLSX_path)
    id = '1dOcKpT-ZnOsbi2XhQtvEdFLUugvOdkke';
    websave(XLSX_path,"https://drive.google.com/u/0/uc?id="+id+"&export=download")
end
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



%%
[~,ind]=sort(ProduccinMenaka.FechaDeEntrega);
prod1 = ProduccinMenaka(ind,:);

prod2_2017_2019 = groupsummary(prod1,'FechaDeEntrega',@sum);
prod2_2017_2019.Properties.VariableNames{3} = 'Neto';
%%

% save
file_path = fullfile(folder_path,'data/MATLAB_FORMAT/CS3_3_production.mat');
%%


save(file_path,'prod2_2017_2019')
