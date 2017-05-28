run_name = 'benchmark_runscript_1';
%{
# Run Simulation file
- Project 1:
    - Propofol PAC investigation
- Direction 1:
    - Thalamus-only propofol PAC modeling
- Writing item 2:
    - Journal article on results of p1d1
- Figures 7-8:
    - Illustrating and showing example of phase-amplitude coupling across
    corticothalamic UP/DOWN SWO states in action
- Subfigures:
    - N/A
- Run 3:
    - Running long 15-second simulation, since no longer including figure of
    PAC coupling-gram, but including rastergram instead
- Date Created:
    - 20170119
- Inherits from:
    - 'p1d1q36c5i2_20161105_triple_switch_sfn2016poster.m'
%}

% Define equations of cell model (same for all populations)
eqns={
  'dV/dt=Iapp+@current';
};
  % 'dV/dt=Iapp+@current; if(X>-55)(sGABAa=1)';

first_onset =       0; % in ms

% time_end = 3000; % in milliseconds
% second_onset =   1000;
% third_onset =    2000;
% numcells = 4;

time_end = 500; % in milliseconds
numcells = 10;

prob_cxn = 0.5;
app = 2.3;

% Create DynaSim specification structure
s=[];
s.populations(1).name='TC';
s.populations(1).size=numcells;
s.populations(1).equations=eqns;
% this is where the magic happens
s.populations(1).mechanism_list={'iNaChing2010TC','iKChing2010TC','iLeakChing2010TC'};
s.populations(1).parameters={'Iapp',app};

s.populations(2).name='RE';
s.populations(2).size=numcells;
s.populations(2).equations=eqns;
s.populations(2).mechanism_list={'iNaChing2010RE','iKChing2010RE','iLeakChing2010RE'};
s.populations(2).parameters={'Iapp',app};

s.connections(1).direction='TC->RE';
s.connections(1).mechanism_list={'iAMPAChing2010'};
s.connections(1).parameters={'gAMPA',0.0};
% s.connections(1).parameters={'gAMPA',0.08};

s.connections(2).direction='RE->TC';
% s.connections(2).mechanism_list={'iGABAa'};
s.connections(2).mechanism_list={'iGABAaBenchmark'};
% s.connections(2).parameters={'gGABAa',0.69,'tauGABAa',5};

% s.connections(3).direction='TC->TC';
% s.connections(3).mechanism_list={'iPSUSW'};
% s.connections(3).parameters={'g_esyn',g_PYsyn,'rate',12,'T',time_end,...
%                              'tau_i',10,'prob_cxn',prob_cxn,...
%                              };
% s.connections(4).direction='RE->RE';
% s.connections(4).mechanism_list={'iPSUSW','iGABAAChing2010Switch'};
% s.connections(4).parameters={'g_esyn',g_PYsyn,'rate',12,'T',time_end,...
%                              'tau_i',10,'prob_cxn',prob_cxn,...
%                              'spm',3,...
%                              'gGABAA_base',0.069,'tauGABAA_base',5};


%   '(RE->RE,RE->TC)',   'gGABAA_base',      [3*0.069];
%   '(RE->RE,RE->TC)',   'tauGABAA_base',    [3*5];
%   'TC',                'gH',       [0.0032];
%   '(RE->TC,RE->RE)',   'spm',      [1,2,3,4,5,6,7,8];
vary={
  '(RE->TC)',           'gGABAa',     [0,0.69];
};
  % '(TC,RE)',           'Iapp',     [1.3, 2.3];

%% Set simulation parameters
% How much RAM, options: 8G?, 24, 48, 96, 128
% are segfaults from too long of a sim?
memlimit = '8G';
% memlimit = '16G';
% memlimit = '48G';
% memlimit = '96G';
%memlimit = '254G';

% Save data/results to this directory. If just a single name, will
%   save to that directory name in the current directory from which it's run.
%   Will create directory if it does not exist.
data_dir = strcat('/projectnb/crc-nak/asoplata/x7-scc-data/s1d2_benchmark/',...
                  run_name);

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
% exit

dsPlot(data, 'variable','sGABAa')

dsPlot(data, 'variable','V')

figure
plot(data(1).time, data(1).TC_V)
title('first TC Vs, no inh')

figure
plot(data(2).time, data(2).TC_V)
title('second TC Vs, under inh')
