

%%
% For playing with spin chains. Uses QETLab for now, at least for the
% partial trace and Pauli functions. 
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
% clear all
% close all
config.gen.savepath = '/home/jacob/Projects/ent_loc/dat/'; % office machine
% % savepath = 'C:\Users\jaker\Documents\MATLAB\ent_loc\dat\'; %notebook
% % savepath = '/home/j/Documents/MATLAB/ent_loc/dat/20181111-20L13/'; %Home machine

config.gen.num_samples = 8;
config.gen.num_vecs = 10;
config.gen.L = 12;
config.gen.verbose = true;
config.gen.profile = true;
config.gen.Ws = linspace(1,7,10);
config.viz.local = false;
config.viz.global = true;
config.viz.num_bins = 30;
config.viz.scaling = false;
% profile on
% % gen_data(config.gen)
% profile off
% profile viewer



%% Import & preprocess (doesn't cache full data as it's very memory demanding)

% clear net_data;
% net_data = cell(numel(config.gen.Ws,1));
% for N=1:numel(config.gen.Ws)
%     fname = [config.gen.savepath,'L-',num2str(config.gen.L),'-W',num2str(config.gen.Ws(N)),...
%         '-N',num2str(config.gen.num_vecs),'-PBC.mat'];
%     data = load(fname);
%     net_data{N} = get_network_data(data);
%     clear data
% end


%% Plot results
% meta_fname = '/home/jacob/Projects/ent_loc/ent_loc/meta/L13_meta.mat';
% net_data = load(meta_fname);
% net_data = net_data.data;
display_opts.savefig=false;
display_opts.local = false;
display_opts.global = true;
net_data_sel = net_data([1,5]);
display_network_data(net_data,config);

% profile off
% profile viewer

%%
% close all
% display_opts.savefig = false;
% display_network_data(net_data,display_opts)







% Temperature?! High energy density ~ localized eigengraph spectrum.
% low-alpha ladder plot for Laplacian, combine L for many eigenstates of
% what is the function sum(L_eval.*L_evec)?
% Normalized Laplacian?
% Remove TrX bottleneck...
% Directions:
%       L-bits ~ decomposition into (approximate) union of subgraphs?
%           System decomposition as (generalized) graph product
%       Majorization by spectrum?


