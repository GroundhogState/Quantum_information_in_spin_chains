function entropy_viz(in_net_data,W_list,config)

            
            Nmax = numel(in_net_data);
            %% Sitewise Von Neumann Entropy
            sfigure(config.viz.fid);
            cm = colormap(plasma(Nmax));
            subplot(2,2,1)
            hist_win = linspace(-0.1,1.1,100);
            for N = 1:numel(in_net_data)
                data = squeeze(in_net_data{N}.P.entropy_VN(:));
                H = histcounts((abs(data)),hist_win,'Normalization','pdf');
                plot(0.5*(hist_win(2:end)+hist_win(1:end-1)),H,'Color',cm(N,:))
                hold on
            end
            xlabel('von Neumann entropy S')
            ylabel('P(S_i) = S')

            
            subplot(2,2,2)
            hist_win = linspace(-0.1,1.1,100);
            for N = 1:numel(in_net_data)
                data = squeeze(in_net_data{N}.P.entropy_VN(:));
                H = histcounts((abs(data)),hist_win,'Normalization','pdf');
                H = H(H>0)*mean(diff(hist_win));
                S = -sum(H.*log10(H));
                plot(W_list(N),S,'o','Color',cm(N,:))
                hold on
            end
            xlabel('Disorder')
            ylabel('Entropy of VN distribution')
            
            subplot(2,2,3)
            hist_win = linspace(-0.1,1.1,100);
            for N = 1:numel(in_net_data)
                data = squeeze(in_net_data{N}.P.entropy_VN(:));
                H = histcounts((abs(data)),hist_win,'Normalization','pdf');
                plot(0.5*(hist_win(2:end)+hist_win(1:end-1)),H,'Color',cm(N,:))
                hold on
            end
            set(gca,'Yscale','log')
            xlabel('von Neumann entropy S')
            ylabel('P(S_i) = S')
            title('Local entropy') 
            
            subplot(2,2,4)
            hist_win = linspace(-0.1,1.1,100);
            all_entropy = zeros(numel(in_net_data),length(hist_win)-1);
            for N = 1:numel(in_net_data)
                data = squeeze(in_net_data{N}.P.entropy_VN(:));
                all_entropy(N,:) = histcounts((abs(data)),hist_win,'Normalization','pdf');
            end
            imagesc(W_list,hist_win,log10(all_entropy+1)')
            title('Local entropy')
    
            suptitle('Single-site VN distribution')
    
end