function proc_data = system_proc(net_data,config)

if ~exist(fullfile([config.gen.savepath,'out/']),'dir')
    mkdir(fullfile([config.gen.savepath,'out/']))
end

config.viz = [];
config.viz.Nmax = numel(net_data);
config.viz.outpath = fullfile([config.gen.savepath,'out/']);
config.viz.W_list = cellfun(@(x) x.prm.W, net_data);
config.viz.Nmax = numel(net_data);
config.viz.cutoff = 1e-15;
config = analysis_config(config);

weight_dist = cellfun(@(x) x.G.weight_list, net_data,'UniformOutput',false);
proc_data.weights = distribution_viz(weight_dist,config.viz.weight);
plot_hists(proc_data.weights,config.viz.weight,'linXlinY','linXlogY','logXlinY','logXlogY','linEnt','logEnt')


% % saveas(gcf,fullfile([config.viz.outpath,config.viz.fig_title,'.png']))
% 
% % % Degree distribution
% degree_dist = cellfun(@(x) x.G.degree_list, net_data,'UniformOutput',false);
% proc_data.degree =distribution_viz(degree_dist,config.viz.degree);
% analyse_degree(proc_data.degree ,config.viz.degree) % Visualizes stuff
% % saveas(gcf,fullfile([config.viz.outpath,config.viz.fig_title,'.png']))
% 
% % Measures of connectedness
% 
% % % Algebraic properties: A vs L
% 
% % Spectrum
% aleph_spec_dist = cellfun(@(x) x.A.evals, net_data,'UniformOutput',false);
% proc_data.aleph_spec=distribution_viz(aleph_spec_dist,config.viz.A_spec);
% analyse_spectrum(proc_data.aleph_spec,config.viz.A_spec)
% % saveas(gcf,fullfile([config.viz.outpath,config.viz.fig_title,'.png']))
% 
% lap_spec_dist = cellfun(@(x) x.L.evals, net_data,'UniformOutput',false);
% proc_data.lap_spec=distribution_viz(lap_spec_dist,config.viz.L_spec);
% analyse_spectrum(proc_data.lap_spec,config.viz.L_spec)
% % saveas(gcf,fullfile([config.viz.outpath,config.viz.fig_title,'.png']))
% % Single eigenvalues?
% 
% % % Trace
% aleph_trace_dist = cellfun(@(x) x.A.trace, net_data,'UniformOutput',false);
% proc_data.aleph_trace=distribution_viz(aleph_trace_dist,config.viz.A_trace);
% analyse_spectrum(proc_data.aleph_trace,config.viz.A_trace)
% % saveas(gcf,fullfile([config.viz.outpath,config.viz.fig_title,'.png']))
% 
% lap_trace_dist = cellfun(@(x) x.L.trace, net_data,'UniformOutput',false);
% proc_data.lap_trace=distribution_viz(lap_trace_dist,config.viz.L_trace);
% analyse_spectrum(proc_data.lap_trace,config.viz.L_trace)
% % saveas(gcf,fullfile([config.viz.outpath,config.viz.fig_title,'.png']))
% % What's in the eigenvectors?
% 
% % % 'Physical' stuff
% 
% % VN entropy distribution
% % proc_data.VN_entropy = entropy_viz(net_data,config.viz.VN_ent);
% % saveas(gcf,fullfile([config.viz.outpath,config.viz.fig_title,'.png']))
% 
% 
% 
% fwtext('Done!')

end
