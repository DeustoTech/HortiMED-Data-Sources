function E02016201720182019MenakaS5 = sysclima_2019_S1(XLSX_path)

%% Import data from spreadsheet
% Script for importing data from the following spreadsheet:
%
%    Workbook: /Users/djoroya/Dropbox/My Mac (Deyviss’s MacBook Pro)/Documents/GitHub/ModellingAndControl/TimeSeries/Horti_MED/SPAIN/CLIMA/2020-04-26-SYSCLIMA/A000_RelatedFiles/Sysclima/E0_2016_2017_2018_2019_Menaka.xlsx
%    Worksheet: E0_S1_2019
%
% Auto-generated by MATLAB on 25-Apr-2021 11:26:05

%% Set up the Import Options and import the data
opts = spreadsheetImportOptions("NumVariables", 30);

% Specify sheet and range
opts.Sheet = "E0_S1_2019";
opts.DataRange = "A3:AD74667";

% Specify column names and types
opts.VariableNames = ["VarName1", "VarName2", "Text", "HRExt", "RadExt", "Vviento", "DireccinViento", "RadAcumExt", "AlarmaLluvia", "AlarmaVto", "Tinv", "Troco", "RadInt", "DemPant1", "EstadoPant1", "TVentilacin", "EstadoCenitalE", "EstadoCenitalO", "MaxHR", "MinHR", "DeltaX", "DeltaT", "DPV", "HRInt", "Ventiladores2Activo", "Sonda1", "Sonda2", "Sonda3", "Sonda5", "Sonda6"];
opts.VariableTypes = ["string", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];

% Specify variable properties
opts = setvaropts(opts, "VarName1", "WhitespaceRule", "preserve");
opts = setvaropts(opts, "VarName1", "EmptyFieldRule", "auto");

% Import the data
E02016201720182019MenakaS5 = readtable(XLSX_path,opts);

%% Clear temporary variables
clear opts
end

