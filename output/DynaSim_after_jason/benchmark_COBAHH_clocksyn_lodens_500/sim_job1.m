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
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/functions/internal/xp_libraries
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/models
addpath /usr3/graduate/asoplata/s1-dynasim/dynasim/models/personal/dynasim-benchmark-brette-2007/DynaSim/models
for s=1:length(SimIDs)
	SimID=SimIDs(s);
	try
		load(fullfile('/usr3/graduate/asoplata/batchdirs/benchmark_COBAHH_clocksyn_lodens_500',sprintf('studyinfo_%g.mat',SimID)),'studyinfo');
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
