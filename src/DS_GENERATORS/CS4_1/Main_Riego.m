clear; 
riegos_ds = Riego;
%riegos_ds = riegos_ds(1:1e3,:);
%%
t0 = riegos_ds.horaInicio(1);
tf = riegos_ds.horaFin(end); 

date_span = t0:minutes(15):tf;
%%
init_rg_minus = riegos_ds.horaInicio - minutes(0.5);
init_rg = riegos_ds.horaInicio;
%
end_rg  = riegos_ds.horaFin;
end_rg_plus = riegos_ds.horaFin + minutes(0.5);
%

hd = [init_rg_minus init_rg end_rg end_rg_plus]';
%%
hd = hd(:);
%
value = repmat([0 1 1 0],length(riegos_ds.fechaHora),1)';
%
flow = riegos_ds.litros./seconds(riegos_ds.horaFin - riegos_ds.horaInicio);
%%
value = flow'.*value;
value = value(:);
%
%%
clf
ind = 1:60000;
subplot(2,1,1)
plot(hd(ind),value(ind),'.-','LineWidth',2)
%
subplot(2,1,2)

dt = seconds(diff(hd));
dt = dt(ind);
dt = dt(1:end-1);
vl = value(ind);
vl = vl(2:end);
rdate = hd(ind);
rdate = rdate(2:end);
plot(rdate,cumsum(vl.*dt),'.-','LineWidth',2)

%%
