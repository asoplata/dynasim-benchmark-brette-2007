
data = readtable('data.csv');

f1 = figure(1);
subplot 221
loglog(data.CellCount, data.BrianCUBA_Nosyn, 'r','DisplayName','Brian')
hold on
loglog(data.CellCount, data.DynaCUBA_NosynNocompile, 'b','DisplayName','DynaSim Not Compiled')
loglog(data.CellCount, data.DynaCUBA_NosynCompile, 'k','DisplayName','DynaSim Compiled')
hold off
xlabel('Cell number')
ylabel('Time in seconds')
title('CUBA No synapses')
legend('show')

subplot 222
loglog(data.CellCount, data.BrianCOBAHH_Nosyn, 'r')
hold on
loglog(data.CellCount, data.DynaCOBAHH_NosynNocompile, 'b')
loglog(data.CellCount, data.DynaCOBAHH_NosynCompile, 'k')
hold off
xlabel('Cell number')
ylabel('Time in seconds')
title('COBAHH No synapses')

subplot 223
loglog(data.CellCount, data.BrianCOBAHH_ClocksynLodensEstimated, 'r')
hold on
loglog(data.CellCount, data.DynaCOBAHH_ClocksynLodensNocompile, 'b')
loglog(data.CellCount, data.DynaCOBAHH_ClocksynLodensCompile, 'k')
hold off
xlabel('Cell number')
ylabel('Time in seconds')
title('COBAHH Clock-synapses Low density')


subplot 224
loglog(data.CellCount, data.BrianCOBAHH_ClocksynHidensEstimated, 'r')
hold on
loglog(data.CellCount, data.DynaCOBAHH_ClocksynHidensNocompile, 'b')
loglog(data.CellCount, data.DynaCOBAHH_ClocksynHidensCompile, 'k')
hold off
xlabel('Cell number')
ylabel('Time in seconds')
title('COBAHH Clock-synapses High density')

print(f1, 'benchmark_plots','-dpng')