function show_L_trends(loop_data,config)
%     config.fieldnames = cellfun(@(x) x.viz.fields, loop_data{1}.conf.G,'UniformOutput',false);
%     config.fid = 9381;
%     plot_L_var(loop_data,config)
    
    config.fieldnames = cellfun(@(x) x.viz.fields, loop_data{1}.conf.A,'UniformOutput',false);
    config.fid = 9301;
    plot_L_var(loop_data,config)
    
%     config.fieldnames = cellfun(@(x) x.viz.fields, loop_data{1}.conf.P,'UniformOutput',false);
%     config.fid = 9321;
%     plot_L_var(loop_data,config)
%     
%     config.fieldnames = cellfun(@(x) x.viz.fields, loop_data{1}.conf.L,'UniformOutput',false);
%     config.fid = 9335;
%     plot_L_var(loop_data,config)

end

function plot_L_var(loop_data,config)
    for field_idx=1:length(config.fieldnames)
            fntemp = config.fieldnames{field_idx};

            SJ_var_curves = cellfun(@(x) x.data.A{field_idx}.SJ_integrated, loop_data,'UniformOutput',false);
            Ent_var_curves = cellfun(@(x) x.data.A{field_idx}.entropy, loop_data,'UniformOutput',false);
            num_Ls = length(SJ_var_curves);
            cm = colormap(plasma(num_Ls));    

            sfigure(config.fid+field_idx);
            clf;

            for N = 1:num_Ls
            xvals = loop_data{N}.conf.A{field_idx}.viz.W_list; 
            [~,xidx] = sort(xvals);
            subplot(1,2,1)
            plot(xvals(xidx),SJ_var_curves{N}(xidx),'x-','Color',cm(N,:))
            hold on
            title('Total Shannon-Jensen distance')
            xlabel('Disorder')
            ylabel('Total SJ distance')
            subplot(1,2,2);
            plot(xvals(xidx),Ent_var_curves{N}(xidx),'x-','Color',cm(N,:))
            hold on
            end
            title('Distribution entropy')
            xlabel('Disorder')
            ylabel('Entropy')

            suptitle(sprintf(fntemp{2}))    
    end
end

