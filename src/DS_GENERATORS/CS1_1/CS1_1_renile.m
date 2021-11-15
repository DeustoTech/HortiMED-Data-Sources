clear 
%%

file = 'CS3_1_SysClima.m';
%
file_path   = which(file);
folder_path = replace(file_path,file,'');


%%

import matlab.net.http.*
import matlab.net.http.field.*


token = 'oGNqMCH0eWmi0a2xvVWIVpLWtJdyaa8B2XWHERKvdyyUr6lUJaLUKszdQ6Gsvh6fTLQPnWEyTSgmF2LUbDawwA==';

headers = [ ContentTypeField(  'application/vnd.flux'  ), ...
            AcceptField(       'application/csv'       ), ...
            AuthorizationField('Authorization',"Token "+token                   )];
  
  %%      
body = matlab.net.http.MessageBody('from(bucket:"Egypt") |> range(start: -10d)');
body = matlab.net.http.MessageBody('from(bucket:"Egypt") |> range(start: -30d)|> aggregateWindow(every: 1h, fn: mean)');

%%
request = RequestMessage( 'POST',headers,body);
%%
org = "6ca3aa4b9c7becd5";
uri = 'http://ec2-34-248-89-116.eu-west-1.compute.amazonaws.com:8086/api/v2/query?org='+org;
r = send(request,uri);

%%
ds = r.Body.Data;
ndata = size(ds,1);

sensors = unique(ds.SensorName(1:ndata));
type_ms = unique(ds.x_measurement(1:ndata));
%
DT = arrayfun(@(i) datetime(replace(ds.x_time{i}(1:end-1),'T',' ')),1:ndata,'UniformOutput',1);

%%
%%
i = 0;
dataset = [];

field_names = {};

i = 0;
for isensor = sensors'
    i = i + 1;
    j = 0;
    for itype = type_ms'
        j = j + 1;
        %
        field = replace(isensor+"___"+itype,' ','');
        field = replace(field,'-','_');
        field = replace(field,'%','_');
        %
        
        b1 = strcmp(ds.SensorName(1:ndata),isensor);
        b2 = strcmp(ds.x_measurement(1:ndata),itype);
            
        dataset(i,j).value =  ds.x_value(logical(b1.*b2),1);
        dataset(i,j).DateTime =  DT(logical(b1.*b2));
        dataset(i,j).Name  = field;
        

    end
end
%%
%%
clf
for i = 1:size(dataset,2)
    subplot(3,size(dataset,2)/3,i)
    hold on
    for j = 1:size(dataset,1)
        plot(dataset(j,i).DateTime,dataset(j,i).value)
    end
    name = strsplit([dataset(1,i).Name]','___');
    title(name(end),'Interpreter','none');
    legend(dataset(:,i).Name,'Interpreter','none')
end

%%
save(fullfile(folder_path,'..','..','..','data','MATLAB_FORMAT','CS1_1_renile.mat'),'dataset')