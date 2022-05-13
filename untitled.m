clear
load('CS1_2_renile')
data = data(1:5:end,:);
%%
clf
plot(data.DateTime,data.ambient_temp_Biological_filter_P_5)

hourtime = hour(data.DateTime) + minute(data.DateTime)/60;
hourtime = cos(hourtime) ;
%%
tspan = days(data.DateTime - data.DateTime(1));

%
Te = data.ambient_temp_Biological_filter_P_5;
Rad = data.Rad;
%
tspan(isnan(Te)) = [];
Rad(isnan(Te)) = [];
hourtime(isnan(Te)) = [];
Te(isnan(Te)) = [];

Te_sm = smoothdata(Te,'lowess','SmoothingFactor',0.25);

%
dTe = gradient(Te_sm,tspan);
dTe_sm = smoothdata(dTe,'lowess','SmoothingFactor',0.01);

ddTe = gradient(dTe_sm,tspan);
ddTe_sm = smoothdata(ddTe,'lowess','SmoothingFactor',0.01);
%

%%
Te_sm = normalize(Te_sm);
dTe_sm = normalize(dTe_sm);
ddTe_sm = normalize(ddTe_sm);

%%
clf 
hold on
plot(tspan,Te);
plot(tspan,Te_sm);
yyaxis right
plot(tspan,Rad);

Rad800 = Rad/800;
%%
clf
hold on
plot(tspan,dTe)
%%
clf
hold on
plot(tspan,ddTe)
%%
if false 
clf
hold on
plot3(Te_sm,dTe_sm,ddTe_sm,'color',[1 1 1]*0.8)
scatter3(Te_sm,dTe_sm,ddTe_sm,[],1:length(Te),'Marker','.')
colormap hot
grid on
view(45,45)
ip = plot3(Te_sm(1),dTe_sm(1),ddTe_sm(1),'Marker','.','MarkerSize',30,'color','g');
for it = 1:length(tspan)
    ip.XData = Te_sm(it);
    ip.YData = dTe_sm(it);
    ip.ZData = ddTe_sm(it);
    pause(0.05)
end
end
%%
Te_data = [Te_sm dTe_sm ddTe_sm];
%
input_data = [Te_data(1:end-2,:) Te_data(2:end-1,:)];
output_data = Te_data(3:end,:) - Te_data(2:end-1,:);
%%


%%
%inet = cascadeforwardnet([6 6 ]);
inet = feedforwardnet([6 6 6]);
inet.performParam.regularization = 1e-7;
inet = train(inet,input_data',output_data');
%%
Nt = 100;


clf
subplot(2,1,1)
hold on
plot3(Te_sm(1:Nt),dTe_sm(1:Nt),ddTe_sm(1:Nt),'color',[1 1 1]*0.8)
scatter3(Te_sm(1:Nt),dTe_sm(1:Nt),ddTe_sm(1:Nt),[],1:Nt,'Marker','.')
colormap hot
grid on
view(45,45)
data_0 = Te_data(1,:)';
data_1 = Te_data(2,:)';

ip = plot3(data_1(1),data_1(2),data_1(3),'Marker','.','MarkerSize',30,'color','g');
ip2 = plot3(Te_sm(2),dTe_sm(2),ddTe_sm(2),'Marker','.','MarkerSize',30,'color','b');

subplot(2,1,2)
hold on
plot(tspan,Te_data(:,1))
ip3 = plot(tspan(1),Te_data(1,1),'Marker','.','Color','r');

%Nt = length(tspan);
for it = 2:Nt
    ip.XData = data_0(1);
    ip.YData = data_0(2);
    ip.ZData = data_0(3);
    %
    ip2.XData = Te_sm(it);
    ip2.YData = dTe_sm(it);
    ip2.ZData = ddTe_sm(it);
    %
    ip3.XData = [ip3.XData  tspan(it)];
    ip3.YData = [ip3.YData data_0(1)];
    %
    delta = inet([data_0 ;data_1]);
    data_2 = data_1 + delta;
    data_0 = data_1;
    data_1 = data_2;
    pause(0.001)
end
