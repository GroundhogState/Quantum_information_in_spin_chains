function plot_corrs(data,config)
    
    Nmax = numel(data);
    W_list = config.W_list;
    [~,rank] = sort(W_list);%,1,length(W_list));
    rank = arrayfun(@(x) find(rank==x), 1:length(rank));
%     Nmax = numel(config.W_list);
    cm = colormap(plasma(50));
%     sfigure(config_.fid); 
    sfigure(666);
    set(gcf,'color','w');
    clf;
    nsel = [1,3,4,5,6,7,9,10,2];
    for i=1:length(nsel)
        N = nsel(i);
        sc_dat = data{N};
        h3dat = [];
        for x=1:size(sc_dat,3)  
            h_add = sc_dat(:,1:2,x);
            f=h_add(:,1) > 1e-6;
            h_add = h_add(f,:);
            h3dat = [h3dat;h_add];
%             scatter(sc_dat(:,1,x),sc_dat(:,2,x),'x');
        end
        subplot(ceil(sqrt(length(nsel))),ceil(sqrt(length(nsel))),i)
        HC = hist3(h3dat,[200,200]);
        imagesc(HC);
        hold on
    end
end