function proc_data = process_atomized(data,config)


all_fields = fields(config.viz.G);
proc_data = [];
for ii=1:numel(all_fields)
    config.viz.fields = {'G',all_fields{ii}};
    proc_data.data.G{ii} = viz_field(data.net_data,config);
    proc_data.conf.G{ii} = config;
end

all_fields = fields(config.viz.P);
proc_data = [];
for ii=1:numel(all_fields)
    config.viz.fields = {'P',all_fields{ii}};
    proc_data.data.P{ii} = viz_field(data.net_data,config);
    proc_data.conf.P{ii} = config;
end

all_fields = fields(config.viz.L);
proc_data = [];
for ii=1:numel(all_fields)
    config.viz.fields = {'L',all_fields{ii}};
    proc_data.data.L{ii} = viz_field(data.net_data,config);
    proc_data.conf.L{ii} = config;
end

all_fields = fields(config.viz.A);
proc_data = [];
for ii=1:numel(all_fields)
    config.viz.fields = {'A',all_fields{ii}};
    proc_data.data.A{ii} = viz_field(data.net_data,config);
    proc_data.conf.A{ii} = config;
end

%Save the output%
if config.viz.save 
    fprintf(' - Saving process output\n')
    if ~exist(config.viz.savepath,'dir')
        mkdir(config.viz.savepath)
    end
%         timestamp = posixtime(datetime)*1e3;
    filename = sprintf('dyn_dat_L_%u',config.gen.L);
    save(fullfile(config.viz.savepath,filename),'-struct','proc_data','-v7.3');
end

fwtext('Done!')

end
