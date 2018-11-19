function gen_data(config)
if config.gen.profile
    profile on
end

for i=1:numel(config.gen.Ws)
    if config.gen.Ws(i) == 0
        n_samp = 1;
    else
        n_samp = config.gen.num_samples;
    end
    if config.gen.verbose
      fprintf('Disorder strength %.1f \n',config.gen.Ws(i))
    end
    

        data.samp= cell(n_samp,1);
        data.L = config.gen.L;
        data.W = config.gen.Ws(i);
        data.num_eigs = config.gen.num_vecs;

        for k=1:n_samp
            if config.gen.verbose
                fprintf('sample %u/%u\n',k,n_samp)
            end
        %% Build H
            [H, data_temp.h_list] = disorder_H(data.L,data.W); 
            [vecs, nrg] = eigs(full(H),2^data.L);
            data_temp.nrg = rescale(diag(nrg));
            %% Select vectors & build state graph Laplacian
%             c = (2^data.L)/2-data.num_eigs:(2^data.L)/2+data.num_eigs
            data_temp.sel = (2^data.L)/2-data.num_eigs:(2^data.L)/2+data.num_eigs; 
            % Now sampling from middle of spectrum
            data_temp.v_sel = vecs(:,data_temp.sel);
            data_temp.graph_data = vec_to_graph(data_temp.v_sel);
            data.samp{k} = data_temp;
        end

        fname=[config.gen.savepath,'L-',num2str(data.L),...
            '-W',num2str(data.W),'-N',num2str(config.gen.num_vecs),'-PBC.mat'];
        save(fname,'-struct','data','-v7.3');
    end
    
if config.gen.profile
    profile off
    profile viewer
end

end