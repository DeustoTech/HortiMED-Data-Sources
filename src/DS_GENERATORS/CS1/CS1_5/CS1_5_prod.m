clear 
load('CS1_4_prod.mat')
%%
clf
hold on


fn = [12 12 12 12 12 12 12 12 12 6 6 2 2 2 2 2 2 2 2 2 2];

for i = 1:11
    dates = [data.DateTransplanted(i) data.GrowthPeriodFirstHarvest(i)];
    dates2 = [ data.GrowthPeriodFirstHarvest(i) data.EndGrowthPeriodOfHarvest(i)];

    fill([dates(1),dates(1),dates(2),dates(2)],[i+0.25,i-0.25,i-0.25,i+0.25],[0.9 0.9 1])
    fill([dates2(1),dates2(1),dates2(2),dates2(2)],[i+0.25,i-0.25,i-0.25,i+0.25],[0.9 1 0.9])

    xinit = dates(1) + (dates(2) - dates(1))/fn(i);
    tt = string(data.vegetable(i)) + " |  $\rho_{plant} = "+num2str(data.Density(i),'%.2f') + " \ m^{-2}$";
    itext = text(xinit,i,tt,'Interpreter','latex','FontSize',12);
end
grid on
yticks([1:11])
ylabel('Experiments','FontSize',15,'Interpreter','latex')
ylim([0 12])

yyaxis right
yticks([1:11])
ylim([0 12])

yt = replace(string(data.system),'IMTA-','');
yticklabels(yt)