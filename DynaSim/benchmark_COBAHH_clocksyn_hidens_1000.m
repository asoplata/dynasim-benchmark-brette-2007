%{
# Notes:

- This simulation seeks to emulate the COBAHH benchmark simulations of (Brette
et al. 2007) using the DynaSim simulator for speed benchmark comparison.
This simulation does include CLOCK-DRIVEN SYNAPSES, for clock-driven comparison
to Figure 4 of (Goodman and Brette, 2008). The synaptic connections are
"high-density", with a 90% probability of connection - but the synaptic
connection density should not significantly effect DynaSim computation time.

- The time taken to simulate will be indicated in the stdout log file
'~/batchdirs/benchmark_COBAHH_clocksyn_lodens_1000/pbsout/sim_job1.out'

# References:

- Brette R, Rudolph M, Carnevale T, Hines M, Beeman D, Bower JM, et al.
Simulation of networks of spiking neurons: A review of tools and strategies.
Journal of Computational Neuroscience 2007;23:349–98.
doi:10.1007/s10827-007-0038-6.

- Goodman D, Brette R. Brian: a simulator for spiking neural networks in Python.
Frontiers in Neuroinformatics 2008;2. doi:10.3389/neuro.11.005.2008.
%}

run_name = 'benchmark_COBAHH_clocksyn_hidens_1000';

total_cells = 1000;
numEcells = 0.8*total_cells;
numIcells = 0.2*total_cells;

time_end = 500; % in milliseconds

%% Create DynaSim specification structure
% Define equations of cell model (same for all populations)
eqns={
  'dv/dt=Iapp+@current';
};

% Create DynaSim specification structure
s=[];
s.populations(1).name='E';
s.populations(1).size=numEcells;
s.populations(1).equations=eqns;
s.populations(1).mechanism_list={'iNaBM','iKBM','iLeakBM'};
s.populations(1).parameters={'Iapp',0};

s.populations(2).name='I';
s.populations(2).size=numIcells;
s.populations(2).equations=eqns;
s.populations(2).mechanism_list={'iNaBM','iKBM','iLeakBM'};
s.populations(2).parameters={'Iapp',0};

s.connections(1).direction='E->I';
s.connections(1).mechanism_list={'iAMPACOBAHHtanh'};
s.connections(1).parameters={'prob_cxn',0.90};
s.connections(2).direction='I->E';
s.connections(2).mechanism_list={'iGABAaCOBAHHtanh'};
s.connections(2).parameters={'prob_cxn',0.90};
s.connections(3).direction='E->E';
s.connections(3).mechanism_list={'iAMPACOBAHHtanh'};
s.connections(3).parameters={'prob_cxn',0.90};
s.connections(4).direction='I->I';
s.connections(4).mechanism_list={'iGABAaCOBAHHtanh'};
s.connections(4).parameters={'prob_cxn',0.90};

%% Set other, non-network simulation parameters
vary={};

% Save data/results to this directory. If just a single name, will
%   save to that directory name in the current directory from which it's run.
%   Will create directory if it does not exist.
data_dir = strcat(run_name);

% Flags
% How much RAM if you need MUCH RAM - options: 8G (default), 94G, 125G, 252G, 504G
memlimit =     '252G';
cluster_flag =      1;
overwrite_flag =    1;
save_data_flag =    0;
save_results_flag = 0;
verbose_flag =      1;
compile_flag =      0;
disk_flag =         0;
downsample_factor = 1;
benchmark_flag =    1;


%% Run the simulation,
data = dsSimulate(s,'save_data_flag',save_data_flag,'study_dir',data_dir,...
                  'cluster_flag',cluster_flag,'verbose_flag',verbose_flag,...
                  'overwrite_flag',overwrite_flag,'tspan',[0 time_end],...
                  'save_results_flag',save_results_flag,'solver','euler',...
                  'memlimit',memlimit,'compile_flag',compile_flag,...
                  'disk_flag',disk_flag,'downsample_factor',downsample_factor,...
                  'benchmark_flag',benchmark_flag,...
                  'plot_functions',{@dsPlot},...
                  'plot_options',{{'plot_type','waveform','format','png'}});
exit
