clear 
load('CS3_8_sysclima_clean')
%%
figure(1)
clf
subplot(3,1,1)
hold on
subplot(3,1,2)
hold on
subplot(3,1,3)
hold on
for ds = ds_cell
    subplot(3,1,1)
    plot(ds{:}.DateTime,ds{:}.Tinv)
    subplot(3,1,2)
    plot(ds{:}.DateTime,ds{:}.EstadoCenitalE)

    subplot(3,1,3)
    plot(ds{:}.DateTime,ds{:}.EstadoPant1)

       
end