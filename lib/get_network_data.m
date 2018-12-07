function network_data = get_network_data(data)

% This function is a part-B to the gen_data function, designed to be a bit
% more flexible. The objects here could *probably* be ported to be
% constructed in individual analyses, which might actually enhance
% modularity. That'll be left for later - the vis/anal parts will act on
% these, to save the expense of repeatedly computing them whenever later
% functions called. Of course, caching large calls is an option.

%Accepts ONE input data.mat file (single disorder strength) and returns a struct network_data
% Input field for each cell in data.samp{}
%       L               Spin chain length
%       W               Disorder bandwidth
%       num_eigs        Number of selected eigenvalues
%       sel             Indices of selected eigen*
%       num_samples     Number of disorder realizations
%       nrg             List of selected RESCALED eigenvalues corresponding to
%       v_sel           List of selected eigenvalues which are turned into
%       A_list          State graph objects generated by vec_to_graph
% Output: 
%   struct network_data with fields defined below, indexed by {realization#, eigenvalue}

    kmax = numel(data.samp); 
    % Importing parameters
    network_data.prm.L = data.L;
    network_data.prm.W = data.W;
    network_data.prm.num_eigs = data.num_eigs;
    network_data.prm.num_samples = data.num_samples;    
    
    % Setting up output
    % Laplacian properties
    network_data.L.Laplacian = zeros(kmax,network_data.prm.num_eigs,data.L,data.L);
    network_data.L.evals = zeros(kmax,network_data.prm.num_eigs,data.L);
    network_data.L.evecs = zeros(kmax,network_data.prm.num_eigs,data.L,data.L);
   
    % Aleph properties
    network_data.A.Aleph = zeros(kmax,network_data.prm.num_eigs,data.L,data.L);
    network_data.A.evals = zeros(kmax,network_data.prm.num_eigs,data.L);
    network_data.A.evecs = zeros(kmax,network_data.prm.num_eigs,data.L,data.L);
    network_data.A.trace = zeros(kmax,network_data.prm.num_eigs,data.L);
%     network_data.
    
    % Graph properties
    network_data.G.degree_list = zeros(kmax,network_data.prm.num_eigs,data.L);
    network_data.G.weight_list = zeros(kmax,network_data.prm.num_eigs,data.L*(data.L-1)/2);
    network_data.G.node_centrality = zeros(kmax,network_data.prm.num_eigs,data.L);
    
    % Physical properties
    network_data.P.entropy_VN=zeros(kmax,network_data.prm.num_eigs,data.L);
    network_data.P.nrg = zeros(kmax,network_data.prm.num_eigs);

    
    for k=1:kmax        
%         nrg_full=data.samp{k}.nrg;
        network_data.P.nrg(k,:) = data.samp{k}.nrg;
        A_list = data.samp{k}.A_list;
        for ii=1:network_data.prm.num_eigs
                
                % Aleph properties
                Aleph = squeeze(A_list{ii});
                network_data.A.Aleph(k,ii,:,:) = Aleph;                               
                [network_data.A.evecs(k,ii,:,:),val_temp] = eigs(Aleph,data.L);
                network_data.A.evals(k,ii,:) = diag(val_temp);
                network_data.A.trace(k,ii,:) = trace(Aleph); % = 2* total onsite entropy
                
                % Generate additional properties
                A_temp = Aleph - diag(diag(Aleph));
                D_temp = sum(A_temp)';  
                mask = triu(ones(network_data.prm.L),1)==1;
                weight_all = A_temp(mask);
                mu_temp =A_temp*D_temp./D_temp; % Weighted sum of (normalized) neighbour degrees
                norm = zeros(data.L,1);
                for i=1:data.L
                    norm(i) = sum(D_temp) - D_temp(i); %Average of neighbour degrees
                end
                
                % Laplacian properties
                network_data.L.Laplacian(k,ii,:,:) = -(A_temp - diag(D_temp));    
                [network_data.L.evecs(k,ii,:,:),v_temp] = eigs(network_data.L.Laplacian(k,ii),data.L);
                network_data.L.evals(k,ii,:) = diag(v_temp);

                % Graph properties
                network_data.G.degree_list(k,ii,:) = D_temp;
                network_data.G.weight_list(k,ii,:) = weight_all(:);
                network_data.G.node_centrality(k,ii,:) = norm.*mu_temp; %= sum(deg_i w_ij) / avg(d_j) for all i in Neighb(j)

                % Physical properties
                network_data.P.entropy_VN(k,ii,:) = 0.5*diag(Aleph);
                network_data.P.TMI(k,ii,:) = sum(sum(Aleph));
        end % Loop over eigenvectors
    end% Loop over samples
    
end