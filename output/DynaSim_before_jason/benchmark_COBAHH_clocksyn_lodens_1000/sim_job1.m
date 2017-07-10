function sim_job1

SimIDs=[1]
for s=1:length(SimIDs)
	SimID=SimIDs(s);
	try
		load(fullfile('/usr3/graduate/asoplata/batchdirs/benchmark_COBAHH_clocksyn_lodens_1000',sprintf('studyinfo_%g.mat',SimID)),'studyinfo');
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
