function gen_data(gen_config)
if gen_config.profile
    profile on
end

for i=1:numel(gen_config.Ws)
    if gen_config.Ws(i) == 0
        n_samp = 1;
    else
        n_samp = gen_config.num_samples;
    end
    if gen_config.verbose
      fprintf('Disorder strength %.1f \n',gen_config.Ws(i))
    end
    

        data.samp= cell(n_samp,1);
        data.L = gen_config.L;
        data.W = gen_config.Ws(i);
        data.num_eigs = gen_config.num_vecs;

        for k=1:n_samp
            if gen_config.verbose
                fprintf('sample %u/%u\n',k,n_samp)
            end
        %% Build H
            [H, data_temp.h_list] = disorder_H(data.L,data.W); 
            [vecs, nrg] = eigs(full(H),2^data.L);
            data_temp.nrg = rescale(diag(nrg));
            %% Select vectors & build state graph Laplacian
            data_temp.sel = ceil(linspace(1,2^data.L,data.num_eigs));
            data_temp.v_sel = vecs(:,data_temp.sel);
            data_temp.graph_data = vec_to_graph(data_temp.v_sel);
            data.samp{k} = data_temp;
        end

        fname=[gen_config.savepath,'L-',num2str(data.L),...
            '-W',num2str(data.W),'-N',num2str(gen_config.num_vecs),'-PBC.mat'];
        save(fname,'-struct','data','-v7.3');
    end
    
if gen_config.profile
    profile off
    profile viewer
end

end