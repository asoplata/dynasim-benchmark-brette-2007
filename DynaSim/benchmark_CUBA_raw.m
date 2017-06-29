%{
%}

run_name = 'benchmark_CUBA_raw';

% Save data/results to this directory. If just a single name, will
%   save to that directory name in the current directory from which it's run.
%   Will create directory if it does not exist.
data_dir = strcat(run_name);

time_end = 500; % in milliseconds
numEcells = 3200;
numIcells = 800;

%% Create DynaSim specification structure
s=[];
s.populations(1).name='E';
s.populations(1).size=numEcells;
s.populations(1).equations={'dv/dt=-gLeak*(V-ELeak)./taum; if(v>-50)(v=-60)'};
s.populations(1).parameters={'taum',20,'gLeak',1,'ELeak',-49};

s.populations(2).name='I';
s.populations(2).size=numIcells;
s.populations(2).equations={'dv/dt=-gLeak*(V-ELeak)./taum; if(v>-50)(v=-60)'};
s.populations(2).parameters={'taum',20,'gLeak',1,'ELeak',-49};


%% Set other, non-network simulation parameters
vary={};

% Flags
% How much RAM if you need MUCH RAM - options: 8G (default), 94G, 125G, 252G, 504G
memlimit =     '252G';
cluster_flag =      1;
overwrite_flag =    1;
save_data_flag =    0;
save_results_flag = 1;
verbose_flag =      1;
compile_flag =      0;
disk_flag =         0;
downsample_factor = 1;
benchmark_flag =    1;

%% Run the simulation
data = dsSimulate(s,'save_data_flag',save_data_flag,'study_dir',data_dir,...
                  'cluster_flag',cluster_flag,'verbose_flag',verbose_flag,...
                  'overwrite_flag',overwrite_flag,'tspan',[0 time_end],...
                  'save_results_flag',save_results_flag,'solver','euler',...
                  'memlimit',memlimit,'compile_flag',compile_flag,...
                  'disk_flag',disk_flag,'downsample_factor',downsample_factor,...
                  'benchmark_flag',benchmark_flag,...
                  'vary',vary,...
                  'plot_functions',{@dsPlot,@dsPlot,@dsPlot},...
                  'plot_options',{{'plot_type','waveform','format','png'},...
                                  {'plot_type','power','format','png'},...
                                  {'plot_type','rastergram','format','png'}});
% exit
