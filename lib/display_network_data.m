function display_network_data(in_net_data,config)

    if config.viz.local
        single_W_plots(in_net_data)
    end
    
    
    
     if config.viz.global
        W_list = cellfun(@(x) x.W, in_net_data);
        Nmax = numel(in_net_data);
        
        lap_evals = cellfun(@(x) x.lap_evals, in_net_data,'UniformOutput',false);
        distribution_viz(lap_evals,'Laplacian spectrum',config);
        
        fielder_vals = cellfun(@(x) x.lap_evals(:,:,end-1), in_net_data,'UniformOutput',false);
        distribution_viz(fielder_vals,'Fielder eigenvalues',config);
            
        total_immersion = cellfun(@(x) x.traces, in_net_data,'UniformOutput',false);
        distribution_viz(total_immersion,'Total mutual information',config);
        
        degree_dist = cellfun(@(x) x.degree_list, in_net_data,'UniformOutput',false);
        distribution_viz(degree_dist,'Degree distribution',config);
        
        weight_dist = cellfun(@(x) x.degree_list, in_net_data,'UniformOutput',false);
        distribution_viz(weight_dist,'Weight distribution',config);
            
        lap_ent = cellfun(@(x) x.entropies, in_net_data,'UniformOutput',false);
        distribution_viz(lap_ent,'L spec entropy distribution',config);

        % VN gets special treatment
        entropy_viz(in_net_data,W_list);
        
        lap_spec_scale = cellfun(@(x) x.lap_evals(:,:,1:end-1)./x.lap_evals(:,:,1), in_net_data,'UniformOutput',false);
        distribution_viz(lap_spec_scale,'Scaled L spectrum',config) ;       
     
        aleph_spec = cellfun(@(x) x.A.eigs, in_net_data,'UniformOutput',false);
        distribution_viz(aleph_spec,'A spectrum',config)  ;
        
     
    end  





end