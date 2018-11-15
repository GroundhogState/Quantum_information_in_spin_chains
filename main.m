

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
gen_config.savepath = '/home/jacob/Projects/ent_loc/dat/'; % office machine
% % savepath = 'C:\Users\jaker\Documents\MATLAB\ent_loc\dat\'; %notebook
% % savepath = '/home/j/Documents/MATLAB/ent_loc/dat/20181111-20L13/'; %Home machine

gen_config.num_samples = 8;
gen_config.num_vecs = 10;
gen_config.L = 12;
gen_config.verbose = true;
gen_config.profile = true;
gen_config.Ws = linspace(1,7,10);

% profile on
% % gen_data(gen_config)
% profile off
% profile viewer



%% Import & preprocess (doesn't cache full data as it's very memory demanding)


net_data = cell(numel(gen_config.Ws,1));
for N=1:numel(gen_config.Ws)
    fname = [gen_config.savepath,'L-',num2str(gen_config.L),'-W',num2str(gen_config.Ws(N)),...
        '-N',num2str(gen_config.num_vecs),'-PBC.mat'];
    data = load(fname);
    net_data{N} = get_network_data(data);
    clear data
end


%% Plot results
% meta_fname = '/home/jacob/Projects/ent_loc/ent_loc/meta/L13_meta.mat';
% net_data = load(meta_fname);
% net_data = net_data.data;
display_opts.savefig=false;
display_opts.local = false;
display_opts.global = true;
net_data_sel = net_data([1,5]);
display_network_data(net_data,display_opts);

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


