%% Setting up

fwtext('Starting program')
profile on

L = 7;
config.verbose = 1;

% System setup
config.gen.L = L;
config.gen.bc = 'periodic';
config.gen.Ws = 1:10;
config.gen.num_samples = nan;

savepath = 'C:\data\dyn_data\';
config.gen.savepath=fullfile(savepath,sprintf('L=%u',config.gen.L));
config.gen.run = false;

% initial state
% Say, the staggered state
psi_cell = cell(config.gen.L,1);
for ii=1:config.gen.L
    if mod(ii,2)
        psi_cell{ii} = [1 0]; %spin-up
    else
        psi_cell{ii} = [0 1];% spin-down
    end
end
config.gen.psi_0 = Tensor(psi_cell);
% config.gen.psi_0 = toDM(psi);
% time evolution
config.gen.nsteps = 50;
config.gen.Tmax = 10;

% % Generate the data 
if config.gen.run
    data_sample = gen_dyn_data(config);
end
fwtext('Generation done')

%% Import &  Extract stuff

config.imp.L = L;
savepath = 'C:\Data\dyn_data';
config.imp.savepath=fullfile(savepath,sprintf('L=%u',config.imp.L));
config.imp.num_files = nan;
config.imp.starting_timestep = 10;
import_data = import_dyn_data(config);
fwtext('Importing complete')

%% Process

fwtext('Processing')
config.viz.L = L;
savepath = 'C:\Data\dyn_data';
config.viz.savepath=fullfile(savepath,sprintf('L=%u',config.viz.L));
config = dyn_analysis_config(config);
config.viz.W_list = import_data.W;
config.viz.show_plots = true;
config.viz.save = true;
% Plot various things versus VNE; degree, centrality?

proc_data = dyn_process(import_data,config);
fwtext('Processing done')
%%
% Looping over multiple lengths; this will be abstracted shortly
config.L.savepath = 'C:\Data\dyn_data';
config.L.num_files = nan;

loop_data = dir_loop_import(config);
fwtext('Loop import done')

show_L_trends(loop_data,config)

fwtext('ALL DONE')


% Todo: Edit so it can pick only the latest file; this works for now
% assuming things are timestamped. Maybe a config field.
% Change printed progress for percentage/progress bar
% STOP PASSING RAW DATA BACK UP?!
% change process save to include a field name!!
% Pick a field and compare it
% sfield = {'G','node_cent'};,cm(N,:)
% Hacky solution so I can get the actual function going...

% Todo: pass dir_plot function a key handle (W, L, etc)
% Which auto-selects colour map
% Ensure Ws are passed cleanly up to this function...