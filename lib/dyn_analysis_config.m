function config = dyn_analysis_config(config)

    L = config.viz.L;

    config_viz = [];
    config_viz.fields = {'G','node_cent'};
    config_viz.pos_def = true;
    config_viz.cutoff = 1e-11;
    config_viz.scaling = true;
    config_viz.log_scaling = false;
    config_viz.scale = 1/L;
    config_viz.win = [0,3];
    config_viz.log_win = [-3,6];
    config_viz.num_bins = 75;
    config_viz.fid = 111;
    config_viz.fig_title = 'Dynamic Centrality';
    config_viz.fig_filename = 'Dynamic_Centrality';
    config_viz.plots = {'linXlinY','linXlogY','linEnt','SJ_div','SJ_tot'};
    config.viz.G.node_cent = config_viz;

    config_viz = [];
    config_viz.fields = {'G','G_t'};
    config_viz.pos_def = true;
    config_viz.cutoff = 1e-11;
    config_viz.scaling = false;
    config_viz.log_scaling = false;
    config_viz.scale = L;
    config_viz.win = [0,2];
    config_viz.log_win = [-3,6];
    config_viz.num_bins = 100;
    config_viz.fid = 112;
    config_viz.fig_title = 'Dynamic QMI';
    config_viz.fig_filename = 'Dynamic_QMI';
    config_viz.plots = {'linXlinY','linXlogY','linEnt','SJ_div','SJ_tot'};
    config.viz.G.G_t = config_viz;

    config_viz = [];
    config_viz.fields = {'G','traces'};
    config_viz.pos_def = true;
    config_viz.cutoff = 1e-11;
    config_viz.scaling = true;
    config_viz.log_scaling = false;
    config_viz.scale = L;
    config_viz.win = [0,1];
    config_viz.log_win = [-3,6];
    config_viz.num_bins = 100;
    config_viz.fid = 113;
    config_viz.fig_title = 'Dynamic total correlation';
    config_viz.fig_filename = 'Dynamic_TCorr';
    config_viz.plots = {'linXlinY','linXlogY','linEnt','SJ_div','SJ_tot'};
    config.viz.G.traces = config_viz;

    config_viz = [];
    config_viz.fields = {'G','VNE'};
    config_viz.pos_def = true;
    config_viz.cutoff = 1e-11;
    config_viz.scaling = false;
    config_viz.log_scaling = false;
    config_viz.scale = L;
    config_viz.win = [0,1];
    config_viz.log_win = [-3,6];
    config_viz.num_bins = 100;
    config_viz.fid = 114;
    config_viz.fig_title = 'Dynamic VNE';
    config_viz.fig_filename = 'Dynamic_VNE';
    config_viz.plots = {'linXlinY','linXlogY','linEnt','logXlogY','SJ_div','SJ_tot'};
    config.viz.G.VNE = config_viz;

    config_viz = [];
    degree.fields = {'G','degree'};
    degree.pos_def = true;
    degree.cutoff = 1e-11;
    degree.scaling = true;
    degree.log_scaling = false;
    degree.scale = 2*(L-1);
    degree.win = [0,1];
    degree.log_win = [-3,6];
    degree.num_bins = 100;
    degree.fid = 115;
    degree.fig_title = 'Dynamic Degree';
    degree.fig_filename = 'Dynamic_deg';
    degree.plots = {'linXlinY','linXlogY','linEnt','SJ_div','SJ_tot'};
    config.viz.G.degree = degree;

        
    
%     config_viz = [];
%     config_viz.fields = {'G','L_evals'};
%     config_viz.pos_def = true;
%     config_viz.cutoff = 1e-11;
%     config_viz.scaling = true;
%     config_viz.log_scaling = false;
%     config_viz.scale = 2*L;
%     config_viz.win = [-0.1,1];
%     config_viz.log_win = [-3,6];
%     config_viz.num_bins = 200;
%     config_viz.fid = 1290;
%     config_viz.fig_title = 'Laplacian spectrum';
%     config_viz.fig_filename = 'Lap_spectrum';
%     config_viz.plots = {'linXlinY'};%,'linXlogY','linEnt'};
%     config.viz.G.L_evals = config_viz;

%     config_viz = [];
%     config_viz.fields = {'G','exp_A'};
%     config_viz.pos_def = true;
%     config_viz.cutoff = 1e-11;
%     config_viz.scaling = true;
%     config_viz.log_scaling = false;
%     config_viz.scale = 2*L;
%     config_viz.win = [0,1];
%     config_viz.log_win = [-3,6];
%     config_viz.num_bins = 200;
%     config_viz.fid = 1210;
%     config_viz.fig_title = 'Exp(A)';
%     config_viz.fig_filename = 'Exp_A';
%     config_viz.plots = {'linXlinY','linXlogY','linEnt'};
%     config.viz.G.L_evals = config_viz;

    config_viz = [];
    config_viz.fields = {'X','ent_deg_pair'};
    config_viz.fid = 5853;
    config_viz.num_bins = 100;
    config_viz.axes_labels = {'VN Entropy', 'Node degree'};
    config_viz.fig_title = 'Entropy/Degree correlation';
    config_viz.fig_filename = 'Entropy_Degree_correlation';
    config.viz.X.ent_deg_pair = config_viz;
    
    config_viz = [];
    config_viz.num_bins = 100;
    config_viz.fid = 5760;
    config_viz.fields = {'X','ent_cent'};
    config_viz.axes_labels = {'VN Entropy', 'Node centrality'};
    config_viz.fig_title = 'Entropy/Centrality correlation';
    config_viz.fig_filename = 'Entropy_centrality_correlation';
    config.viz.X.ent_cent = config_viz;

%     config_viz = [];
%     config_viz.num_bins = 100;
%     config_viz.fid = 5761;
%     config_viz.fields = {'X','ent_dist'};
%     config_viz.axes_labels = {'QMI', 'distance'};
%     config_viz.fig_filename = 'Entropy_Degree_correlation';
%     config_viz.fig_title = 'QMI vs distance';
%     config.viz.X.ent_cent = config_viz;


end

