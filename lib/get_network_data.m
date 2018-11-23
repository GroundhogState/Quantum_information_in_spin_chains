function network_data = get_network_data(data)

%Accepts ONE input data.mat file and returns a struct network_data
    kmax = numel(data.samp); 

    data.num_eigs = numel(data.samp{1}.sel);
    %Parameters
    network_data.L = data.L;
    network_data.W = data.W;
    network_data.num_eigs = data.num_eigs;
    network_data.num_samples = length(data.samp);
    
    %Major objects - imported
    network_data.laplacians = zeros(kmax,data.num_eigs,data.L,data.L);
    network_data.aleph = zeros(kmax,data.num_eigs,data.L,data.L);
    
    %Spectral stuff - imported
    network_data.lap_evals = zeros(kmax,data.num_eigs,data.L);
    network_data.entropies = zeros(kmax,data.num_eigs);
    network_data.traces = zeros(kmax,data.num_eigs);
    network_data.determinants = zeros(kmax,data.num_eigs);
    % Physical stuff - imported
    network_data.entropy_VN=zeros(kmax,data.num_eigs,data.L);
    network_data.energies = zeros(kmax,data.num_eigs);
    % Graph stuff - imported
    network_data.degree_list = zeros(kmax,data.num_eigs,data.L);
    network_data.weight_list = zeros(kmax,data.num_eigs,data.L*(data.L-1)/2);
    network_data.frac_weight_list = zeros(kmax,data.num_eigs,data.L*(data.L-1)/2);
    
    %Generated 
    network_data.A.A = zeros(kmax,data.num_eigs,data.L,data.L);
    network_data.A.vecs=zeros(kmax,data.num_eigs,data.L,data.L);
    network_data.A.eigs=zeros(kmax,data.num_eigs,data.L);
    network_data.node_centrality= zeros(kmax,data.num_eigs,data.L);

    for k=1:kmax        
        network_data.energies(k,:)=rescale(data.samp{k}.nrg(data.samp{k}.sel));
        L_list = data.samp{k}.graph_data.L_list;
        for ii=1:data.num_eigs
            if ~isequal(zeros(size(L_list{ii})),L_list{ii})
                % Retrieve data

                Laplacian = data.samp{k}.graph_data.L_list{ii};
                [~,L_vals] = eigs(Laplacian,data.L); 
                L_vals = diag(L_vals); % L is positive semidefinite
                evals_nz = L_vals(1:end-1);
                mask = triu(ones(network_data.L),1)==1;

                weight_all = -Laplacian(mask);
                TraceL = sum(evals_nz);

                %Write to output obj
                network_data.laplacians(k,ii,:,:) = Laplacian;

                network_data.entropy_VN(k,ii,:) = 0.5*diag(data.samp{k}.graph_data.A_list{ii});
                network_data.lap_evals(k,ii,:) = L_vals;
                network_data.traces(k,ii) = TraceL;
                network_data.determinants(k,ii) =  abs(prod(evals_nz));

                network_data.entropies(k,ii) = -sum((evals_nz/TraceL).*log(evals_nz/TraceL));
                network_data.Qs(k,ii) = max(evals_nz)/TraceL;
                network_data.degree_list(k,ii,:) = diag(Laplacian);
                network_data.weight_list(k,ii,:) = weight_all(:);
                network_data.frac_weight_list(k,ii,:) = weight_all(:)/sum(weight_all);
                A_temp = squeeze(data.samp{k}.graph_data.A_list{ii}); 
                A_temp = A_temp - 2*diag(diag(A_temp));
                
                network_data.A.A(k,ii,:,:) = A_temp;
                hollow = A_temp - diag(diag(A_temp));
                network_data.degree_list(k,ii,:) = sum(hollow);
                [network_data.A.vecs(k,ii,:,:), eigs_temp] = eigs(A_temp,network_data.L);
                network_data.A.eigs(k,ii,:) = abs(diag(eigs_temp));
                eigs_temp = eigs_temp(eigs_temp>0);
                network_data.A.ents(k,ii) = -sum((eigs_temp/sum(eigs_temp)).*log10(eigs_temp/sum(eigs_temp)));
                network_data.A.dets(k,ii) = det(A_temp);
                network_data.A.trcs(k,ii) = trace(A_temp)/(2*network_data.L);
                network_data.A.diam(k,ii) = trace(expm(-A_temp))/network_data.L;
                network_data.A.hollow(k,ii,:,:) = hollow;
                network_data.A.nonlocality(k,ii) = sum(weight_all(:));
                network_data.A.eta(k,ii) = 2*trace(hollow*hollow)/(network_data.L*(network_data.L-1));


                network_data.total_ent(k,ii) = sum(sum(A_temp));

                delta = squeeze(network_data.degree_list(k,ii,:));
                mu_temp =squeeze(hollow*delta)./delta;
                norm = zeros(data.L,1);
                for i=1:data.L
                    norm(i) = sum(delta) - delta(i);
                end
                network_data.node_centrality(k,ii,:) = (data.L-1)*mu_temp./norm;
            end
        end 
%         clear sample
    end
%     clear data

    network_data.fielder_vals = squeeze(network_data.lap_evals(:,:,end-1));

end