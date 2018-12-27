function config = analysis_config(config)

    % % Weight distribution
    config.viz.weight = config.viz;
    config.viz.weight.scaling = true;
    config.viz.weight.log_scaling = false;
    config.viz.weight.num_bins = 28;
    config.viz.weight.win = [0,2];
    config.viz.weight.scale = 1;
    config.viz.weight.log_win = [-1,14];
    config.viz.weight.log_scale = 1;
    config.viz.weight.fid=1;
    config.viz.weight.fig_title = 'Weight distribution';

    % % Degree distribution
    config.viz.degree = config.viz;
    config.viz.degree.scaling = false;
    config.viz.degree.log_scaling = false;
    config.viz.degree.num_bins = 20;
    config.viz.degree.win = [0,3];
    config.viz.degree.scale = 1;
    config.viz.degree.log_win = [-log10(3),9];
    config.viz.degree.log_scale = 1;
    config.viz.degree.fid=2;
    config.viz.degree.fig_title='Degree distribution';

    % Measures of connectedness

    % % Algebraic properties: A vs L

    % Spectrum
    config.viz.A_spec = config.viz;
    config.viz.A_spec.scaling = false;
    config.viz.A_spec.log_scaling = false;
    config.viz.A_spec.num_bins = 20;
    config.viz.A_spec.win = [0,5];
    config.viz.A_spec.scale = 1;
    config.viz.A_spec.log_win = [-2,9];
    config.viz.A_spec.log_scale = 1;
    config.viz.A_spec.fid=11;
    config.viz.A_spec.fig_title='Aleph spectral distribution';


    config.viz.L_spec = config.viz;
    config.viz.L_spec.scaling = false;
    config.viz.L_spec.log_scaling = false;
    config.viz.L_spec.num_bins = 20;
    config.viz.L_spec.win = [0,0.21];
    config.viz.L_spec.scale = 1;
    config.viz.L_spec.log_win = [-log10(3),9];
    config.viz.L_spec.log_scale = 1;
    config.viz.L_spec.fid=12;
    config.viz.L_spec.fig_title='Laplacian spectral distribution';
    % Single eigenvalues?

    % % Trace
    config.viz.A_trace = config.viz;
    config.viz.A_trace.scaling = false;
    config.viz.A_trace.log_scaling = false;
    config.viz.A_trace.num_bins = 20;
    config.viz.A_trace.win = [0,26];
    config.viz.A_trace.scale = 1;
    config.viz.A_trace.log_win = [-1.5,0];
    config.viz.A_trace.log_scale = 1;
    config.viz.A_trace.fid=21;
    config.viz.A_trace.fig_title='Aleph trace distribution';

    config.viz.L_trace = config.viz;
    config.viz.L_trace.scaling = false;
    config.viz.L_trace.log_scaling = false;
    config.viz.L_trace.num_bins = 20;
    config.viz.L_trace.win = [0,26];
    config.viz.L_trace.scale = 1;
    config.viz.L_trace.log_win = [-1.5,0];
    config.viz.L_trace.log_scale = 1;
    config.viz.L_trace.fid=22;
    config.viz.L_trace.fig_title='Laplacian trace distribution';
    % What's in the eigenvectors?

    % % 'Physical' stuff

    % VN entropy distribution
    config.viz.VN_ent = config.viz;
    config.viz.VN_ent.fig_title = 'VN Entropy distribution';
    config.viz.VN_ent.fid=31;
    config.viz.VN_ent.num_bins = 150;
end
