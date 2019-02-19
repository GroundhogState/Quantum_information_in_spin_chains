% Stages
%% Setup

config.gen.L = 10;
config.gen.bc = 'periodic';
config.gen.W = 9;


fwtext('Starting program')
profile on

%% Generate Hamiltonian
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
node_cent = zeros(nsteps,config.gen.L);
for step = 1:nsteps
   traces(step) = trace(squeeze(G_t(step,:,:)));
   hc = squeeze(G_t(step,:,:));
   hc = hc - diag(diag(hc));
   C2(step) = sum(sum(hc));
    Lap_offdiag = hc + hc';
    D_temp = sum(Lap_offdiag)';
    mu_temp =Lap_offdiag*D_temp./D_temp; % Weighted sum of (normalized) neighbour degrees
    norm = zeros(config.gen.L,1);
    for i=1:config.gen.L
        norm(i) = sum(D_temp) - D_temp(i); %Average of neighbour degrees
    end
    node_cent(step,:) = mu_temp./(norm);

end

fwtext('Processing done')

%% Plot things
sfigure(1);
clf;
subplot(2,2,1)
for i=1:config.gen.L
   plot(T,G_t(:,i,i),'.');
   hold on
end
subplot(2,2,2)
plot(T,traces/config.gen.L)
hold on
plot(T,C2/(config.gen.L*(config.gen.L-1)))
% ylim([0,config.gen.L])
    
subplot(2,2,3)
for i=1:config.gen.L
   plot(T(3:end),node_cent(3:end,i),'-');
   hold on
end
ylim([0,0.2])

subplot(2,2,4)
plot(T,traces/config.gen.L-C2/(config.gen.L*(config.gen.L-1)))

sfigure(2);
ngraph = 25;
for i=1:ngraph
    subplot(ceil(sqrt(ngraph)),ceil(sqrt(ngraph)),i)
    gplot = squeeze(G_t(ceil(nsteps*i/ngraph),:,:))/2;
    gplot(10,1) = 1;
    imagesc(gplot)
end
    
fwtext('ALL DONE')
%% 
profile off
profile viewer