close all



%% To DO
% Optimize TrX calls/faster trace
% Fit distributions & plot vs W

% What is the structural interpretation of these spectra?
% Sum of all weights ~ distance from locality ~ divergence from volume law?

    % Compare Fielder vector with NN couplings - where does it suggest
    % partition?
    % Spectral properties of A, G.
    % Higher-order degrees?
        % D1 = total weight of links
        % D2 = total weight of links to second neighbours
        % Tr(exp(L))?!

    
    % Try fast-trace
%% Generate data
config.gen.savepath = '/home/jacob/Projects/ent_loc/dat/'; % office machine
% config.gen.savepath = '/home/jacob/Projects/ent_loc/dat/L10_test/'; % office machine

    
% % savepath = 'C:\Users\jaker\Documents\MATLAB\ent_loc\dat\'; %notebook
% % savepath = '/home/j/Documents/MATLAB/ent_loc/dat/20181111-20L13/'; %Home machine


% config.gen.L = 13;              % System size
% config.gen.Ws = linspace(0,5,10);  %Disorder values
% config.gen.bc = 'periodic';     % 'periodic' or 'open'  
% config.gen.num_samples = 20;     % # of disorder realizations
% config.gen.verbose = true;          %Additional output (currently useless)
% config.gen.save = true;
% % Sample from the top, middle, and bottom of the spectrum
% config.gen.sel = 4040:4080;
% config.gen.num_vecs = numel(config.gen.sel);   

%% Should take about 7-8 hours
% config.gen.L = 13;              % System size
% config.gen.Ws = linspace(0,8,20);  %Disorder values
% config.gen.bc = 'periodic';     % 'periodic' or 'open'  
% config.gen.num_samples = 20;     % # of disorder realizations
% config.gen.verbose = true;          %Additional output (currently useless)
% config.gen.save = true;
% % Sample from the top, middle, and bottom of the spectrum
% config.gen.sel = 4040:4080;
% config.gen.num_vecs = numel(config.gen.sel);   
% %% Generate eigenstate data
% gen_data(config);
%% CALL ^ WITH CAUTION



%% Import & Process 
net_data = cell(numel(config.gen.Ws,1));
config.gen.L = 12;
config.gen.savepath = '/home/jacob/Projects/ent_loc/dat/L12_dat/'
config.gen.Ws = sort([linspace(0,5,10)+5/18,linspace(0,5,10)]); 
fwtext('Starting graph import & process')
for N=1:numel(config.gen.Ws)
    fprintf('Importing file %.f/%.f, W=%f\n',N,length(config.gen.Ws),config.gen.Ws(N))
    fname = [config.gen.savepath,'L-',num2str(config.gen.L),'-W',num2str(config.gen.Ws(N)),'-PBC.mat'];
    data = load(fname);
    net_data{N} = get_network_data(data);
    clear data
end

% Plot results
config.viz.local = false;
config.viz.global = true;
config.viz.num_bins = 30;
config.viz.scaling = false;
% display_opts.savefig=false;
% display_opts.local = false;
% display_opts.global = true;

%         config.viz.scaling = true;
%         config.viz.log_scaling = true;
%         config.viz.num_bins = 20;
%         config.viz.cutoff = 1e-10;
%         config.viz.scale = 50;
%         config.viz.log_cutoff = 0.5*1e-2;
%         config.viz.log_scale = 2*1e-3;
%         config.viz.fid=1;
display_network_data(net_data,config);

% weight_viz = weight_dist_analysis(net_data,config);



% Temperature?! High energy density ~ localized eigengraph spectrum.
% low-alpha ladder plot for Laplacian, combine L for many eigenstates of
% what is the function sum(L_eval.*L_evec)?
% Normalized Laplacian?
% Remove TrX bottleneck...
% Directions:
%       L-bits ~ decomposition into (approximate) union of subgraphs?
%           System decomposition as (generalized) graph product
%       Majorization by spectrum?


