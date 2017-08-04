
data = readtable('data.csv');

f1 = figure(1);
subplot 221
loglog(data.CellCount, data.BrianCUBA_Nosyn,'-or','DisplayName','Brian')
hold on
loglog(data.CellCount, data.DynaCUBA_NosynNocompile, '-ob','DisplayName','DynaSim Not Compiled')
loglog(data.CellCount, data.DynaCUBA_NosynCompile, '-ok','DisplayName','DynaSim Compiled')
hold off
xlabel('Cell number')
ylabel('Time in seconds')
title('CUBA No synapses')
legend('show')

subplot 222
loglog(data.CellCount, data.BrianCOBAHH_Nosyn, '-or')
hold on
loglog(data.CellCount, data.DynaCOBAHH_NosynNocompile, '-ob')
loglog(data.CellCount, data.DynaCOBAHH_NosynCompile, '-ok')
hold off
xlabel('Cell number')
ylabel('Time in seconds')
title('COBAHH No synapses')

subplot 223
loglog(data.CellCount, data.BrianCOBAHH_ClocksynLodensEstimated, '-or')
hold on
loglog(data.CellCount, data.DynaCOBAHH_ClocksynLodensNocompile, '-ob')
loglog(data.CellCount, data.DynaCOBAHH_ClocksynLodensCompile, '-ok')
hold off
xlabel('Cell number')
ylabel('Time in seconds')
title('COBAHH Clock-synapses Low density')


subplot 224
loglog(data.CellCount, data.BrianCOBAHH_ClocksynHidensEstimated, '-or')
hold on
loglog(data.CellCount, data.DynaCOBAHH_ClocksynHidensNocompile, '-ob')
loglog(data.CellCount, data.DynaCOBAHH_ClocksynHidensCompile, '-ok')
hold off
xlabel('Cell number')
ylabel('Time in seconds')
title('COBAHH Clock-synapses High density')

print(f1, 'benchmark_plots','-dpng')
