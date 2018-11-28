function viz_data = distribution_viz(input,fig_title,config)
    
% Inputs: The entire set of values for a certain parameter (edge weights,
% eigenvalues, VN entropies, etc) indexed by disorder strength, scaled
% energy density, and disorder sample. 
% Outputs: viz_data, a cell array with histogram bin centres & populations for linear and log data for each disorder 
% Also provides graphical output. 

% User config
%   Scale - the maximum scale for the inputs, used to create hist bins
%   Cutoff - the minimum value to consider for data. Good for avoiding
%       numerical errors but also set a natural scale
%   Scaling - If enabled, data is rescaled to the unit interval 
%   log_scaling - similar

% SCALING
%   MI has a natural scale; it's bouned above (in spin chain) by 2.
%       In general, a scale parameter should be passed as input.    All data rescaled by this value so max(data) = 1   
%       Also input a cutoff scale. All data below this scale will be
%          truncated, and then the remaining data rescaled to live on the
%          unit interval.
%       


        W_list = config.gen.Ws;
        Nmax = numel(input);
        viz_data = cell(Nmax,1);
      
        cm = colormap(plasma(Nmax));
        
        for N = 1:Nmax
            dat_temp = (squeeze(input{N}(:))); %No more abs-ing - safety checks!
            viz_data{N}.dat = dat_temp;
            viz_data{N}.dat = viz_data{N}.dat(viz_data{N}.dat > config.viz.cutoff);
            if config.viz.scaling
                viz_data{N}.dat=(viz_data{N}.dat-config.viz.cutoff)/config.viz.scale;
                viz_data{N}.hist_win = linspace(0,1,config.viz.num_bins);
                viz_data{N}.hist_bins =0.5*(viz_data{N}.hist_win(2:end)+viz_data{N}.hist_win(1:end-1));
            else
                viz_data{N}.hist_win = linspace(config.viz.cutoff,config.viz.scale,config.viz.num_bins);
                viz_data{N}.hist_bins =0.5*(viz_data{N}.hist_win(2:end)+viz_data{N}.hist_win(1:end-1));
            end
            viz_data{N}.hist_counts = histcounts(viz_data{N}.dat,viz_data{N}.hist_win,'Normalization','pdf');

            viz_data{N}.log_dat =-log10(dat_temp);
            if config.viz.log_scaling
                viz_data{N}.log_dat = -(viz_data{N}.log_dat-log10(config.viz.scale))/log10(config.viz.cutoff);
                viz_data{N}.log_hist_win = linspace(0,1,config.viz.num_bins);
                viz_data{N}.log_hist_bins =0.5*(viz_data{N}.log_hist_win(2:end)+viz_data{N}.log_hist_win(1:end-1));
            else
                viz_data{N}.log_hist_win = linspace(-log10(config.viz.scale),-log10(config.viz.cutoff),config.viz.num_bins);
                viz_data{N}.log_hist_bins =0.5*(viz_data{N}.log_hist_win(2:end)+viz_data{N}.log_hist_win(1:end-1));
            end
            viz_data{N}.log_hist_counts = histcounts(viz_data{N}.log_dat,viz_data{N}.log_hist_win,'Normalization','pdf');

        end
        

        if config.viz.output
            subplot(2,3,1)
            for N = 1:Nmax
                plot(viz_data{N}.hist_bins,viz_data{N}.hist_counts,'-','Color',cm(N,:));
                hold on
            end
            xlabel('X')
            ylabel('P(x=X)')   
        
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

end
