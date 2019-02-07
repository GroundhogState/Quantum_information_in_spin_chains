function proc_data = process_atomized(data,config)


net_data = data.net_data;


% % 
config.viz.fields = {'G','weight_list'};
proc_data.cent = viz_field(net_data,config);

config.viz.fields = {'G','degree_list'};
proc_data.cent = viz_field(net_data,config);

config.viz.fields = {'G','node_centrality'};
proc_data.cent = viz_field(net_data,config);

% config.viz.fields = {'A','evals'};
% proc_data.A_evals = viz_field(net_data,config);

config.viz.fields = {'A','trace'};
proc_data.A_trace = viz_field(net_data,config);

config.viz.fields = {'L','evals'};
proc_data.L_evals = viz_field(net_data,config);

% config.viz.fields = {'L','trace'};
% proc_data.L_trace = viz_field(net_data,config);
% 
config.viz.fields = {'P','entropy_VN'};
proc_data.entropy_VN = viz_field(net_data,config);

config.viz.fields = {'P','TMI'};
proc_data.TMI = viz_field(net_data,config);

% % config.viz.fields = {'A','unif_projection'};
% % proc_data.TMI = viz_field(net_data,config);


fwtext('Done!')

end
