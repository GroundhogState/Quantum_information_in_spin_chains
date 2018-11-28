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
% % savepath = 'C:\Users\jaker\Documents\MATLAB\ent_loc\dat\'; %notebook
% % savepath = '/home/j/Documents/MATLAB/ent_loc/dat/20181111-20L13/'; %Home machine



config.gen.L = 13;              % System size
config.gen.Ws = linspace(1,8,10); %Disorder values
config.gen.bc = 'periodic';     % 'periodic' or 'open'
config.gen.num_samples = 8;     % # of disorder realizations
config.gen.verbose = true;          %Additional output (currently useless)
config.gen.profile = true;      % Runs profiler over the generation loop

% Now sampling from middle of spectrum
config.gen.num_vecs = 15;            
config.gen.sel = (2^config.gen.L)/2-config.gen.num_vecs:(2^config.gen.L)/2+config.gen.num_vecs; 

config.viz.local = false;
config.viz.global = true;
config.viz.num_bins = 30;
config.viz.scaling = false;

%% Generate eigenstate data
% gen_data(config.gen)


%% Import & preprocess (doesn't cache full data as it's very memory demanding)

clear net_data;
net_data = cell(numel(config.gen.Ws,1));
for N=1:numel(config.gen.Ws)
    N
    fname = [config.gen.savepath,'L-',num2str(config.gen.L),'-W',num2str(config.gen.Ws(N)),...
        '-N',num2str(config.gen.num_vecs),'-PBC.mat'];
    data = load(fname);
    net_data{N} = get_network_data_oldform(data);
    clear data
end


%% Plot results
display_opts.savefig=false;
display_opts.local = false;
display_opts.global = true;
net_data_sel = net_data([1,5]);
config.viz.cutoff = 1e-10;

display_network_data(net_data,config);




% Temperature?! High energy density ~ localized eigengraph spectrum.
% low-alpha ladder plot for Laplacian, combine L for many eigenstates of
% what is the function sum(L_eval.*L_evec)?
% Normalized Laplacian?
% Remove TrX bottleneck...
% Directions:
%       L-bits ~ decomposition into (approximate) union of subgraphs?
%           System decomposition as (generalized) graph product
%       Majorization by spectrum?


