function data = save_samples(W,gen_config,verbose)
    data.samp= cell(gen_config.num_samples,1);
    data.L = gen_config.L;
    data.W = W;
    data.num_eigs = gen_config.num_vecs;
%     spmd 
    for k=1:gen_config.num_samples
        if gen_config.verbose
            fprintf('sample %u of %u',k,gen_config.num_samples)
        end
    %% Build H
        [H, data_temp.h_list] = disorder_H(data.L,data.W); 
        [vecs, nrg] = eigs(full(H),2^data.L);
        data_temp.nrg = diag(nrg);
        %% Select vectors & build state graph Laplacian
        data_temp.sel = ceil(linspace(1,2^data.L,data.num_eigs));
        data_temp.v_sel = vecs(:,data_temp.sel);
        data_temp.graph_data = vec_to_graph(data_temp.v_sel);
        data.samp{k} = data_temp;
    end

    fname=[savepath,'L-',num2str(data.L),...
        '-W',num2str(data.W),'-N',num2str(gen_config.num_vecs),'-PBC.mat'];
    save(fname,'-struct','data','-v7.3');
end