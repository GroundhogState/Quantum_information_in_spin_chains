function proc_data = corr_viz(data,config)

num_Ws = numel(data);
data_dist = cell(num_Ws,1);
for nW = 1:num_Ws 
    data_dist{nW} = cell_vertcat(cellfun(@(x) rec_getfield(x,config.viz.fields),data{nW},'UniformOutput',false)');
end

config_viz = rec_getfield(config.viz,config.viz.fields);
config_viz.W_list = config.viz.W_list;
proc_data = corr_proc(data_dist,config_viz);

% if config.viz.show_plots
    plot_corrs(proc_data,config_viz);
% end

if config.viz.save
    if ~exist(fullfile(config.viz.savepath),'dir')
        mkdir(fullfile(config.viz.savepath));
    end
    saveas(gcf,[fullfile(config.viz.savepath,config_viz.fig_filename),'.png']);
end



end