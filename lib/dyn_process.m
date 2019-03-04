function proc_data = dyn_process(import_data,config)
    all_fields = fields(config.viz.G);
    cross_fields = fields(config.viz.X);
    proc_data = [];
    for ii=1:numel(all_fields)
        config.viz.fields = {'G',all_fields{ii}};
        proc_data.data.G{ii} = viz_field(import_data.net_data,config);
        proc_data.conf.G{ii} = config;
    end

    for ii=1:numel(cross_fields)
        config.viz.fields = {'X',cross_fields{ii}};
        proc_data.data.X{ii} = corr_viz(import_data.net_data,config);
        proc_data.conf.X{ii} = config;
    end

    %Save the output%
    if config.viz.save 
        fprintf(' - Saving process output\n')
        if ~exist(config.viz.savepath,'dir')
            mkdir(config.viz.savepath)
        end
%         timestamp = posixtime(datetime)*1e3;
        filename = sprintf('dyn_dat_L_%u',config.viz.L);
        save(fullfile(config.viz.savepath,filename),'-struct','proc_data','-v7.3');
    end
end
