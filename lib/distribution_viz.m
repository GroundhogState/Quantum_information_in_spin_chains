function viz_data = distribution_viz(input,fig_title,config)

        %Currently scaling ONLY APPLIED TO LOG DATA.

        W_list = config.gen.Ws;
        Nmax = numel(input);
        viz_data = cell(Nmax,1);
        data_mat = cell2mat(input);
        data_mat = data_mat(data_mat>1e-10);

%         figure()        
        cm = colormap(plasma(Nmax));
        
        for N = 1:Nmax
            viz_data{N}.dat =(abs(squeeze(input{N}(:))));
            viz_data{N}.dat = viz_data{N}.dat(viz_data{N}.dat > 1e-10);
            viz_data{N}.hist_win = linspace(min(viz_data{N}.dat),max(viz_data{N}.dat),config.viz.num_bins);
            viz_data{N}.hist_bins =0.5*(viz_data{N}.hist_win(2:end)+viz_data{N}.hist_win(1:end-1));
            viz_data{N}.hist_counts = histcounts(viz_data{N}.dat,viz_data{N}.hist_win,'Normalization','pdf');
            if config.viz.scaling
                dat_temp=viz_data{N}.dat/max(viz_data{N}.dat);
            else
                dat_temp = viz_data{N}.dat;
            end
            viz_data{N}.log_dat =-log10(dat_temp);
            if config.viz.log_scaling
                viz_data{N}.log_dat =rescale(viz_data{N}.log_dat);
            end
            viz_data{N}.log_hist_win = linspace(min(viz_data{N}.log_dat),max(viz_data{N}.log_dat),config.viz.num_bins);
%             viz_data{N}.log_hist_win = linspace(config.viz.log_hist_win(1),config.viz.log_hist_win(2),config.viz.num_bins);
            viz_data{N}.log_hist_bins =0.5*(viz_data{N}.log_hist_win(2:end)+viz_data{N}.log_hist_win(1:end-1));
            viz_data{N}.log_hist_counts = histcounts(viz_data{N}.log_dat,viz_data{N}.log_hist_win,'Normalization','pdf');
%             
%             if config.viz.scaling
%                 viz_data{N}.log_hist_bins =rescale(viz_data{N}.log_hist_bins);
%             end
    
            viz_data{N}.moments = [mean(viz_data{N}.dat),var(viz_data{N}.dat),skewness(viz_data{N}.dat),kurtosis(viz_data{N}.dat)];
            viz_data{N}.log_moments = [mean(viz_data{N}.log_dat),var(viz_data{N}.log_dat),skewness(viz_data{N}.log_dat),kurtosis(viz_data{N}.log_dat)];

            [~,peak_loc] = max(viz_data{N}.hist_counts);
            viz_data{N}.peak_val = viz_data{N}.hist_bins(peak_loc);
        end
        

        if config.viz.output
    %         subplot(2,4,1)
            subplot(2,3,1)
            for N = 1:Nmax
                plot(viz_data{N}.hist_bins,viz_data{N}.hist_counts,'-','Color',cm(N,:));
                hold on
            end
            xlabel('X')
            ylabel('P(x=X)')   
    %         
            subplot(2,3,4)
            for N = 1:Nmax
                [f, x]=ecdf(viz_data{N}.dat);
                plot(x,f,'-','Color',cm(N,:));
                hold on
            end
            xlabel('X')
            ylabel('CDF(x<X)')  

    %         subplot(2,4,2)
    %         for N = 1:Nmax
    %             plot(viz_data{N}.log_hist_bins,viz_data{N}.log_hist_counts,'-','Color',cm(N,:));
    %             hold on
    %         end
    %         xlabel('-log10(X)')
    %         ylabel('P(x=X)')       
    % 
    %         subplot(2,4,3)
    %         colormap(plasma(1000))
    %         all_spec = zeros(Nmax,config.viz.num_bins-1);
    %         for N = 1:Nmax
    %             all_spec(N,:)=viz_data{N}.hist_counts;
    %         end
    %         imagesc(W_list,[],(all_spec'));
    %         set(gca,'Ydir','normal');
    %         xlabel('Disorder')
    %         ylabel('value')
    % 
    %         subplot(2,4,4)
    %         means = cellfun(@(x) x.moments(1), viz_data);
    %         plot(W_list, means)
    %         
    %         
    %         
    %         
    %         
    %         subplot(2,4,5)
    %         for N = 1:Nmax
    %             plot(viz_data{N}.hist_bins,viz_data{N}.hist_counts,'-','Color',cm(N,:));
    %             hold on
    %         end
    %         set(gca,'Yscale','log')
    %         xlabel('X')
    %         ylabel('P(x=X)')
    %         
    %         subplot(2,4,6)
            subplot(2,3,2)
            for N = 1:Nmax
                plot(viz_data{N}.log_hist_bins,viz_data{N}.log_hist_counts,'-','Color',cm(N,:));
                hold on
            end
            set(gca,'Yscale','log')
            xlabel('-log10(X)')
            ylabel('P(x=X)')

            subplot(2,3,5)
            for N = 1:Nmax
                [f, x]=ecdf(viz_data{N}.log_dat);
                plot(x,f,'-','Color',cm(N,:));
                hold on
            end

            xlabel('-log X')
            ylabel('CDF(x<X)')  

    %         subplot(2,3,6)
    %         legend(arrayfun(@(x) ['W=',num2str(x)], (config.gen.Ws),'UniformOutput',false))


    %         
    % 
    %         
    %         subplot(2,4,7)
            subplot(2,3,3)
            colormap(plasma(1000))
            all_spec = zeros(Nmax,config.viz.num_bins-1);
            for N = 1:Nmax
                all_spec(N,:)=(viz_data{N}.log_hist_counts);
            end
            imagesc(W_list,[],all_spec')
            set(gca,'Ydir','normal');
            xlabel('Disorder')
            ylabel('-log value')




            suptitle(fig_title)

        end
        %% Fitting 

end
