% Stages
%% Generate Hamiltonian

config.gen.L = 10;
config.gen.bc = 'periodic';
config.gen.W = 4;
[H, h_list] = disorder_H(config.gen);

%% Generate an initial state
% Say, the staggered state
psi_up = [1 0];
psi_down = [0 1];
psi_cell = cell(config.gen.L,1);
for ii=1:config.gen.L
    if mod(ii,2)
        psi_cell{ii} = psi_up;
    else
        psi_cell{ii} = psi_down;
    end
end
psi = Tensor(psi_cell);
rho = toDM(psi);
%% Initial graph
graph_data = rho_to_graph(rho);
%% Spectral decomposition of initial state
[vecs, vals] = eigs(H,length(H));
coefs = (psi*vecs)';

%% Time evolution
nsteps = 100;
T = linspace(0,20,nsteps);
G_t = zeros(nsteps,config.gen.L,config.gen.L);
for step = 1:nsteps
    t = T(step);
    U = exp(-1j*diag(vals)*t);
    psi_T = vecs*(coefs.*U);
    G_t(step,:,:) = rho_to_graph(toDM(psi_T));
end

%% Extract stuff
traces = zeros(nsteps,1);
C2 = zeros(nsteps,1);
for step = 1:nsteps
   traces(step) = trace(squeeze(G_t(step,:,:)));
   hc = squeeze(G_t(step,:,:));
   hc = hc - diag(diag(hc));
   C2(step) = sum(sum(hc))/(config.gen.L*(config.gen.L-1));
end

%% Plot things
sfigure(1);
clf;
subplot(1,2,1)
for i=1:config.gen.L
   plot(T,G_t(:,i,i),'.');
   hold on
end
subplot(2,2,2)
plot(T,traces/config.gen.L)
hold on
plot(T,C2)
% ylim([0,config.gen.L])
    
subplot(2,2,4)
plot(T,traces/config.gen.L-C2)

    
    

fwtext('Done')

