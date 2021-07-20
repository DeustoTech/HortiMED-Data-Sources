clear 

load('CS3_1_Sysclima')
%%
vars = iTs.DataSet.Properties.VariableNames;

fig = figure('unit','norm','pos',[0 0 0.3 0.2]);
%%
path = which('CS3_1_SysClima_properties.m');
path = replace(path,'/CS3_1_SysClima_properties.m','');
path = fullfile(path,'img');
%%
jj = 0;
for ivar = vars
    jj = jj + 1;
    clf
    
    list      = iTs.DataSet.(ivar{:});
    if length(unique(list)) == 1
        continue
    end
    mu        = mean(list);
    variance  = std(list);
    max_value = max(list);
    min_value = min(list);
    
    hold on
%     ir = rectangle('pos',[mu-variance 0 2*variance 1],'FaceColor',0.8*[1 1 1]);
        
    histogram(iTs.DataSet.(ivar{:}),'Normalization','probability','NumBins',50)
    title(ivar{:},'Interpreter','none')
    
    %
    %xline(mu,'LineWidth',2,'color','k')

    %
    pp = {'\mu','\sigma','max','min'};
    pp_v = {mu,variance,max_value,min_value};
    
    iter = 0;
    for ipp = pp
        iter = iter + 1 ;
        text(0.5*max_value+0.5*min_value           , 0.35+iter*0.12 ,"$"+ipp{:}+"$"                ,'FontSize',20,'Interpreter','latex')
        GAP = max_value-min_value;
        text(0.5*max_value+0.5*min_value+0.15*GAP  , 0.35+iter*0.12 ,"$ = "+num2str(pp_v{iter},'%.3f')+"$" ,'FontSize',20,'Interpreter','latex')

    end
    ylim([0 1])
    grid on
    print(fig,'-depsc',fullfile(path,"fig"+jj+".eps"));
end
%%


