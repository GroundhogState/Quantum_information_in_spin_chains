function display_network_data(in_net_data,config)

    if config.viz.local
        single_W_plots(in_net_data)
    end
    
    
    
     if config.viz.global
        W_list = cellfun(@(x) x.prm.W, in_net_data);
        Nmax = numel(in_net_data);
        
        lap_evals = cellfun(@(x) x.L.evals, in_net_data,'UniformOutput',false);
        distribution_viz(lap_evals,'Laplacian spectrum',config);
        
        fielder_vals = cellfun(@(x) x.L.evals(:,:,end-1), in_net_data,'UniformOutput',false);
        distribution_viz(fielder_vals,'Fielder eigenvalues',config);
           
        
        degree_dist = cellfun(@(x) x.G.degree_list, in_net_data,'UniformOutput',false);
        distribution_viz(degree_dist,'Degree distribution',config);
        
        weight_dist = cellfun(@(x) x.G.weight_list, in_net_data,'UniformOutput',false);
        distribution_viz(weight_dist,'Weight distribution',config);

        % VN gets special treatment
        entropy_viz(in_net_data,W_list);
            
     
        aleph_spec = cellfun(@(x) x.A.evals, in_net_data,'UniformOutput',false);
        distribution_viz(aleph_spec,'A spectrum',config)  ;
        
     
    end  





end