%%
% For playing with spin chains. Uses QETLab for now, at least for the
% partial trace and Pauli functions. 
close all

% savepath = '/home/jacob/ent_loc/dat/'; % office machine
% savepath = 'C:\Users\jaker\Documents\MATLAB\ent_loc\dat\'; %notebook
savepath = '/home/j/Documents/MATLAB/ent_loc/dat/20181111-20L13/'; %Home machine

%% To DO
% Optimize TrX calls
% Why are there negative weights in weight_list?
% Plot trends vs W
% What is the structural interpretation of these spectra?
% Properties of Aleph graph...



%% Plotting (doesn't cache full data as it's very memory demanding)
% profile on
% Ws = 0:1:10;
% net_data = cell(numel(Ws,1));
% for N=1:numel(Ws)
%     fname = [savepath,'L-13-W',num2str(Ws(N)),'-N20-PBC.mat'];
%     data = load(fname);
%     net_data{N} = get_network_data(data);
%     clear data
% %     display_network_data(net_data)
% end
display_opts.savefig=false;
display_opts.local = true;
display_opts.global = false;
net_data_sel = net_data([1,3,6]);
display_network_data(net_data_sel,display_opts);

% profile off
% profile viewer

%%
% close all
% display_opts.savefig = false;
% display_network_data(net_data,display_opts)

% Generate data
% clear all
% close all
% gen_config.num_samples = 5;
% gen_config.num_vecs = 5;
% gen_config.L = 13;
% gen_config.verbose = false;
% Ws = [0:7,15];
% profile on
% data = cell(length(Ws),1);
% for i=1:numel(Ws)
%     if Ws(i) == 0
%         n_samp = 1;
%     else
%         n_samp = gen_config.num_samples;
%     end
%     if gen_config.verbose
%       fprintf('Disorder strength %f.1 ',Ws(i))
%     end
%     save_samples(Ws(i),gen_config);
% end
% profile off
% profile viewer






% Temperature?! High energy density ~ localized eigengraph spectrum.
% low-alpha ladder plot for Laplacian, combine L for many eigenstates of
% what is the function sum(L_eval.*L_evec)?
% Normalized Laplacian?
% Remove TrX bottleneck...
% Directions:
%       L-bits ~ decomposition into (approximate) union of subgraphs?
%           System decomposition as (generalized) graph product
%       Majorization by spectrum?


