function graph_data = vec_to_graph(vs)
    graph_data.L_list = cell(size(vs,2),1);
    graph_data.E_list = cell(size(vs,2),1);
    for k=1:size(vs,2)
        v = vs(:,k);
        L = log2(numel(v));
        rho = v.*v';
        ent_list = zeros(L,1);
        dims = 2*ones(1,L);
        A = zeros(L);
        pair_list = cell(L*(L-1)/2,1);
        systems = 1:L;
        for ii=1:L
            trace_sys = systems;
            trace_sys(ii) = [];
            ent_list(ii) = Entropy(TrX(rho, trace_sys,dims));
            for jj = ii+1:L
               trace_pair = systems;
               trace_pair(ii) =[];
               trace_pair(jj-1) = [];
               subsys  = TrX(rho,trace_pair,dims);
               pair_list{(ii-1)*L+jj} = subsys;
               A(ii,jj) = abs(ent_list(ii) + ent_list(jj) - Entropy(subsys));
            end
        end
        A = A + A';
        D = diag(sum(A));
        graph_data.L_list{k} = D-A;
        graph_data.E_list{k} = ent_list;
    end
end