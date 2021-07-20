clear

%% Dowload Sysclima DataSet on XLSX Format

file = 'CS3_1_SysClima.m';
%
file_path   = which(file);
folder_path = replace(file_path,file,'');

folder_path = fullfile(folder_path,'..','data/E0_2016_2017_2018_2019_Menaka.xlsx');
%
websave(folder_path,'https://drive.google.com/u/0/uc?id=1ntcuCD2Kbu32FaNiSWqP80BOhgNPl-Z_&export=download')

%% From XLSX to date
addpath('functions')

%
clear 
%%
T2016_S2 = sysclima_2016_S2;
T2017_S1 = sysclima_2017_S1;
T2017_S2 = sysclima_2017_S2;
T2018_S1 = sysclima_2018_S1;
T2018_S2 = sysclima_2018_S2;
T2019_S1 = sysclima_2019_S1;

%%
FullData = {T2016_S2, ...
            T2017_S1,T2017_S2  , ...
            T2018_S1,T2018_S2  , ...
            T2019_S1 };
        
%%
fullvars = {};
for i = 1:6
    fullvars = [fullvars, FullData{i}.Properties.VariableNames{:}];
end
fullvars = unique(fullvars);

%%
fullst = [];

for ivar = fullvars
    fullst.(ivar{:}) = [];
end
%
for ivar = fullvars
    for i = 1:6
        ndata = size(FullData{i},1);
        if strcmp(ivar,'VarName1')
            fullst.(ivar{:}) = [ fullst.(ivar{:}); FullData{i}.(ivar{:}) ];
        else
            try 
                if isa(FullData{i}.(ivar{:}),'string') 
                    fullst.(ivar{:}) = [ fullst.(ivar{:}); double(FullData{i}.(ivar{:})) ];
                else
                    fullst.(ivar{:}) = [ fullst.(ivar{:}); FullData{i}.(ivar{:})         ];
                end
            catch err 
                fullst.(ivar{:}) = [ fullst.(ivar{:}); nan(ndata,1)];

            end
        end
    end
end
%%
ds = struct2table(fullst);
ds.Properties.VariableNames{29} = 'DateTime';
%%
ds.DateTime = datetime(ds.DateTime);