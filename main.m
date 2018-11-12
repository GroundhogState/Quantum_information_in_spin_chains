%%
% For playing with spin chains. Uses QETLab for now, at least for the
% partial trace and Pauli functions. 

close all

savepath = '/home/jacob/ent_loc/dat/';
data = [];
num_samples = 10;
num_vecs = 15;
L = 13;
W = 1:8;
profile on
% data=save_samples(L,W,num_samples,num_vecs,savepath);
parfor i=1:numel(W)
    if W(i) == 0
        n_samp = 1
    else
        n_samp = num_samples;
    end
    data=save_samples(L,W(i),n_samp,num_vecs,savepath);
end
profile off
profile viewer

% fname = ['/home/jacob/ent_loc/dat/E_mat/L-13-W6-N30-PBC.mat'];
% data = load(fname);

% Ws = 1:3:7;
% profile on

% S = 1:2;
% % for N=1:numel(Ws)
%     W  = Ws(2);
% %     fname = ['/home/jacob/Desktop/ent_loc/dat/L-13-W',num2str(W),'-N30-PBC.mat'];
% %     data = load(fname);
%     for k=1:numel(data.samp)
%         for l=1:numel(S)
%            V_temp = data.samp{k}.vecs(:,S(l));
%            rho_temp = conj(V_temp').*V_temp;
% %            dims = 2*ones(data.L,1);
% %            systems = 1:data.L;
% %            systems(3) = [];
% %            pt_test = TrX(rho_temp,systems,dims);
%            % USE TRX INSTEAD OF QETLAB
%            L = vec_to_graph(V_temp);
%         end
% 
%     end
% % end
% profile off
% profile viewer


% for N=1:numel(Ws)
%     figure();
%     W  = Ws(N);
%     fname = ['/home/jacob/Desktop/ent_loc/dat/L13-W',num2str(W),'-N13.mat'];
%     data = load(fname);
%     L_coll = cellfun(@(x) x.L_list,data.samp,'UniformOutput',false);
%     for k=1:numel(data.samp)
%         L_list = L_coll{k};
%         DS=data.samp{k};
%         E=rescale(DS.nrg(DS.sel));
%         colormap winter(110)
%         cm = colormap;
%         A_sum = zeros(size(L_list{1}));
%         for i=1:numel(L_list)
%             
%             if ~isequal(zeros(size(L_list{i})),L_list{i})
% 
%                 [L1,R,R2,S,A]=inspect_state_graph(L_list{i},ceil(100*E(i)+.5)); 
%                 A_sum = A_sum + A;
%                 subplot(3,3,3)
%                 a=plot(E(i), L1,'x');
%                 a.Color = cm(ceil(100*E(i)+.5),:);
%                 ylim([0,15])
%                 title('Spectral power')
%                 hold on
%                 
%                 subplot(3,3,4)
%                 b=plot(E(i),S,'x');
%                 b.Color = cm(ceil(100*E(i)+.5),:);
%                 ylim([0,2.5])
%                 title('Spectral entropy')        
%                 hold on
% 
%                 subplot(3,3,5)
%                 c=plot(E(i),R,'x');
%                 c.Color = cm(ceil(100*E(i)+.5),:);
%                 title('N0/N')
%                 ylim([0,1])
%                 hold on
%                 
%                 subplot(3,3,6)
%                 d=plot(E(i),R2,'x');
%                 d.Color = cm(ceil(100*E(i)+.5),:);
%                 ylim([0,1])
%                 title('Power concentration')
%                 hold on
%             end
%         end
%         subplot(3,3,1)
%         G = graph(rescale(A_sum.*(A_sum>0.01)));
%         LW = G.Edges.Weight;
%         LWL=(rescale(log(LW))+1).^3;
%         plot(G,'Layout','circle','LineWidth',LW)
%         hold off
% 
%         title(['W=',num2str(W)])
%     end
% end
% profile off
% profile viewer



%To do: Store disorder lists, Laplacian (& some spectral data_temp) for varying
%L,W as .mat struct. Build I/O
% Plots: L1 and L2 norm of spectra for many eigenvalues;
% norm1(Laplacian(Energy)) etc
% 'Condensation'/localization of state spectra vs E and W
% Temperature?! High energy density ~ localized eigengraph spectrum.
% What is the structural interpretation of these spectra?
% low-alpha ladder plot for Laplacian, combine L for many eigenstates of
% single disorder 
% Vizualise the function sum(L_eval.*L_evec) on graph nodes
% Normalized Laplacian?
% SMALL demo systems
% Remove PermuteSystems bottleneck...
% Directions:
%       L-bits ~ decomposition into (approximate) union of subgraphs?
%           System decomposition as (generalized) graph product
%       Degree distribution!
%       Weight distribution!
%       Majorization by spectrum?
%       Linear-algebraic entanglement measures

% Observations: Localized phase seems to have generically lower spectral
% entropy and the 'ground state' mode population grows. Spectral power
% seems lower, too, but maybe more interesting is the entropy. 
% Product states have no links between components!