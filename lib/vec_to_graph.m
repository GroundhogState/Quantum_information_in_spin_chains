function graph_data = vec_to_graph(vs)

    graph_data.L_list = cell(size(vs,2),1);
    graph_data.G_list = cell(size(vs,2),1);
    for k=1:size(vs,2)
        v = vs(:,k)/norm(vs(:,k)); %just in case
        L = log2(numel(v));
        rho = v.*v';
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
               A_temp(ii,jj) =  abs(Entropy(TrX(rho,trace_pair,dims)));
%                fprintf('S_AB %f' ,A(ii,jj))
            end
        end
        A_temp = (A_temp + A_temp');
        for ii=1:L
            for jj=1:L
            A(ii,jj) = abs(ent_list(ii)) + abs(ent_list(jj)) - A_temp(ii,jj);  
            end
        end
        
        A = (A + A');
        A_hollow = A - diag(diag(A)); 
        D = diag(sum(A_hollow));
        graph_data.L_list{k} = D-A_hollow; %Corrected laplacian
        graph_data.G_list{k} = A; %Aleph
    end

%     graph_data.L_list = cell(size(vs,2),1);
%     graph_data.E_list = cell(size(vs,2),1);
%     for k=1:size(vs,2)
%         v = vs(:,k);
%         L = log2(numel(v));
%         rho = v.*v';
%         ent_list = zeros(L,1);
%         dims = 2*ones(1,L);
%         A = zeros(L);
%         pair_list = cell(L*(L-1)/2,1);
%         systems = 1:L;
%         for ii=1:L %sadly do need to loop over this twice - otherwise A is generated incorrectly. Would be great fun to come up with a more efficient method.
%             trace_sys = systems;
%             trace_sys(ii) = [];
%             ent_list(ii) = Entropy(TrX(rho, trace_sys,dims));
%         end
%         for ii=1:L
%             for jj = ii+1:L
%                trace_pair = systems;
%                trace_pair(ii) =[];
%                trace_pair(jj-1) = [];
%                subsys  = TrX(rho,trace_pair,dims);
%                pair_list{(ii-1)*L+jj} = subsys;
%                A(ii,jj) = abs(ent_list(ii) + ent_list(jj) - Entropy(subsys));
%             end
%         end
%         A = A + A';
%         D = diag(sum(A));
%         graph_data.L_list{k} = D-A;
%         graph_data.E_list{k} = ent_list;
%     end
end