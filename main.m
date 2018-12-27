% close all



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

%% Generate data
% % config.gen.savepath = '/home/jacob/Projects/ent_loc/dat/'; % office machine
% %
% %
%% Should take about 78 hours
config.gen.L = 13;              % System size
config.gen.savepath = '/home/jacob/Projects/ent_loc/dat/L13_dat/';
config.gen.Ws = linspace(0,8,20);  %Disorder values

config.gen.bc = 'periodic';     % 'periodic' or 'open'
config.gen.num_samples = 20;     % # of disorder realizations
config.gen.save = true;
% Sample from the top, middle, and bottom of the spectrum
config.gen.sel = 4040:4080;
config.gen.num_vecs = numel(config.gen.sel);
% % Generate eigenstate data
% gen_data(config);
% % CALL ^ WITH CAUTION
% clear all
% config.gen.savepath = '/home/jacob/Projects/ent_loc/dat/L10_dat/';
% config.gen.L = 10;              % System size
% config.gen.Ws = linspace(0,10,20);  %Disorder values
% config.gen.bc = 'periodic';     % 'periodic' or 'open'
% config.gen.num_samples = 50;     % # of disorder realizations
% config.gen.save = true;
% % Sample from the top, middle, and bottom of the spectrum
% config.gen.sel = 450:550;
% config.gen.num_vecs = numel(config.gen.sel);
% config.gen.verbose = 3;
% % % Generate eigenstate data
profile on
data=gen_data(config);
profile off
profile viewer
% % CALL ^ WITH CAUTION


%% Import & Process
% % Visualize & analyze results
% Needs a good clean! & to be better modularized...

config.gen.savepath = '/home/jacob/Projects/ent_loc/dat/L10_dat/';
config.gen.L = 10;              % System size
config.gen.Ws = linspace(0,10,20);  %Disorder values

net_data = cell(numel(config.gen.Ws,1));
config.gen.Ws = config.gen.Ws(1:end);
fwtext({'Starting graph import & process L=%d',config.gen.L})
for N=1:numel(config.gen.Ws)
    fprintf('Importing file %.f/%.f, W=%f\n',N,length(config.gen.Ws),config.gen.Ws(N))
    fname = [config.gen.savepath,'L-',num2str(config.gen.L),'-W',num2str(config.gen.Ws(N)),'-PBC.mat'];
    data = load(fname);
    net_data{N} = get_network_data(data);
    clear data
end
agg_data{1}= system_proc_10(net_data,config);

config.gen.savepath = '/home/jacob/Projects/ent_loc/dat/L11_dat/';
config.gen.L = 11;              % System size
config.gen.Ws = linspace(0,10,20);  %Disorder values
net_data = cell(numel(config.gen.Ws,1));
config.gen.Ws = config.gen.Ws(1:end);
fwtext({'Starting graph import & process L=%d',config.gen.L})
for N=1:numel(config.gen.Ws)
    fprintf('Importing file %.f/%.f, W=%f\n',N,length(config.gen.Ws),config.gen.Ws(N))
    fname = [config.gen.savepath,'L-',num2str(config.gen.L),'-W',num2str(config.gen.Ws(N)),'-PBC.mat'];
    data = load(fname);
    net_data{N} = get_network_data(data);
    clear data
end
agg_data{2} = system_proc_11(net_data,config);


config.gen.L = 12;              % System size
config.gen.savepath = '/home/jacob/Projects/ent_loc/dat/L12_dat/';
config.gen.Ws = sort([linspace(0,5,10),linspace(0,5,10)+5/9]);  %Disorder values
net_data = cell(numel(config.gen.Ws,1));
config.gen.Ws = config.gen.Ws(1:end-1);
fwtext({'Starting graph import & process L=%d',config.gen.L})
for N=1:numel(config.gen.Ws)
    fprintf('Importing file %.f/%.f, W=%f\n',N,length(config.gen.Ws),config.gen.Ws(N))
    fname = [config.gen.savepath,'L-',num2str(config.gen.L),'-W',num2str(config.gen.Ws(N)),'-PBC.mat'];
    data = load(fname);
    net_data{N} = get_network_data(data);
    clear data
end
agg_data{3} = system_proc_12(net_data,config);


config.gen.L = 13;              % System size
config.gen.savepath = '/home/jacob/Projects/ent_loc/dat/L13_dat/';
config.gen.Ws = linspace(0,8,20);  %Disorder values
net_data = cell(numel(config.gen.Ws,1));
config.gen.Ws = config.gen.Ws(1:end);
fwtext({'Starting graph import & process L=%d',config.gen.L})
for N=1:numel(config.gen.Ws)
    fprintf('Importing file %.f/%.f, W=%f\n',N,length(config.gen.Ws),config.gen.Ws(N))
    fname = [config.gen.savepath,'L-',num2str(config.gen.L),'-W',num2str(config.gen.Ws(N)),'-PBC.mat'];
    data = load(fname);
    net_data{N} = get_network_data(data);
    clear data
end
agg_data{4} = system_proc_13(net_data,config);


fwtext('Main complete');
%%

cm2 = colormap(magma(5));

% plot_over_L('weights

weight_entropy = cellfun(@(x) x.weights.entropy/x.weights.entropy(1), agg_data,'UniformOutput',false);
sfigure(41);
for k=1:4
    plot(weight_entropy{k},'Color',cm2(k,:))
    hold on
end
title('Weight entropy')
legend('L=10','L=11','L=12','L=13')

degree_entropy = cellfun(@(x) x.degree.entropy/x.degree.entropy(1), agg_data,'UniformOutput',false);
sfigure(42);
for k=1:4
    plot(degree_entropy{k},'Color',cm2(k,:))
    hold on
end
title('Degree entropy')
legend('L=10','L=11','L=12','L=13')

lap_spec_entropy = cellfun(@(x) x.lap_spec.entropy/x.lap_spec.entropy(1), agg_data,'UniformOutput',false);
sfigure(43);
for k=1:4
    plot(lap_spec_entropy{k},'Color',cm2(k,:))
    hold on
end
title('Lap spec entropy')
legend('L=10','L=11','L=12','L=13')

aleph_spec_entropy = cellfun(@(x) x.aleph_spec.entropy/x.aleph_spec.entropy(1), agg_data,'UniformOutput',false);
sfigure(44);
for k=1:4
    plot(aleph_spec_entropy{k},'Color',cm2(k,:))
    hold on
end
title('Aleph spec entropy')
legend('L=10','L=11','L=12','L=13')

lap_trace_entropy = cellfun(@(x) x.lap_trace.entropy/x.lap_trace.entropy(1), agg_data,'UniformOutput',false);
sfigure(45);
for k=1:4
    plot(lap_trace_entropy{k},'Color',cm2(k,:))
    hold on
end
title('Lap trace entropy')
legend('L=10','L=11','L=12','L=13')

aleph_trace_entropy = cellfun(@(x) x.aleph_trace.entropy/x.aleph_trace.entropy(1), agg_data,'UniformOutput',false);
sfigure(46);
for k=1:4
    plot(aleph_trace_entropy{k},'Color',cm2(k,:))
    hold on
end
title('Aleph trace entropy')
legend('L=10','L=11','L=12','L=13')

% Temperature?! High energy density ~ localized eigengraph spectrum.
% low-alpha ladder plot for Laplacian, combine L for many eigenstates of
% what is the function sum(L_eval.*L_evec)?
% Normalized Laplacian?
% Remove TrX bottleneck...
% Directions:
%       L-bits ~ decomposition into (approximate) union of subgraphs?
%           System decomposition as (generalized) graph product
%       Majorization by spectrum?
