function single_W_plots(in_net_data,display_opts)
for N = 1:numel(in_net_data)
        
        net_data = in_net_data{N};
        

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
                    p2=plot(1:net_data.L-1,log10(squeeze(nz_evals(ns,nv,:)))');    
                    p2.Color = cm_nrg(nrg_scale(nv),:);
                    hold on
                    title('log10 spectrum')
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
            
            log10_nz_evals = log10(net_data.lap_evals(net_data.lap_evals>1.0e-15));
            log10_nz_evals = log10_nz_evals(log10_nz_evals>-31);
            subplot(5,3,4)
            histogram(squeeze(log10_nz_evals(:)))
            title('Spectral dist')
            hold on
            subplot(5,3,9)

            subplot(5,3,5)
            histogram(net_data.lap_evals(:),0:0.15:3)
            title('Spectral dist')

            subplot(5,3,6)
            histogram(net_data.Qs(:),0:.05:1);
            title('Purity dist') 
          
            subplot(5,3,7)
            for ns = 1:net_data.num_samples
                
                p7=plot(net_data.energies(ns,:),log10(abs(squeeze(net_data.determinants(ns,:)))),'.');  
                nrg_scale = round(rescale(net_data.energies(ns,:),1,1000));
                p7.Color = cm_nsm(nrg_scale(ns),:);
                hold on
                title('log10(|L|)')
                xlabel('\epsilon')
            end          

            subplot(5,3,8)
            det = squeeze(net_data.determinants(:));
            det = det(det>0);
            histogram(log10(det),25);
            title('|L| dist') 
            
            subplot(5,3,9)
            % Fielder vectors
            for ns = 1:net_data.num_samples
                nrg_scale = round(rescale(net_data.energies(ns,:),1,1000));
                norm_fielders = squeeze(net_data.lap_evals(ns,:,end-1))'./max(squeeze(net_data.lap_evals(ns,:,:)),[],2);
                p9=plot(net_data.energies(ns,:),log10(norm_fielders),'.');    
                p9.Color = cm_nsm(nrg_scale(ns),:);
                hold on
                title('Algebraic connectivity')
                xlabel('\epsilon')
            end

            subplot(5,3,10)
            histogram(squeeze(net_data.degree_list(:)),20)
            title('Degree distribution')
            
            subplot(5,3,11)
            histogram((log10(abs(squeeze(net_data.weight_list(:))))),'FaceAlpha',0.2);
            hold on
            title('log10 weight dist')              

            subplot(5,3,12)
            histogram(net_data.entropy_VN(:))
            title('Onsite entropy dist')         

            subplot(5,3,13)
            all_norm_fielders = squeeze(net_data.lap_evals(:,:,end-1))./squeeze(net_data.lap_evals(:,:,1));
            histogram(log10(all_norm_fielders(:)))
            title('1st connectivity dist')

            subplot(5,3,14)
            all_norm_2A = squeeze(net_data.lap_evals(:,:,end-round(net_data.L/2)))./squeeze(net_data.lap_evals(:,:,1));
            histogram(log10(all_norm_2A(:)))
            title([num2str(round(net_data.L/2)),'-connectivity dist'])

            subplot(5,3,15)
            histogram(log10(squeeze(net_data.traces(:))),25);
            title('Trace dist') 
        
        suptitle(['W=',num2str(net_data.W)])            

        
        if display_opts.savefig
                savefig(['L',num2str(net_data.L),'W',num2str(net_data.W),'.fig'])
                saveas(gcf,['L',num2str(net_data.L),'W',num2str(net_data.W),'.png'])
        end
    end

end