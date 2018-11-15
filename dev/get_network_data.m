function network_data = network_data(data)

%Accepts ONE input data.mat file and returns a struct network_data
    kmax = numel(data.samp); 

    data.num_eigs = numel(data.samp{1}.sel);
    network_data.L = data.L;
    network_data.W = data.W;
    network_data.num_eigs = data.num_eigs;
    network_data.num_samples = length(data.samp);
    network_data.entropy_VN=zeros(kmax,data.num_eigs,data.L);
    network_data.energies = zeros(kmax,data.num_eigs);%%HACK FOR NOW

    network_data.laplacians = zeros(kmax,data.num_eigs,data.L,data.L);
    network_data.aleph = zeros(kmax,data.num_eigs,data.L,data.L);
    network_data.lap_evals = zeros(kmax,data.num_eigs,data.L);
    network_data.entropies = zeros(kmax,data.num_eigs);
    network_data.traces = zeros(kmax,data.num_eigs);
    network_data.determinants = zeros(kmax,data.num_eigs);
    network_data.Qs = zeros(kmax,data.num_eigs);
    network_data.degree_list = zeros(kmax,data.num_eigs,data.L);
    network_data.weight_list = zeros(kmax,data.num_eigs,data.L*(data.L-1)/2);
    network_data.A.A = zeros(kmax,data.num_eigs,data.L,data.L);
    network_data.A.vecs=zeros(kmax,data.num_eigs,data.L,data.L);
    network_data.A.eigs=zeros(kmax,data.num_eigs,data.L);

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
        
                network_data.A.A(k,ii,:,:) = data.samp{k}.graph_data.A_list{ii};
                [network_data.A.vecs(k,ii,:,:), eigs_temp] = eigs(data.samp{k}.graph_data.A_list{ii},network_data.L);
                network_data.A.eigs(k,ii,:) = diag(eigs_temp);

            end
        end 
%         clear sample
    end
%     clear data

    network_data.fielder_vals = squeeze(network_data.lap_evals(:,:,end-1));

end