function sim_job1

SimIDs=[1]
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/dependencies
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/dependencies/Coverage
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/dependencies/Coverage/Coverage
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/dependencies/Coverage/Coverage/lib
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/dependencies/Coverage/Coverage/lib/absolutepath
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/dependencies/Coverage/Coverage/src
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/dependencies/DataHash_20160618
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/dependencies/MapN
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/dependencies/altmany-export_fig-2763b78
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/dependencies/compareFigFiles
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/dependencies/distinguishable_colors
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/dependencies/ear
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/dependencies/github-sync-matlab
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/dependencies/isfunction
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/dependencies/m2html
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/dependencies/m2html/templates
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/dependencies/m2html/templates/3frames
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/dependencies/m2html/templates/blue
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/dependencies/m2html/templates/brain
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/dependencies/m2html/templates/frame
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/dependencies/mtit
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/dependencies/subplot_grid
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/internal
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/internal/unit-test
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/internal/unit-test/.git
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/internal/unit-test/.git/branches
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/internal/unit-test/.git/hooks
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/internal/unit-test/.git/info
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/internal/unit-test/.git/logs
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/internal/unit-test/.git/logs/refs
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/internal/unit-test/.git/logs/refs/heads
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/internal/unit-test/.git/objects
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/internal/unit-test/.git/objects/0e
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/internal/unit-test/.git/objects/0f
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/internal/unit-test/.git/objects/1b
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/internal/unit-test/.git/objects/1e
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/internal/unit-test/.git/objects/20
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/internal/unit-test/.git/objects/25
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/internal/unit-test/.git/objects/2e
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/internal/unit-test/.git/objects/40
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/internal/unit-test/.git/objects/45
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/internal/unit-test/.git/objects/47
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/internal/unit-test/.git/objects/52
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/internal/unit-test/.git/objects/56
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/internal/unit-test/.git/objects/73
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/internal/unit-test/.git/objects/75
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/internal/unit-test/.git/objects/7c
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/internal/unit-test/.git/objects/85
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/internal/unit-test/.git/objects/8f
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/internal/unit-test/.git/objects/91
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/internal/unit-test/.git/objects/b3
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/internal/unit-test/.git/objects/bb
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/internal/unit-test/.git/objects/bd
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/internal/unit-test/.git/objects/ca
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/internal/unit-test/.git/objects/d3
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/internal/unit-test/.git/objects/d9
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/internal/unit-test/.git/objects/de
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/internal/unit-test/.git/objects/e8
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/internal/unit-test/.git/objects/ef
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/internal/unit-test/.git/objects/f3
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/internal/unit-test/.git/objects/info
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/internal/unit-test/.git/objects/pack
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/internal/unit-test/.git/refs
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/internal/unit-test/.git/refs/heads
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/internal/unit-test/.git/refs/remotes
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/internal/unit-test/.git/refs/remotes/origin
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/internal/unit-test/.git/refs/tags
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/internal/xp_libraries
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/models
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/models/personal/dynasim-benchmark-brette-2007/DynaSim/models
for s=1:length(SimIDs)
	SimID=SimIDs(s);
	try
		load(fullfile('/usr3/graduate/asoplata/batchdirs/benchmark_COBAHH_clocksyn_hidens_compile_0008',sprintf('studyinfo_%g.mat',SimID)),'studyinfo');
		[valid,message]=dsCheckHostPaths(studyinfo);
		if ~valid
		  lasterr(message);
		  for s=1:length(SimIDs), dsUpdateStudy(studyinfo.study_dir,'sim_id',SimIDs(s),'status','failed'); end
		  continue;
		end
		siminfo=studyinfo.simulations(SimID);
		options=rmfield(siminfo.simulator_options,{'modifications','studyinfo','analysis_functions','plot_functions','sim_id'});
		keyvals=dsOptions2Keyval(options);
		fprintf('-----------------------------------------------------\n');
		fprintf('Processing simulation %g (%g of %g in this job)...\n',SimID,s,length(SimIDs));
		fprintf('-----------------------------------------------------\n');
		data=dsSimulate(studyinfo.base_model,'modifications',siminfo.modifications,'studyinfo',studyinfo,'sim_id',SimID,keyvals{:});
		for i=1:length(siminfo.result_functions)
			dsAnalyze(data,siminfo.result_functions{i},'result_file',siminfo.result_files{i},'save_data_flag',1,siminfo.result_options{i}{:});
		end
	catch err
		displayError(err);
	end
end
exit
