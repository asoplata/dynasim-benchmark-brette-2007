run_name = 'benchmark_runscript_1';
%{
%}

% Define equations of cell model (same for all populations)
eqns={
  'dv/dt=Iapp+@current';
};

time_end = 500; % in milliseconds
numcells = 10;

prob_cxn = 0.5;
app = 2.3;

% Create DynaSim specification structure
s=[];
s.populations(1).name='E';
s.populations(1).size=numcells;
s.populations(1).equations=eqns;
% this is where the magic happens
s.populations(1).mechanism_list={'iNaBME','iKBME','iLeakBME'};
s.populations(1).parameters={'Iapp',app};

s.populations(2).name='I';
s.populations(2).size=numcells;
s.populations(2).equations=eqns;
s.populations(1).mechanism_list={'iNaBMI','iKBMI','iLeakBMI'};
s.populations(2).parameters={'Iapp',app};

s.connections(1).direction='E->I';
s.connections(1).mechanism_list={'iAMPABM'};
s.connections(1).parameters={'gAMPA',0.08};

s.connections(2).direction='I->E';
s.connections(2).mechanism_list={'iGABAaBM'};
s.connections(1).parameters={'gGABAa',0.08};

vary={
  '(I->E)',           'gGABAa',     [0,0.69];
};
  % '(TC,RE)',           'Iapp',     [1.3, 2.3];

%% Set simulation parameters
% How much RAM, options: 8G?, 24, 48, 96, 128
memlimit = '8G';
% memlimit = '16G';
% memlimit = '48G';
% memlimit = '96G';
%memlimit = '254G';

% Save data/results to this directory. If just a single name, will
%   save to that directory name in the current directory from which it's run.
%   Will create directory if it does not exist.
data_dir = strcat(run_name);

% Flags
cluster_flag =      0;
overwrite_flag =    1;
save_data_flag =    1;
% Even if `save_data_flag` is 0, if running on cluster this must be off too in
%   order to not save data?
save_results_flag = 1;
verbose_flag =      1;
compile_flag =      0;
disk_flag =         0;
downsample_factor = 1;

% local run of the simulation,
%   i.e. in the interactive session you're running this same script in
data = dsSimulate(s,'save_data_flag',save_data_flag,'study_dir',data_dir,...
                  'cluster_flag',cluster_flag,'verbose_flag',verbose_flag,...
                  'overwrite_flag',overwrite_flag,'tspan',[0 time_end],...
                  'save_results_flag',save_results_flag,'solver','euler',...
                  'memlimit',memlimit,'compile_flag',compile_flag,...
                  'disk_flag',disk_flag,'downsample_factor',downsample_factor,...
                  'vary',vary);%...
                  %'plot_functions',{@PlotData,@PlotData,@PlotData},...
                  %'plot_options',{{'plot_type','waveform','format','png'},...
                  %                {'plot_type','power','format','png','xlim',[0 40]},...
                  %                {'plot_type','rastergram','format','png'}})
dsPlot(data)

dsPlot(data,'variable','sGABAa')

dsPlot(data,'variable','v')

figure
plot(data(1).time, data(1).TC_V)
title('first TC Vs, no inh')

figure
plot(data(2).time, data(2).TC_V)
title('second TC Vs, under inh')
% exit