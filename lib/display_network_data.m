function display_network_data(in_net_data,config)

    if config.viz.local
        single_W_plots(in_net_data)
    end
    
    
    
     if config.viz.global
        W_list = cellfun(@(x) x.prm.W, in_net_data);
        Nmax = numel(in_net_data);
        
        config.viz.logent = false;
        lap_evals = cellfun(@(x) x.L.evals, in_net_data,'UniformOutput',false);
        config.viz.scaling = false;
        config.viz.log_scaling = false;
        config.viz.num_bins = 25;
        config.viz.cutoff = 1e-5;
        config.viz.scale = 0.2;
        config.viz.fid=1;
        distribution_viz(lap_evals,'Laplacian spectrum',config);
        
        config.viz.fid=2;
        fielder_vals = cellfun(@(x) x.L.evals(:,:,10), in_net_data,'UniformOutput',false);
        distribution_viz(fielder_vals,'Fielder eigenvalues',config);
%            
        config.viz.log_scaling = false;
        config.viz.scaling = false;
        config.viz.num_bins = 20;
        config.viz.cutoff = 1e-10;
        config.viz.scale = 3;
        config.viz.log_cutoff = 1e-8;
        config.viz.log_scale = 0.3;
        config.viz.fid=3;
        degree_dist = cellfun(@(x) x.G.degree_list, in_net_data,'UniformOutput',false);
        distribution_viz(degree_dist,'Degree distribution',config);
%         
         weight_dist = cellfun(@(x) x.G.weight_list, in_net_data,'UniformOutput',false);
         config.viz.scaling = false;
        config.viz.log_scaling = false;
        config.viz.num_bins = 20;
        config.viz.cutoff = 1e-10;
        config.viz.scale = 3;
        config.viz.log_cutoff = 1e-8;
        config.viz.log_scale = 0.3;
        config.viz.fid=4;
        distribution_viz(weight_dist,'Weight distribution',config);

        % VN gets special treatment
        config.viz.fid=5;
        entropy_viz(in_net_data,W_list,config);
%             
        config.viz.fid=6;
        aleph_spec = cellfun(@(x) x.A.evals, in_net_data,'UniformOutput',false);
        distribution_viz(aleph_spec,'A spectrum',config)  ;
        
        config.viz.fid=7;
        aleph_trc = cellfun(@(x) x.A.trace, in_net_data,'UniformOutput',false);
        distribution_viz(aleph_trc,'A trace',config); 
        
     
        config.viz.fid=8;
        config.viz.logent = true;
        aleph_det = cellfun(@(x) prod(x.A.evals,3), in_net_data,'UniformOutput',false);
        distribution_viz(aleph_det,'A det',config); 
        
        config.viz.fid=9;
        cent = cellfun(@(x) x.G.node_centrality, in_net_data,'UniformOutput',false);
        distribution_viz(cent,'Centrality',config); 
        
        config.viz.fid=10;
        config.viz.scaling = true;
        config.viz.log_scaling = true;
        config.viz.num_bins = 20;
        config.viz.cutoff = 1e-10;
        config.viz.scale = 24;
        config.viz.log_cutoff = 1e-8;
        config.viz.log_scale = 20;
        TMI = cellfun(@(x) x.P.TMI, in_net_data,'UniformOutput',false);
        distribution_viz(TMI,'TMI',config); 
        
    end  





end