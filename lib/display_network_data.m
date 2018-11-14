function display_network_data(in_net_data,display_opts)



    for N = 1:numel(in_net_data)
        
        net_data = in_net_data{N};
        
        if display_opts.local
            figure()
            colormap magma;
 
            cm_nrg = colormap(magma(1000));
            cm_nsm = colormap(plasma(1000));
            
            nz_evals = squeeze(net_data.lap_evals(:,:,1:end-1));
            
            subplot(5,3,1)
            for ns = 1:net_data.num_samples
                nrg_scale = round(rescale(net_data.energies(ns,:),1,1000));
                for nv = 1:net_data.num_eigs
                    p1=plot(1:net_data.L-1,squeeze(nz_evals(ns,nv,:))');    
                    p1.Color = cm_nrg(nrg_scale(nv),:);
                    hold on
                    title('Spectrum')
                end
            end
            
            subplot(5,3,2)
            for ns = 1:net_data.num_samples
                nrg_scale = round(rescale(net_data.energies(ns,:),1,1000));
                for nv = 1:net_data.num_eigs
                    p2=plot(1:net_data.L-1,log(squeeze(nz_evals(ns,nv,:)))');    
                    p2.Color = cm_nrg(nrg_scale(nv),:);
                    hold on
                    title('Log spectrum')
                end
            end
            
            %Spectral scaling 
            subplot(5,3,3)
            for ns = 1:net_data.num_samples
                nrg_scale = round(rescale(net_data.energies(ns,:),1,1000));
                for nv = 1:net_data.num_eigs
                    Y = squeeze(nz_evals(ns,nv,:));
                    p2=plot(1:net_data.L-1,rescale(Y)');    
                    p2.Color = cm_nrg(nrg_scale(nv),:);
                    hold on
                    title('Scaled spectrum')
                end
            end
            
            log_nz_evals = log(net_data.lap_evals(net_data.lap_evals>1.0e-15));
            log_nz_evals = log_nz_evals(log_nz_evals>-31);
            subplot(5,3,4)
            histogram(squeeze(log_nz_evals(:)))
            title('Spectral dist')
            hold on
            subplot(5,3,9)




            subplot(5,3,5)
            histogram(net_data.lap_evals(:),0:0.15:3)
            title('Spectral entropy dist')

            subplot(5,3,6)
            histogram(net_data.Qs(:),0:.05:1);
            title('Purity dist') 

            


            subplot(5,3,7)
            for ns = 1:net_data.num_samples
                nrg_scale = round(rescale(net_data.energies(ns,:),1,1000));
                p7=plot(net_data.energies(ns,:),log(abs(squeeze(net_data.determinants(ns,:)))),'.');    
                p7.Color = cm_nsm(nrg_scale(ns),:);
                hold on
                title('log(|L|)')
                xlabel('\epsilon')
            end
            

            subplot(5,3,8)
            det = squeeze(net_data.determinants(:));
            det = det(det>0);
            histogram(log(det),25);
            title('|L| dist') 
            
            subplot(5,3,9)
            % Fielder vectors
            for ns = 1:net_data.num_samples
                nrg_scale = round(rescale(net_data.energies(ns,:),1,1000));
                p9=plot(net_data.energies(ns,:),squeeze(net_data.stats.fielder_vals(ns,:)),'.');    
                p9.Color = cm_nsm(nrg_scale(ns),:);
                hold on
                title('Algebraic connectivity')
                xlabel('\epsilon')
            end
            
%             subplot(5,3,9)



            subplot(5,3,10)
            histogram(squeeze(net_data.degree_list(:)),20)
            title('Degree distribution')
            
            subplot(5,3,11)
            histogram((log(abs(squeeze(net_data.weight_list(:))))),'FaceAlpha',0.2);
            hold on
            title('Log weight dist')              

            subplot(5,3,12)
            histogram(log(net_data.weight_list(:)),50)
            set(gca,'Yscale','log')
            title('log weight dist')

            subplot(5,3,13)
            for ns = 1:net_data.num_samples
                nrg_scale = round(rescale(net_data.energies(ns,:),1,1000));
                p13=plot(net_data.energies(ns,:),squeeze(net_data.traces(ns,:)),'.');    
                p13.Color = cm_nsm(nrg_scale(ns),:);
                hold on
                title('Tr(|L|)')
                xlabel('\epsilon')
            end


            subplot(5,3,14)
            for ns = 1:net_data.num_samples
                nrg_scale = round(rescale(net_data.energies(ns,:),1,1000));
                p14=plot(net_data.energies(ns,:),log(squeeze(net_data.traces(ns,:))),'.');    
                p14.Color = cm_nsm(nrg_scale(ns),:);
                hold on
                title('log Tr(|L|)')
                xlabel('\epsilon')
            end

            subplot(5,3,15)
            histogram(log(squeeze(net_data.traces(:))),25);
            title('Trace dist') 

        
        suptitle(['W=',num2str(net_data.W)])
            
        end
        

        if display_opts.savefig
                savefig(['L',num2str(net_data.L),'W',num2str(net_data.W),'.fig'])
                saveas(gcf,['L',num2str(net_data.L),'W',num2str(net_data.W),'.png'])
        end
    end
    
    
    
    if display_opts.global
        figure();
        for N=1:numel(in_net_data)
%             colour = magma(0.85*N/numel(net_data));
            net_data = in_net_data{N}; 
            entropies = net_data.entropies;
            fielders = net_data.stats.fielder_vals;
            determinants = net_data.determinants;
            traces = net_data.traces;
            
            W = net_data.W;
%             Waxis = W*net_data.num_samples;
            for nv=1:net_data.num_eigs
%                 colour = magma(0.85*nv/net_data.num_eigs);
                
                entropies_loc = entropies(:,nv);
                subplot(3,2,1)
                plot(W,mean(entropies_loc),'.');
                hold on
                title('Spectral entropies')
                xlabel('W')


                fielders_loc = fielders(:,nv);
                subplot(3,2,2)
                plot(W,mean(fielders_loc),'.')
                hold on
                title('Algebraic connectivity')
                xlabel('W')
                
                determinants_loc = determinants(:,nv);
                subplot(3,2,3)
                plot(W,log(mean(determinants_loc)),'.')
                hold on
                title('|L|')
                xlabel('W')
                
                traces_loc = traces(:,nv);
                subplot(3,2,4)
                plot(W,mean(traces_loc),'.')
                hold on
                title('Tr(L)')
                xlabel('W')
                
                % Replace with violin or similar
%                 sc1=scatter(W*ones(size(net_data.stats.weights)),log(net_data.stats.weights),'.');
%                 hold on
%                 sc1.MarkerFaceAlpha = 0.2;
%                 sc1.MarkerFaceColor = colour;
                
                
            end

        end
    end

%     network_data.stats.entropy_VN = net_data.entropy_VN(:);
%     network_data.stats.determinants = squeeze(net_data.determinants(:));
%     network_data.stats.fielder_vals = log(squeeze(net_data.lap_evals(ns,:,end-1)));
%     network_data.stats.weights = net_data.degree_list(:);
%     network_data.stats.traces = net_data.traces(:);
    
    if display_opts.savefig
        savefig(['L',num2str(net_data.L),'W',num2str(net_data.W),'_summary.fig'])
        saveas(gcf,['L',num2str(net_data.L),'W',num2str(net_data.W),'_summary.png'])
    end


end