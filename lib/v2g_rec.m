function graph_data = v2g_rec(vs,config)

    graph_data = cell(size(vs,2),1);
    kmax = size(vs,2);
    if config.gen.verbose > 2
        fprintf(' - Producing graph for vector 000/%3.f', kmax)
    end
    for k=1:kmax
        if config.gen.verbose > 2
            fprintf('\b\b\b\b\b\b\b\b %3.f/%3.f',k,kmax)
        end
        
        v = vs(:,k)/norm(vs(:,k)); %just in case
        L = log2(numel(v));
        rho = v.*v';
     

        graph_data{k} = rho_to_graph(rho); %Aleph - has 2*on-site entropy on diagonal. Can recover G (zero diag) & L easy
    end
    fprintf('\n')

end