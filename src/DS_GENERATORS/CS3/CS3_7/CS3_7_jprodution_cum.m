clear
load('CS3_6_all_production')
%%
plot(ds_prod.DateTime,cumsum(ds_prod.MatureFruit))

%%

select = ds_prod.DateTime == datetime('03-Aug-2017');


indexs = find(diff(ds_prod.DateTime)>days(12));


id_start = 1;
clear new_ds_prod;
for id = 1:length(indexs)
   
    id_end   = indexs(id);

    new_ds_prod{id} = ds_prod(id_start:id_end,:);
    
    id_start = (id_end+1); 
end

%%
figure(1)
clf
hold on
for ids = new_ds_prod
   plot(ids{:}.DateTime,ids{:}.MatureFruit) 
end

%% create cumsum
clf
hold on
for ids = new_ds_prod
   plot(ids{:}.DateTime,cumsum(ids{:}.MatureFruit),'.')
end
%%

file = 'INSTALL_HortiMED_DataSources.m';
%
file_path   = which(file);
folder_path = replace(file_path,file,'');

save(fullfile(folder_path,'data','MATLAB_FORMAT','CS3_7_all_cum_production.mat'),'new_ds_prod')
