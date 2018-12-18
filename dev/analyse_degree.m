function analyse_weights(viz_data,config)

Nmax = config.viz.Nmax;
W_list = config.viz.W_list;
cm = colormap(plasma(Nmax));

sfigure(config.viz.fid); 
set(gcf,'color','w');
clf;

subplot(3,2,1)
for N = 1:Nmax
    plot(viz_data.hist_bins{N},viz_data.hist_counts{N},'-','Color',cm(N,:));
    hold on
end
hold off
xlabel('\delta')
ylabel('P(d=\delta)')  
title('PDF of node degrees')

subplot(3,2,2)
for N = 1:Nmax
    plot(viz_data.log_hist_bins{N},viz_data.log_hist_counts{N},'-','Color',cm(N,:));
    hold on
end
xlabel('-log10(\delta)')
ylabel('P(d=\delta)')     
title('PDF of -log(degree)')





subplot(3,2,3)
for N = 1:Nmax
    plot(viz_data.hist_bins{N},viz_data.hist_counts{N},'-','Color',cm(N,:));
    hold on
end
set(gca,'Yscale','log')
xlabel('\delta')
ylabel('P(d=\delta)')
title('logscale PDF of node degrees')

subplot(3,2,4)
for N = 1:Nmax
    plot(viz_data.log_hist_bins{N},viz_data.log_hist_counts{N},'-','Color',cm(N,:));
    hold on
end
set(gca,'Yscale','log')
xlabel('-log10(\delta)')
ylabel('P(d=\delta)')
title('logscale PDF of log(degrees)')

 
subplot(3,2,5)
for N=1:Nmax
    plot(W_list(N),viz_data.entropy(N),'kx')
    hold on
end
xlim([min(W_list),max(W_list)])
title('Distribution entropy')
xlabel('Disorder')
ylabel('Entropy')


subplot(3,2,6)
entropy = zeros(Nmax,1);
for N=1:Nmax
    plot(W_list(N),viz_data.log_entropy(N),'kx')
    hold on
end
xlim([min(W_list),max(W_list)])
title('Entropy of log distribution')
xlabel('Disorder')
ylabel('Entropy')

suptitle(config.viz.fig_title)



end