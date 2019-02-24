function import_data = import_dyn_data(config)
    datapath = config.imp.savepath;
    subdirs = dir(fullfile(datapath,'W=*'));
    num_dirs = numel(subdirs);
    import_data.W = zeros(num_dirs,1);
    import_data.net_data = cell(num_dirs,1);
    for dir_idx = 1:num_dirs
        subdir = subdirs(dir_idx).name;
        files = dir(fullfile(datapath,subdir,'*.mat'));
        if ~isnan(config.imp.num_files)
            num_files = config.imp.num_files;
        else
            num_files = size(files,1);
        end
        dir_data = cell(numel(subdir,1));    
        fprintf('\n Importing %6.f files from dir %u/%u:\n000000',num_files,dir_idx,num_dirs)
        for N=1:num_files
            if mod(N,100) ==0
                fprintf('\b\b\b\b\b\b%06.f',N)
            end
            fname = files(N).name;
            fname = fullfile(datapath,subdir,fname);
            data = load(fname);
            dir_data{N} = get_dyn_data(data,config);
        end % loop over files
        import_data.W(dir_idx) = dir_data{N}.P.W;
        import_data.net_data{dir_idx} = dir_data; 
    end % loop over dirs

end

function dyn_data = get_dyn_data(data,config)
% Fields to add; L, num_times

        dyn_data.P.h_list = data.P.h_list;
        dyn_data.P.W = data.P.W;
        dyn_data.P.init = data.P.init;
        dyn_data.P.bc = data.P.bc;
        
        dyn_data.G.node_cent = data.G.node_cent;
        dyn_data.G.G_t = zeros(size(data.G.G_t));
        dyn_data.G.traces = zeros(size(data.G.traces));
        dyn_data.G.VNE = zeros(size(data.G.node_cent));
        dyn_data.G.degree = zeros(size(data.G.node_cent));
        dyn_data.G.L_evals = zeros(size(data.G.node_cent));
        dyn_data.G.exp_A = zeros(size(data.G.G_t));
        dyn_data.G.ent_deg_pair = zeros(length(data.G.G_t),length(data.P.h_list),2);
        dyn_data.G.ent_cent = zeros(length(data.G.G_t),length(data.P.h_list),2);
        for ii=config.imp.starting_timestep:length(dyn_data.G.G_t)
            d_temp = squeeze(data.G.G_t(ii,:,:));
            diag_temp = diag(d_temp);
            dyn_data.G.VNE(ii,:) = diag_temp;
            dyn_data.G.degree(ii,:) = sum(d_temp + d_temp' - 2*diag(diag_temp));
            G_t=d_temp - diag(diag_temp);
            dyn_data.G.G_t(ii,:,:) = G_t;
            dyn_data.G.traces(ii) = sum(diag_temp);
            A = (G_t + G_t');
            Laplacian =   diag(sum(A)) - A;
%             dyn_data.G.L_evals(ii,:) = eigs(Laplacian,length(Laplacian));
%             dyn_data.G.exp_A(ii,:,:) = expm(A);
            dyn_data.X.ent_deg_pair(ii,:,:) = [diag(d_temp)';sum(A)];
            dyn_data.X.ent_cent(ii,:,:) = [diag(d_temp)';data.G.node_cent(ii,:)];
        end

%         G_t = zeros(size(data.G.G_t));
%         traces = zeros(size(data.G.traces));
%         VNE = zeros(size(data.G.node_cent));
%         degree = zeros(size(data.G.node_cent));
%         L_evals = zeros(size(data.G.node_cent));
% %       
% 
%         parfor ii=1:length(G_t)
%             d_temp = squeeze(data.G.G_t(ii,:,:));
%             diag_temp = diag(d_temp);
%             VNE(ii,:) = diag_temp;
%             degree(ii,:) = sum(d_temp + d_temp' - 2*diag(diag_temp));
%             G_t_temp=d_temp - diag(diag_temp);
%             G_t(ii,:,:) = G_t_temp;
%             traces(ii) = sum(diag_temp);
%             Laplacian =  G_t_temp + G_t_temp' - diag(sum(G_t_temp));
%             L_evals(ii,:) = eigs(Laplacian,length(Laplacian));
%         end        
% 
%         dyn_data.G.node_cent = data.G.node_cent;
%         dyn_data.G.VNE = VNE;
%         dyn_data.G.degree = degree;
%         dyn_data.G.G_t = G_t;
%         dyn_data.G.traces = traces;
%         dyn_data.G.L_evals = L_evals;



end