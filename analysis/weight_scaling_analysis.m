%% Importing data
% close all
% % Import things
% config.gen.savepath = '/home/jacob/Projects/ent_loc/dat/'; % office machine
% config.gen.num_samples = 8;
% config.gen.num_vecs = 10;
% config.gen.L = 12;% comment 
% config.gen.verbose = true;
% config.gen.profile = true;
% config.gen.Ws = linspace(1,7,10);
% config.viz.num_bins = 30;
% clear net_data;
% net_data = cell(numel(config.gen.Ws,1));
% for N=1:numel(config.gen.Ws)
%     fname = [config.gen.savepath,'L-',num2str(config.gen.L),'-W',num2str(config.gen.Ws(N)),...
%         '-N',num2str(config.gen.num_vecs),'-PBC.mat'];
%     data = load(fname);
%     net_data{N} = get_network_data(data);
%     clear data
% end

%% First item: Weight distribution

weight_dist = cellfun(@(x) x.weight_list, net_data,'UniformOutput',false);
config.viz.output = false;
config.viz.scaling = true;
config.viz.log_scaling = true;
config.viz.log_hist_win = [-0.5,10];
weight_viz = distribution_viz(weight_dist,'weight distribution',config);


Nmax = numel(net_data);
cm = colormap(plasma(Nmax));

beta_func = @(b,x) ((x.^(b(1)-1)).*(1-x).^(b(2)-1))/(gamma(b(1))*gamma(b(2))/gamma(b(1)+b(2)));
betafits = cell(Nmax,1);
wdist = @(p,x) (p(1)/p(2)) * (x/p(2)).^(p(1)-1) .* exp(-(x/p(2)).^p(1));
weibfits = cell(Nmax,1);
u_weibfits = cell(Nmax,1);

% X = linspace(0,1,250);

%% Plot & fit
% figure()

suptitle('Scaled weight distribution fits')

subplot(4,3,1)
for N=1:Nmax
    plot(weight_viz{N}.log_hist_bins,weight_viz{N}.log_hist_counts,'-','Color',cm(N,:));
    hold on
    xlabel('-log10(X)')
    ylabel('P(x=X)')
  
    IC = [2,4.5];
%     betafits{N} = fitnlm(weight_viz{N}.log_hist_bins,weight_viz{N}.log_hist_counts,beta_func,IC);
    plot(weight_viz{N}.log_hist_bins,weight_viz{N}.log_hist_counts,'-','Color',cm(N,:));
    hold on
%     plot(X,(betafun(betafits{N}.Coefficients.Estimate,X)));
end
hold off
title('Beta fits')

subplot(4,3,4)
for N=1:Nmax
[f,x] = ecdf(weight_viz{N}.log_dat);
plot(x,f)
hold on
g=cdf('beta',x,alphas(N),betas(N));
plot(x,g)
end
hold off
title('CDF & Beta CDF')
xlabel('-log10(X)')

subplot(4,3,7)
KS_beta_list = zeros(size(config.gen.Ws));
for N=1:Nmax
[f,x] = ecdf(weight_viz{N}.log_dat);
% plot(x,f)
g=cdf('beta',x,alphas(N),betas(N));
plot(x,f-g)
KS_beta_list(N) = trapz(x,abs(f-g));
hold on
end
hold off
title('CDF errors')
xlabel('-log10(X)')

% subplot(4,3,7)
% alphas = cellfun(@(x) x.Coefficients.Estimate(1), betafits);
% betas = cellfun(@(x) x.Coefficients.Estimate(2), betafits);
% plot(config.gen.Ws,alphas./alphas(1));
% hold on
% plot(config.gen.Ws,betas./betas(1));
% title('Fit parameters')
% legend('\alpha','\beta')
% xlabel('Disorder strength')

% % Weibull - unscaled



config.viz.log_hist_win = [-0.5,10];
weight_viz_unscaled = distribution_viz(weight_dist,'weight distribution',config);

X = linspace(0,1,100);
subplot(4,3,2)
for N=1:Nmax
    plot(weight_viz_unscaled{N}.log_hist_bins,weight_viz_unscaled{N}.log_hist_counts,'-','Color',cm(N,:));
    hold on
    xlabel('-log10(X)')
    ylabel('P(x=X)')
    IC = [2.5,3];

    weibfits{N} = fitnlm(weight_viz_unscaled{N}.log_hist_bins,weight_viz_unscaled{N}.log_hist_counts,wdist,IC);
    plot(weight_viz{N}.log_hist_bins,weight_viz{N}.log_hist_counts,'-','Color',cm(N,:));
    plot(X,(wdist(weibfits{N}.Coefficients.Estimate,X)));
    plot(X,(wdist(weibfits{N}.Coefficients.Estimate,X)));
    hold on

end
ks = cellfun(@(x) x.Coefficients.Estimate(1), weibfits);
ls = cellfun(@(x) x.Coefficients.Estimate(2), weibfits);

hold off
title('Weibull fits')
xlabel('-log10(X)')

subplot(4,3,5)
for N=1:Nmax
[f,x] = ecdf(weight_viz{N}.log_dat);
plot(x,f)
hold on
g = cdf('wbl',X,ls(N),ks(N));
plot(X,g)
end
hold off
title('CDF & Weibull CDF')
xlabel('-log10(X)')

KS_wb_list = zeros(size(config.gen.Ws));
subplot(4,3,8)
for N=1:Nmax
[f,x] = ecdf(weight_viz{N}.log_dat);
% plot(x,f)
g = cdf('wbl',x,ls(N),ks(N));
plot(x,f-g)
KS_wb_list(N) = trapz(x,abs(f-g));
hold on
end
hold off
title('CDF errors')
xlabel('-log10(X)')




% subplot(4,3,8)
% ks = cellfun(@(x) x.Coefficients.Estimate(1), weibfits);
% ls = cellfun(@(x) x.Coefficients.Estimate(2), weibfits);
% plot(config.gen.Ws,ks);
% hold on
% plot(config.gen.Ws,ls);
% hold off
% title('Fit parameters')
% legend('k','\lambda')
% xlabel('Disorder strength')

%Decision: Use the Weibull. It's a PDF of infinite support so the scaling
%isn't required. It has the same CDF error as the Beta - and the parameter
%scaling seems a bit smoother.
% But really, the test might be how well they collapse. Lets' have a go.

% figure()
config.viz.log_scaling = false;
config.viz.log_hist_win = [-0.5,10];
weight_viz_unscaled = distribution_viz(weight_dist,'weight distribution',config);

X = linspace(0,10,100);
subplot(4,3,3)
for N=1:Nmax
    plot(weight_viz_unscaled{N}.log_hist_bins,weight_viz_unscaled{N}.log_hist_counts,'-','Color',cm(N,:));
    hold on
    xlabel('-log10(X)')
    ylabel('P(x=X)')
    IC = [2.5,3];

    u_weibfits{N} = fitnlm(weight_viz_unscaled{N}.log_hist_bins,weight_viz_unscaled{N}.log_hist_counts,wdist,IC);
%     plot(weight_viz{N}.log_hist_bins,weight_viz{N}.log_hist_counts,'-','Color',cm(N,:));
    plot(X,(wdist(u_weibfits{N}.Coefficients.Estimate,X)));
    hold on

end
ks = cellfun(@(x) x.Coefficients.Estimate(1), u_weibfits);
ls = cellfun(@(x) x.Coefficients.Estimate(2), u_weibfits);

hold off
title('Weibull fits, unscaled data')
xlabel('-log10(X)')

subplot(4,3,6)
for N=1:Nmax
[f,x] = ecdf(weight_viz_unscaled{N}.log_dat);
plot(x,f)
hold on
g = cdf('wbl',X,ls(N),ks(N));
plot(X,g)
end
hold off
title('CDF ')
xlabel('-log10(X)')

subplot(4,3,9)
KS_us_list = zeros(size(config.gen.Ws));
for N=1:Nmax
[f,x] = ecdf(weight_viz_unscaled{N}.log_dat);
% plot(x,f)
g = cdf('wbl',x,ls(N),ks(N));
plot(x,f-g)
KS_us_list(N) = trapz(x,abs(f-g));
hold on
end
hold off
title('CDF errors')
xlabel('-log10(X)')

subplot(4,3,12)

plot(KS_beta_list,'x')
hold on
plot(KS_wb_list,'x')
plot(KS_us_list,'x')
legend('beta','weibull scaled','weibull unscaled')
set(gca,'Yscale','log')
title('KS statistics')


% Ok, it's not clear. Form of the Weibull is kind of nicer. Beta fits
% MARGINALLY better. But more data may decide...
% Desirable: Some analytic scaling relation. 
% I.E a scaling between from fit(W) to fit(W') that scales the parameters
% as some power of W/W'... & a curve collapse. Is this even guaranteed to
% be possible?