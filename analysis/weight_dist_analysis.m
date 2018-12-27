function weight_viz = weight_dist_analysis(net_data,config)

weight_dist = cellfun(@(x) x.G.weight_list, net_data,'UniformOutput',false);
config.viz.output = true;
config.viz.scaling = true;
config.viz.scale = 1;
config.viz.log_scaling = true;
config.viz.log_hist_win = [-0.5,10];


weight_viz = distribution_viz(weight_dist,'weight distribution',config);

Nmax = numel(net_data);
cm = colormap(plasma(Nmax));

beta_func = @(b,x) ((x.^(b(1)-1)).*(1-x).^(b(2)-1))/(gamma(b(1))*gamma(b(2))/gamma(b(1)+b(2)));
betafits = cell(Nmax,1);


%% Plot & fit
sfigure(12);
suptitle('Weight distribution')
subplot(3,2,1)
for N=1:Nmax
    plot(weight_viz{N}.log_hist_bins,weight_viz{N}.log_hist_counts,'-','Color',cm(N,:));
    hold on
    xlabel('-log10(X)')
    ylabel('P(x=X)')
  
    IC = [2,4.5];
    betafits{N} = fitnlm(weight_viz{N}.log_hist_bins,weight_viz{N}.log_hist_counts,beta_func,IC);
    plot(weight_viz{N}.log_hist_bins,weight_viz{N}.log_hist_counts,'-','Color',cm(N,:));
    hold on
end
hold off
title('PDFs')

alphas = cellfun(@(x) x.Coefficients.Estimate(1), betafits);
betas = cellfun(@(x) x.Coefficients.Estimate(2), betafits);


subplot(3,2,2)
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

subplot(3,2,3)
KS_beta_list = zeros(size(config.gen.Ws));
for N=1:Nmax
[f,x] = ecdf(weight_viz{N}.log_dat);
g=cdf('beta',x,alphas(N),betas(N));
plot(x,f-g)
KS_beta_list(N) = trapz(x,abs(f-g));
hold on
end
hold off
title('CDF errors')
xlabel('-log10(X)')

subplot(3,2,4)
plot(config.gen.Ws,alphas./alphas(1));
hold on
plot(config.gen.Ws,betas./betas(1));
title('Fit parameters')
legend('\alpha','\beta')
xlabel('Disorder strength')


% Fitting the PDF parameters
Ws = config.gen.Ws;
weight_viz{N}.alphas = alphas;
weight_viz{N}.betas = betas;


subplot(3,2,5)
coefs = [0,6.5,-1];
a_coef=pow_anal(Ws,alphas,coefs);
subplot(3,2,6)
coefs = [1,20,-1];
b_coef=pow_anal(Ws,betas,coefs);


% % For the plots below: - DOES THIS MEAN ANYTHING USEFUL?
% %   Scale the W values by some reference value w. Fit these with a powerlaw
% %   Fit alpha(W/w) with a powerlaw. 
% %   Plot the scale factor scale(w) versus W. 
% %   Notice that the scale factor scales as b(W/w0)^gamma!
% %   Overlaid is plot with unscaled Ws (i.e. with w0=1)

% subplot(2,2,3)
% a_coeff = zeros(size(Ws));
% for i=1:numel(Ws)
%  w0 = Ws(i);
%  a_coefs = pow_anal(Ws/w0,a_list);
%  a_coeff(i) = a_coefs(2);
% end
% plot(Ws,a_coeff,'x')
% hold on
% plot(Ws,a_coef(2)*Ws.^a_coef(3))
% hold off
% 
% 
% subplot(2,2,4)
% a_coeff = zeros(size(Ws));
% for i=1:numel(Ws)
%  w0 = Ws(i);
%  b_coefs = pow_anal(Ws/w0,b_list);
%  b_coeff(i) = b_coefs(2);
% end
% 
% 
% plot(Ws,b_coeff,'x')
% hold on
% plot(Ws, b_coef(2)*Ws.^b_coef(3))
% hold off

end



function coefs = pow_anal(X,Y,coefs)
pow_fit_mdl = @(p,x) p(1) + p(2)*x.^p(3);
% pow_fit = fitnlm(X,Y,pow_fit_mdl,coefs);
% coefs = pow_fit.Coefficients.Estimate;
plot(X,Y)
hold on
plot(X,pow_fit_mdl(coefs,X))
hold off
legend('Data','Fit')
ylim([0,max(Y)])

end
