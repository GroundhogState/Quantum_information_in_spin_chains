function proc_data = system_proc_10(net_data,config)

if ~exist(fullfile([config.gen.savepath,'out/']),'dir')
    mkdir(fullfile([config.gen.savepath,'out/']))
end
config.viz.outpath = fullfile([config.gen.savepath,'out/']);
% % First, examine the graph structure: 
% % Weight distribution
config.viz.W_list = cellfun(@(x) x.prm.W, net_data);
config.viz.Nmax = numel(net_data);
config.viz.cutoff = 1e-15;
config.viz.scaling = true;
config.viz.log_scaling = false;
config.viz.num_bins = 28;
config.viz.win = [0,2];
config.viz.scale = 1;
config.viz.log_win = [-1,14];
config.viz.log_scale = 1;
config.viz.fid=1;
config.viz.fig_title = 'Weight distribution 10';
weight_dist = cellfun(@(x) x.G.weight_list, net_data,'UniformOutput',false);
proc_data.weights = distribution_viz(weight_dist,config);
analyse_weights(proc_data.weights,config)
% saveas(gcf,fullfile([config.viz.outpath,config.viz.fig_title,'.png']))

% % Degree distribution
config.viz.W_list = cellfun(@(x) x.prm.W, net_data);
config.viz.Nmax = numel(net_data);
config.viz.cutoff = 1e-15;
config.viz.scaling = false;
config.viz.log_scaling = false;
config.viz.num_bins = 20;
config.viz.win = [0,3];
config.viz.scale = 1;
config.viz.log_win = [-log10(3),9];
config.viz.log_scale = 1;
config.viz.fid=2;
config.viz.fig_title='Degree distribution 10';
degree_dist = cellfun(@(x) x.G.degree_list, net_data,'UniformOutput',false);
proc_data.degree =distribution_viz(degree_dist,config);
analyse_degree(proc_data.degree ,config)   
% saveas(gcf,fullfile([config.viz.outpath,config.viz.fig_title,'.png']))

% Measures of connectedness
        
% % Algebraic properties: A vs L
        
% Spectrum
config.viz.W_list = cellfun(@(x) x.prm.W, net_data);
config.viz.Nmax = numel(net_data);
config.viz.cutoff = 1e-15;
config.viz.scaling = false;
config.viz.log_scaling = false;
config.viz.num_bins = 20;
config.viz.win = [0,5];
config.viz.scale = 1;
config.viz.log_win = [-2,9];
config.viz.log_scale = 1;
config.viz.fid=11;
config.viz.fig_title='Aleph spectral distribution 10';
aleph_spec_dist = cellfun(@(x) x.A.evals, net_data,'UniformOutput',false);
proc_data.aleph_spec=distribution_viz(aleph_spec_dist,config);
analyse_spectrum(proc_data.aleph_spec,config) 
% saveas(gcf,fullfile([config.viz.outpath,config.viz.fig_title,'.png']))


config.viz.W_list = cellfun(@(x) x.prm.W, net_data);
config.viz.Nmax = numel(net_data);
config.viz.cutoff = 1e-15;
config.viz.scaling = false;
config.viz.log_scaling = false;
config.viz.num_bins = 20;
config.viz.win = [0,0.21];
config.viz.scale = 1;
config.viz.log_win = [-log10(3),9];
config.viz.log_scale = 1;
config.viz.fid=12;
config.viz.fig_title='Laplacian spectral distribution 10';
lap_spec_dist = cellfun(@(x) x.L.evals, net_data,'UniformOutput',false);
proc_data.lap_spec=distribution_viz(lap_spec_dist,config);
analyse_spectrum(proc_data.lap_spec,config) 
% saveas(gcf,fullfile([config.viz.outpath,config.viz.fig_title,'.png']))       
% Single eigenvalues?
        
% % Trace
config.viz.W_list = cellfun(@(x) x.prm.W, net_data);
config.viz.Nmax = numel(net_data);
config.viz.cutoff = 1e-15;
config.viz.scaling = false;
config.viz.log_scaling = false;
config.viz.num_bins = 20;
config.viz.win = [0,26];
config.viz.scale = 1;
config.viz.log_win = [-1.5,0];
config.viz.log_scale = 1;
config.viz.fid=21;
config.viz.fig_title='Aleph trace distribution 10';
aleph_trace_dist = cellfun(@(x) x.A.trace, net_data,'UniformOutput',false);
proc_data.aleph_trace=distribution_viz(aleph_trace_dist,config);
analyse_spectrum(proc_data.aleph_trace,config) 
% saveas(gcf,fullfile([config.viz.outpath,config.viz.fig_title,'.png']))

config.viz.W_list = cellfun(@(x) x.prm.W, net_data);
config.viz.Nmax = numel(net_data);
config.viz.cutoff = 1e-15;
config.viz.scaling = false;
config.viz.log_scaling = false;
config.viz.num_bins = 20;
config.viz.win = [0,26];
config.viz.scale = 1;
config.viz.log_win = [-1.5,0];
config.viz.log_scale = 1;
config.viz.fid=22;
config.viz.fig_title='Laplacian trace distribution 10';
lap_trace_dist = cellfun(@(x) x.L.trace, net_data,'UniformOutput',false);
proc_data.lap_trace=distribution_viz(lap_trace_dist,config);
analyse_spectrum(proc_data.lap_trace,config) 
% saveas(gcf,fullfile([config.viz.outpath,config.viz.fig_title,'.png']))        
% What's in the eigenvectors?

% % 'Physical' stuff

% VN entropy distribution
config.viz.fig_title = 'VN Entropy distribution 10';
config.viz.fid=31;
config.viz.num_bins = 150;
proc_data.VN_entropy = entropy_viz(net_data,config);
% saveas(gcf,fullfile([config.viz.outpath,config.viz.fig_title,'.png']))



fwtext('Done!')

end