function plot_hists(viz_data,config_viz,varargin)
% Varargin should be a series of strings specifying which plots to display
kwargs = config_viz.plots;
str_in = cellfun(@(x) ischar(x), kwargs);
kwargs = kwargs(str_in);
if numel(kwargs)==0
    warning('No plots requested')
else
    
    num_plots = numel(kwargs);
    num_rows = ceil(num_plots/2); % rounding up to even number

%     W_list = config_viz.W_list;
    W_list = viz_data.W_list;
    [~,idxs] = sort(W_list);%,1,length(W_list));
    rank = arrayfun(@(x) find(idxs==x), 1:length(idxs));
%     W_scaled = W_list(W_scaled);
    Nmax = numel(config_viz.W_list);
    cm = colormap(plasma(Nmax));
    sfigure(config_viz.fid); 
    set(gcf,'color','w');
    clf;
    counter = 1;
    if any(strcmp('linXlinY',kwargs))
        subplot(num_rows,2,counter)
        for N = 1:Nmax
            plot(viz_data.hist_bins{N},viz_data.hist_counts{N},'-','Color',cm(rank(N),:));
            hold on
        end
        hold off
        xlabel('\Lambda')
        ylabel('P(\lambda=\Lambda)')  
        title('PDF of \lambda')
        counter = counter + 1;
    end
    
    if any(strcmp('logXlinY',kwargs))
        subplot(num_rows,2,counter)
        for N = 1:Nmax
            p2 = plot(viz_data.log_hist_bins{N},viz_data.log_hist_counts{N},'-','Color',cm(rank(N),:));
        %     p2.Color(4) = 0.8;
            hold on
        end
        xlabel('-log10(\Lambda)')
        ylabel('P(\lambda=\Lambda)')     
        title('PDF of -log(\lambda)')
        counter = counter + 1;
    end

    if any(strcmp('linXlogY',kwargs))
        subplot(num_rows,2,counter)
        for N = 1:Nmax
            plot(viz_data.hist_bins{N},viz_data.hist_counts{N},'-','Color',cm(rank(N),:));
            hold on
        end
        set(gca,'Yscale','log')
        xlabel('\Lambda')
        ylabel('P(\lambda=\Lambda)')
        title('logscale PDF of \lambda')
        counter = counter + 1;
    end
    
    if any(strcmp('loglog',kwargs))
        subplot(num_rows,2,counter)
        for N = 1:Nmax
            loglog(viz_data.hist_bins{N},viz_data.hist_counts{N},'-','Color',cm(rank(N),:));
            hold on
        end
%         set(gca,'Yscale','log')
        xlabel('\Lambda')
        ylabel('P(\lambda=\Lambda)')
        title('loglog PDF')
        counter = counter + 1;
    end
       
     if any(strcmp('logEnt',kwargs))
        subplot(num_rows,2,counter)
        for N=1:Nmax
            pn=plot(W_list(N),viz_data.log_entropy(N),'x');
            pn.Color = cm(rank(N),:);
            hold on
        end
        xlim([min(W_list),max(W_list)])
        title('Entropy of log distribution')
        xlabel('Disorder')
        ylabel('Entropy')
        counter = counter + 1;
    end
    
    if any(strcmp('SJ_div',kwargs))
        subplot(num_rows,2,counter)
        for N=1:Nmax-1
            Ws=[W_list(idxs(N)),W_list(idxs(N+1))];
            pn=plot(mean(Ws),viz_data.SJ_increment(N+1),'x');
            pn.Color = cm(N,:);
            hold on
        end
        xlim([min(W_list),max(W_list)])
        title('Incremental Shannon-Jensen distance')
        xlabel('Avg Disorder')
        ylabel('SJ distance')
        counter = counter + 1;
    end
    
    if any(strcmp('logXlogY',kwargs))
        subplot(num_rows,2,counter)
        for N = 1:Nmax
            plot(viz_data.log_hist_bins{N},viz_data.log_hist_counts{N},'-','Color',cm(rank(N),:));
            hold on
        end
        set(gca,'Yscale','log')
        xlabel('-log10(\Lambda)')
        ylabel('P(\lambda=\Lambda)')
        title('logscale PDF of log(\lambda)')
        counter = counter + 1;
    end

    if any(strcmp('linEnt',kwargs))
        subplot(num_rows,2,counter)
        for N=1:Nmax
            pn=plot(W_list(N),viz_data.entropy(N),'x');
            pn.Color = cm(rank(N),:);
            hold on
        end
        xlim([min(W_list),max(W_list)])
        title('Distribution entropy')
        xlabel('Disorder')
        ylabel('Entropy')
        counter = counter + 1;
    end
    
    if any(strcmp('SJ_tot',kwargs))
        subplot(num_rows,2,counter)
        for N=1:Nmax
            pn=plot(W_list(N),viz_data.SJ_integrated(N),'x');
            pn.Color = cm(rank(N),:);
            hold on
        end
        xlim([min(W_list),max(W_list)])
        title('Cumulative Shannon-Jensen divergence')
        xlabel('Disorder')
        ylabel('SJ distance')
        counter = counter + 1;
    end
    
    suptitle(config_viz.fig_title);
end

    %TODO: Add spectrograms. Whatever other plots.

end

