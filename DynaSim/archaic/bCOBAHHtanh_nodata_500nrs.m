run_name = 'bCOBAHHtanh_nodata_500nrs';
%{
%}

% Define equations of cell model (same for all populations)
eqns={
  'dv/dt=Iapp+@current';
};

time_end = 500; % in milliseconds
% numEcells = 32;
% numIcells = 8;
numEcells = 400;
numIcells = 100;

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
s.connections(2).direction='I->E';
s.connections(2).mechanism_list={'iGABAaCOBAHHtanh'};
s.connections(3).direction='E->E';
s.connections(3).mechanism_list={'iAMPACOBAHHtanh'};
s.connections(4).direction='I->I';
s.connections(4).mechanism_list={'iGABAaCOBAHHtanh'};

vary={
  '(E)',           'Iapp',     [0.0];
};
  % issue with save_data_flag being 0 and using multiple vary?
  % '(E)',           'Iapp',     [0.3,1.3];
  % '(E,I)',           'Iapp',     [0.3,1.3];

%% Set simulation parameters
% How much RAM, options: 8G?, 24, 48, 96, 128
% memlimit = '8G';
% memlimit = '16G';
% memlimit = '48G';
% memlimit = '96G';
memlimit = '254G';

% Save data/results to this directory. If just a single name, will
%   save to that directory name in the current directory from which it's run.
%   Will create directory if it does not exist.
data_dir = strcat('/projectnb/crc-nak/asoplata/x7-scc-data/',...
                  run_name);

% Flags
cluster_flag =      1;
overwrite_flag =    1;
save_data_flag =    0;
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
                  'vary',vary,...
                  'plot_functions',{@dsPlot,@dsPlot,@dsPlot},...
                  'plot_options',{{'plot_type','waveform','format','png'},...
                                  {'plot_type','power','format','png'},...
                                  {'plot_type','rastergram','format','png'}});
exit
