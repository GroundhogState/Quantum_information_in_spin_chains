function dyn_data_sample = gen_dyn_data(config)

if isnan(config.gen.num_samples)
    while true
        for i=1:numel(config.gen.Ws)
        % don't pass W=0, that's silly
            for ii=1:numel(config.gen.Ws)
               dyn_data_sample = dyn_data_core(config,config.gen.Ws(ii));
            end
            fprintf('\n')
        end
    end
else
    for k=1:config.gen.num_samples
        if config.verbose>1
            fprintf('--Sample %u/%u\n',k,config.gen.num_samples)
        end
        for i=1:numel(config.gen.Ws)
            dyn_data_sample = dyn_data_core(config,i);
        end
        fprintf('\n')
    end
end
    
end

function dyn_data = dyn_data_core(config,idx)

        % Generate Hamiltonian
        W = config.gen.Ws(idx);
        config.gen.W = W;

        if config.verbose
            fwtext({'Generating H, W=%.3f',W})
        end
        [H, h_list] = disorder_H(config.gen);

        psi = config.gen.psi_0;
        % Initial graph
        % Spectral decomposition of initial state
        [vecs, vals] = eigs(H,length(H));
        coefs = (psi*vecs)';

        % Time evolution
        if config.verbose
            fwtext('Graphing over time')
        end
        nsteps = config.gen.nsteps;
        T = linspace(0,config.gen.Tmax,nsteps);
        G_t = zeros(nsteps,config.gen.L,config.gen.L);
        for step = 1:nsteps
            t = T(step);
            U = exp(-1j*diag(vals)*t);
            psi_T = vecs*(coefs.*U);
            G_t(step,:,:) = rho_to_graph(toDM(psi_T));
        end

        % Calculate outputs
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

        % Populate structure
        dyn_data.P.h_list = h_list;
        dyn_data.P.W = config.gen.W;
        dyn_data.P.init = psi;
        dyn_data.P.bc = config.gen.bc;
        dyn_data.G.node_cent = node_cent;
        dyn_data.G.G_t = G_t;
        dyn_data.G.traces = traces;
        
        
        % Save data
        if config.verbose
            fprintf(' - Saving data\n')
        end
        if ~exist(config.gen.savepath,'dir')
            mkdir(config.gen.savepath)
        end
        savedir = fullfile(config.gen.savepath,sprintf('W=%.3f',W));
        if ~exist(savedir,'dir')
            mkdir(savedir)
        end
        timestamp = 1e3*posixtime(datetime);
        thisname = sprintf('dyn_data_%.f.mat',timestamp);
        fname=fullfile(savedir,thisname);
        save(fname,'-struct','dyn_data','-v7.3');
end