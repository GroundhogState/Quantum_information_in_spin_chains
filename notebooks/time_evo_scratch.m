% THIS BEARS INVESTIGATION
% GOODNESS ME.
% Product states are completely disconnected. They get 'close' to locality
% sometimes.
% Local Hamiltonians leave Aleph completely invariant.
% The norm of Aleph does seem to reflect some kind of nonlocality. 
% So WHAT governs the evolution of Aleph?
    % It would be most instructive to look at a single Bell pair. 
% clear all
for NN=1
NN
L = 7;
T = linspace(-2,2,100);

psi_list = cell(L,1);
for i=1:L
    psi_list{i} = rand_qubit;
end
% rho_prod = Tensor(psi_list);


W = 1;

% H = disorder_H(L,W);
H = gen_onsite(L,rand(L,1));
psi = rand(2^L,1); % THIS IS DEFINITELY NOT LOCAL

ns = 1;

U_list = zeros(L,2,2);
V_list = zeros(ns,length(T),L);

vals = zeros(numel(T),L);
vecs = zeros(numel(T),L,L);
traces = zeros(numel(T),1);
dets = zeros(numel(T),1);
TMI = zeros(numel(T,1));
weights = zeros(numel(T), L*(L-1)/2);


% rho = toDM(psi');
% v_out = vec_to_graph(psi);
% A = v_out.A_list{1};
% [U, V] = eigs(A);
% D0=[A,U,V]

for t=1:numel(T)
%     rho1 = expm(-1j*T(t)*H)*rho_prod*expm(-1j*T(t)*H)';
    psi1 = expm(-1j*T(t)*H)*psi;
    rho1 = toDM(psi1);
    v_out = rho_to_graph({rho1});
    A1 = v_out.A_list{1};
    hollow = A1- diag(diag(A1));
%     w = triu(hollow,1);
%     w = w(w>0);
%     weights(t,:)=w;
    TMI(t) = 0.5*sum(sum(hollow));
    [U1, V1] = eigs(A1,L);
    vals(t,:) = diag(V1);
    vecs(t,:,:) = U1;
    traces(t) = trace(A1)/(2*L);
    dets(t) = det(A1);
end


%% Plotting 
% close all
% figure()

for u=1:L
    subplot(4,1,1)
    plot(T,(vals(:,u)));
    hold on
    for v = 1:L
        subplot(4,1,2)
        plot(T,abs(vecs(:,u,1)))
        hold on
    end
end

subplot(4,2,5)
plot(T,traces)
hold on

subplot(4,2,6)
plot(T,TMI/4)
hold on
subplot(4,1,4)


for t=1:numel(T)
   obj = norm(sum(squeeze(vecs(t,:,:))*diag(vals(t,:)),2));
   plot(T(t),obj,'.')
   hold on
   
end
end

% for t=1:numel(T)
%     psi1 = expm(-1j*T(t)*H)*psi;
%     rho1 = toDM(psi1);
%     v_out = vec_to_graph(psi1);
%     A1 = v_out.A_list{1};
%     hollow = A1- diag(diag(A1));
%     w = triu(hollow,1);
%     w = w(w>0);
%     weights(t,:)=w;
%     TMI(t) = 0.5*sum(sum(hollow));
%     [U1, V1] = eigs(A1,L);
%     vals(t,:) = diag(V1);
%     vecs(t,:,:) = U1;
%     traces(t) = trace(A1)/(2*L);
%     dets(t) = det(A1);
% end
    
    
