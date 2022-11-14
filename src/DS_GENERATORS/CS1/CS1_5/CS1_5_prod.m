clear 
load('CS1_4_prod.mat')
%%
clf
hold on
data(1,:) = [];

%%
%%
clf
hold on
data = data([1:5 13 15 12 14 6 8 10 17 7 9 11 16],:);

fn = [12 12 12 12 12 12 12 12 12 6 6 2 2 2 2 2 2 2 2 2 2 4 4 4 4 4 4];

for i = 1:17
    dates = [data.DateTransplanted(i) data.GrowthPeriodFirstHarvest(i)];
    dates2 = [ data.GrowthPeriodFirstHarvest(i) data.EndGrowthPeriodOfHarvest(i)];

    fill([dates(1),dates(1),dates(2),dates(2)],[i+0.25,i-0.25,i-0.25,i+0.25],[0.9 0.9 1])
    fill([dates2(1),dates2(1),dates2(2),dates2(2)],[i+0.25,i-0.25,i-0.25,i+0.25],[0.9 1 0.9])

    xinit = dates(1) + (dates(2) - dates(1))/2;
    tt = string(data.vegetable(i)) + " |  $\rho_{plant} = "+num2str(data.Density(i),'%.2f') + " \ m^{-2}"  + ...
            "  \ | \  Area  = "+data.Aream2(i)+" \ m^2$";
        
    tt = string(data.vegetable(i)) + " |  $Yield = "+num2str(data.TotalYieldWeightkgm2(i),'%.2f')+"kg/m^2$";
        
    %tt = string(data.vegetable(i)) ;
    itext = text(xinit,i,tt,'Interpreter','latex','FontSize',12);
end
grid on
yticks([1:17])
ylabel('Experiments','FontSize',15,'Interpreter','latex')
ylim([0 18])

yyaxis right
yticks([1:17])
ylim([0 18])

yt = replace(string(data.system),'IMTA-','');
yt = yt + " GH"+data.GreenHouse;
yticklabels(yt)