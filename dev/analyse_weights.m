function analyse_weights(viz_data,config)

Nmax = config.viz.Nmax;
W_list = config.viz.W_list;
cm = colormap(plasma(Nmax));

sfigure(config.viz.fid); 
set(gcf,'color','w');
clf;

subplot(2,2,1)
for N=1:Nmax
    plot(W_list(N),viz_data.entropy(N),'kx')
    hold on
end
xlim([min(W_list),max(W_list)])
title('Weight Distribution entropy')
xlabel('Disorder')
ylabel('Entropy')  

subplot(2,2,2)
for N = 1:Nmax
    plot(viz_data.log_hist_bins{N},viz_data.log_hist_counts{N},'-','Color',cm(N,:));
    hold on
end
xlabel('-log10(\omega)')
ylabel('P(x=X)')       
title('PDF of log(w)')


subplot(2,2,3)
for N = 1:Nmax
    plot(viz_data.hist_bins{N},viz_data.hist_counts{N},'-','Color',cm(N,:));
    hold on
end
set(gca,'Yscale','log')
xlabel('\omega')
ylabel('P(w=omega)')
title('Logscale PDF of w')

subplot(2,2,4)
for N = 1:Nmax
    plot(viz_data.log_hist_bins{N},viz_data.log_hist_counts{N},'-','Color',cm(N,:));
    hold on
end
set(gca,'Yscale','log')
xlabel('-log10(omega)')
ylabel('P(w=\omega)')
title('Logscale PDF of log(w)')










suptitle(config.viz.fig_title)



end