function corr_plot_data = corr_proc(data,config)

    num_Ws = numel(data);
    corr_plot_data = cell(num_Ws,1);
    for N = 1:num_Ws
        dat_temp = cell2mat(data{N});
%         dims = size(dat_temp);
%         dat_temp = reshape(dat_temp,[],2);
        corr_plot_data{N} = dat_temp;
    end
    

end