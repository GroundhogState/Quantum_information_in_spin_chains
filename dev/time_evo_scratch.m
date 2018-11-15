% THIS BEARS INVESTIGATION

% clear all
close all
L = 4;
T = linspace(0,0.01,100);

W = 1;
ns = 1;
psi_list = zeros(ns,length(T),2^L);
L_list = zeros(ns,length(T),L,L);
rho_list = zeros(ns,length(T),2^L,2^L);
U_list = zeros(size(L_list));
V_list = zeros(ns,length(T),L);

figure()

H = disorder_H(L,W);
psi = randi([0 1], 2^L,1)
rho = toDM(psi');
v_out = vec_to_graph(psi);
L = v_out.L_list{1};
[U, V] = eigs(L);
D0=[L,U,V]

T = 0.01
psi1 = expm(-1j*T*H)*psi
rho1 = toDM(psi1);
v_out = vec_to_graph(psi1);
L1 = v_out.L_list{1};
[U1, V1] = eigs(L1);
[L1,U1,V1]-D0

T = 0.1
psi1 = expm(-1j*T*H)*psi
rho1 = toDM(psi1);
v_out = vec_to_graph(psi1);
L1 = v_out.L_list{1};
[U1, V1] = eigs(L1);
[L1,U1,V1]-D0
% 
%         psi_list(t,:) = expm(-1i*t*H)*squeeze(psi_list(1,:));
%         rho_list(t,:,:) = toDM(squeeze(psi_list(t,:))');
%         v_out = vec_to_graph(squeeze(psi_list(t,:)));
%         L_list(t,:,:) = v_out.L_list{1};
%         [U_list(t,:,:), V] = eigs(squeeze(L_list(t,:,:)));
%         V_list(t,:,:) = diag(V);
%         Ut = U_list(t,:,1);
% %         plot(t*ones(L,1),squeeze(Ut(:)),'.')
%     end
%     
% %     subplot(2,1,2)
% %     histogram(squeeze(U_list(i,:)))
% %     hold on
%     
%     figure()
%     subplot(2,1,1)
%     for j=1:L
%         V = diag(squeeze(L_list(:,j,j)));
%         plot(T,V)
%         hold on
%         subplot(2,1,2)  
%         plot(T,sum(V))
%     end

    
    