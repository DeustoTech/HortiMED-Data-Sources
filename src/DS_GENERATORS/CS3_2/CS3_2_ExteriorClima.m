clear

%% Dowload Sysclima DataSet on XLSX Format

file = 'CS3_2_ExteriorClima.m';
%
file_path   = which(file);
folder_path = replace(file_path,file,'');

csv_path = fullfile(folder_path,'..','..','..','data/GROSS/ExteriorClima.csv');
%
websave(csv_path,'https://drive.google.com/u/0/uc?id=1IgeSiQX78wgLdHXctOr6MPnp7Bx8f15x&export=download')

%%
opts = delimitedTextImportOptions("NumVariables", 25);

% Specify range and delimiter
opts.DataLines = [1, Inf];
opts.Delimiter = [",", ";"];

% Specify column names and types
opts.VariableNames = ["dt"    , "dt_iso", "timezone", "city_name"  , "lat"   , "lon"   , "temp"  , "feels_like", "temp_min", "temp_max", "pressure", "sea_level", "grnd_level", "humidity", "wind_speed", "wind_deg", "rain_1h", "rain_3h", "snow_1h", "snow_3h", "clouds_all", "weather_id", "weather_main", "weather_description", "weather_icon"];
opts.VariableTypes = ["double", "string", "double"  , "categorical", "double", "double", "double", "double"    , "double"  , "double"  , "double"  , "string"   , "string"    , "double"  , "double", "double", "double", "double", "double", "double", "double", "double", "categorical", "categorical", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
%opts.ConsecutiveDelimitersRule = "join";

% Specify variable properties
opts = setvaropts(opts, ["dt_iso", "sea_level", "grnd_level"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["dt_iso", "city_name", "sea_level", "grnd_level", "weather_main", "weather_description"], "EmptyFieldRule", "auto");
opts = setvaropts(opts, ["rain_3h", "snow_1h", "snow_3h", "weather_icon"], "TrimNonNumeric", true);
opts = setvaropts(opts, ["rain_3h", "snow_1h", "snow_3h", "weather_icon"], "ThousandsSeparator", ",");

% Import the data
ExteriorClima = readtable(csv_path, opts);


%%
ExteriorClima = ExteriorClima(2:end,:);
ExteriorClima.dt_iso = arrayfun(@(i) datetime(ExteriorClima.dt_iso{i}(1:end-10)),1:size(ExteriorClima,1))';

%%
ExteriorClima.Properties.VariableNames{2} = 'DateTime';


rmv = {'dt','timezone','city_name','lat','lon','feels_like','sea_level','grnd_level','rain_1h','rain_3h','snow_1h','snow_3h','weather_main','weather_description','weather_icon'};

for ivar = rmv 
    ExteriorClima.(ivar{:}) = [];
end
%%
iTs = TableSeries(ExteriorClima);

folder_path = fullfile(folder_path,'..','..','..','data/MATLAB_FORMAT/CS3_2_ExteriorClima.mat');
save(folder_path,'iTs')
