function proc_data = viz_field(data, config)
num_Ws = numel(data);
data_dist = cell(num_Ws,1);
for nW = 1:num_Ws 
    data_dist{nW} = cell_vertcat(cellfun(@(x) rec_getfield(x,config.viz.fields),data{nW},'UniformOutput',false)');
end

config_viz = rec_getfield(config.viz,config.viz.fields);
% config_viz.W_list = data.W;

proc_data = distribution_viz(data_dist,config_viz);

plot_hists(proc_data,config_viz);

if config.viz.save
    if ~exist(fullfile(config.viz.outpath),'dir')
        mkdir(fullfile(config.viz.outpath));
    end
    saveas(gcf,fullfile([config.viz.outpath,config_viz.fig_filename,'.png']));
end

end



