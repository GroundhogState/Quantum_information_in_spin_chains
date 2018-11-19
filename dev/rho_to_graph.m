function graph_data = rho_to_graph(rho_cell)
%% OOP 
%     graph_data.L_list = cell(size(vs,2),1);
    graph_data.A_list = cell(numel(rho_cell),1);
    for k=1:numel(rho_cell)
        rho = rho_cell{k};
        L = log2(length(rho));
        ent_list = zeros(L,1);
        dims = 2*ones(1,L);
        A = zeros(L);
        A_temp = zeros(L);
        systems = 1:L;
        for ii=1:L %sadly do need to loop over this twice - otherwise A is generated incorrectly. Would be great fun to come up with a more efficient method.
            trace_sys = systems;
            trace_sys(ii) = [];
            red_ii = TrX(rho, trace_sys,dims);
            Entropy(red_ii);
            ent_list(ii) = Entropy(TrX(rho, trace_sys,dims));
        end
        for ii=1:L
            for jj = ii+1:L
               trace_pair = systems;
               trace_pair(ii) =[];
               trace_pair(jj-1) = [];
               A_temp(ii,jj) =  Entropy(TrX(rho,trace_pair,dims));
%                fprintf('S_AB %f' ,A(ii,jj))
            end
        end
        A_temp = abs(A_temp + A_temp');
        for ii=1:L
            for jj=1:L
            A(ii,jj) = abs(ent_list(ii)) + abs(ent_list(jj)) - A_temp(ii,jj);  
            end
        end
        

        graph_data.A_list{k} = A; %Aleph - has 2*on-site entropy on diagonal. Can recover G (zero diag) easy)
    end


end