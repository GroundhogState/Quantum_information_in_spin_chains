function config = analysis_config(config)

    L = config.gen.L;
    
    
    % Graph properties
    
    % % Weight distribution
    weight = config.viz;
    weight.scaling = false;
    weight.log_scaling = false;
    weight.num_bins = 120;
    weight.win = [-.1,2.1];
    weight.scale = 1;
    weight.log_win = [-1,14];
    weight.log_scale = 1;
    weight.fid=1;
    weight.fig_filename = '01_Weight_distribution';
    weight.fig_title = 'Two-body mutual information';
    weight.pos_def = true;
    weight.plots = {'linXlinY','linXlogY','logXlogY','linEnt'};
    config.viz.G.weight_list = weight;

    % % Degree distribution
    degree_list = config.viz;
    degree_list.scaling = true;
    degree_list.log_scaling = false;
    degree_list.num_bins = 100;
    degree_list.win = [0,1]; %note also the 'blip' at ~2
    degree_list.scale = 2*(L-1);
    degree_list.log_win = [-log10(3),9];
    degree_list.log_scale = 1;
    degree_list.fid=2;
    degree_list.fig_title='Scaled degree distribution ';
    degree_list.fig_filename = '02_degree_distribtion';
    degree_list.pos_def = true;
    degree_list.plots = {'linXlinY','linXlogY','linEnt'};
    config.viz.G.degree_list = degree_list;

    % centrality
    cent = config.viz;
    cent.scaling = true;
    cent.log_scaling = false;
    cent.num_bins = 150;
    cent.win = [0,3];
    cent.scale = 1/(L-1);
    cent.log_win = [-2,2];
    cent.log_scale = 1/L;
    cent.fid=41;
    cent.fig_title='Spin-node Centrality';
    cent.fig_filename = '03_node_centrality';
    cent.plots = {'linXlinY','linXlogY','linEnt'};
    cent.pos_def = true;
    config.viz.G.node_centrality = cent;

    
        % VN entropy distribution
    VN_ent = config.viz;
    VN_ent.scaling = false;
    VN_ent.log_scaling = false;
    VN_ent.num_bins = 100;
    VN_ent.win = [-0.0,1];
    VN_ent.scale = 2;
    VN_ent.log_win = [-1,10];
    VN_ent.log_scale = 1;
    VN_ent.fid=3;
    VN_ent.fig_title='Single-site von Neumann entropy';
    VN_ent.fig_filename='04_Single-site_entropy';
    VN_ent.plots = {'linXlinY','linXlogY','logXlogY','linEnt'};
    VN_ent.pos_def = true;
    config.viz.P.entropy_VN = VN_ent;

%     % VN entropy distribution
%     VN_zoom = config.viz;
%     VN_zoom.scaling = false;
%     VN_zoom.log_scaling = false;
%     VN_zoom.num_bins = 100;
%     VN_zoom.win = [-0.02,0.2];
%     VN_zoom.scale = 2;
%     VN_zoom.log_win = [-1,10];
%     VN_zoom.log_scale = 1;
%     VN_zoom.fid=3;
%     VN_zoom.fig_title='Zomm von Neumann entropy';
%     VN_zoom.fig_filename='04a_Single-site_entropy';
%     VN_zoom.plots = {'linXlinY','linXlogY','logXlogY','linEnt'};
%     VN_zoom.pos_def = true;
%     config.viz.P.entropy_VN = VN_zoom;

    
    % % Trace
    A_trace = config.viz;
    A_trace.scaling = true;
    A_trace.log_scaling = false;
    A_trace.num_bins = 75;
    A_trace.win = [0,1];
    A_trace.scale = -9;
    A_trace.log_win = [-1.5,0.5];
    A_trace.log_scale = 1;
    A_trace.fid=21;
    A_trace.fig_title='Total correlations';
    A_trace.fig_filename = '05_Aleph_trace';
    A_trace.plots = {'linXlinY','linXlogY','linEnt'};
    A_trace.pos_def = false;
    config.viz.A.trace = A_trace;
    
    % TMI
    TMI = config.viz;
    TMI.scaling = false;
    TMI.log_scaling = false;
    TMI.num_bins = 50;
    TMI.win = [0,64];
    TMI.scale = (L-1)^2;
    TMI.log_win = [-10,10];
    TMI.log_scale = 1;
    TMI.fid=31;
    TMI.fig_title='Many-body correlations';
    TMI.fig_filename = '06_Total_higher_correlations';
    TMI.plots = {'linXlinY','linEnt'};
    TMI.pos_def = true;
    config.viz.P.TMI = TMI;


    L_spec = config.viz;
    L_spec.scaling = true;
    L_spec.log_scaling = false;
    L_spec.num_bins = 50;
    L_spec.win = [0,1];
    L_spec.scale = 2*L;
    L_spec.log_win = [-log10(3),9];
    L_spec.log_scale = 1;
    L_spec.fid=12;
    L_spec.fig_title='Scaled Laplacian eigenvalues';
    L_spec.fig_filename = '07_Laplacian_spectrum';
    L_spec.plots = {'linXlinY','linXlogY','linEnt'};
    L_spec.pos_def = true;
    config.viz.L.evals = L_spec;
    % Plot other curves: Average spectrum?
    
%     L_trace = config.viz;
%     L_trace.scaling = false;
%     L_trace.log_scaling = false;
%     L_trace.num_bins = 50;
%     L_trace.win = [-1,150];
%     L_trace.scale = 1;
%     L_trace.log_win = [-1.5,0];
%     L_trace.log_scale = 1;
%     L_trace.fid=22;
%     L_trace.fig_title='Trace of Laplacian';
%     L_trace.fig_filename = '08_Laplacian_trace';
%     L_trace.plots = {'linXlinY','linXlogY','linEnt'};
%     L_trace.pos_def = false;
%     config.viz.L.trace = L_trace;

    % Spectrum
    A_spec = config.viz;
    A_spec.scaling = false;
    A_spec.log_scaling = false;
    A_spec.num_bins = 100;
    A_spec.win = [-1.1,0.1];
    A_spec.scale = 1;
    A_spec.log_win = [-10,9];
    A_spec.log_scale = 1;
    A_spec.fid=11;
    A_spec.fig_title='QMI matrix eigenvalues';
    A_spec.fig_filename = '09_Aleph_spectrum';
    A_spec.pos_def = false;
    A_spec.plots = {'linXlinY','linXlogY','linEnt'};
    config.viz.A.evals = A_spec;
    
    % nonlocality?
    A_proj = config.viz;
    A_proj.scaling = false;
    A_proj.log_scaling = false;
    A_proj.num_bins = 100;
    A_proj.win = [0,L*L];
    A_proj.scale = 1;
    A_proj.log_win = [-10,9];
    A_proj.log_scale = 1;
    A_proj.fid=61;
    A_proj.fig_title='Sum over Aleph';
    A_proj.fig_filename = '10_Aleph_area';
    A_proj.pos_def = false;
    A_proj.plots = {'linXlinY','linXlogY','linEnt'};
    config.viz.A.unif_projection = A_proj;
 


end
