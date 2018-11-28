EMG = @(p,x) (p(3)/2)*(exp((p(3)/2)*(2*p(1)+p(3)*p(2)^2-2*x))).*erfc((p(1)+p(3)*p(2)^2-x)/(sqrt(2)*p(2)));
EMG2 = @(p,x) sqrt(pi/2) * (p(1)*p(3)/p(4)) * exp( 0.5*(p(3)/p(4))^2 - (x-p(2))/p(4) ).*erfc( (p(3)/p(4) - (x-p(2))/p(3) )/sqrt(2));
EPG = @(p,x) p(4)*(1/sqrt(2*pi*p(2)^2))*exp(-((x-p(1))/(sqrt(2*p(2)))).^2) + p(5)*p(3)*exp(-p(3)*x);
EXP = @(p,x) exp(-p*x);
POW = @(p,x) (p(1)^x)*p(2); 

N_list = [1,2,3,4,5,6,7,8,9,10];
fit_pars = zeros(length(N_list),2);

for i=1:length(N_list)   
    N = N_list(i);
    dat_choice = weight_viz;
    dat = dat_choice{N}.dat;
    hist_win = dat_choice{N}.hist_win;
    hist_bins =dat_choice{N}.hist_bins;
    H = dat_choice{N}.hist_counts;
    
    m = mean(dat);
    s = std(dat);
    gamma = skewness(dat);
    mu_guess = m-s*(gamma/2)^(1/3);
    sigma_guess = s^2*(1-(gamma/2)^(2/3));
    tau_guess = s*(gamma/2)^(1/3);
    
    
    % Log setup
    log_dat = dat_choice{N}.log_dat;
    log_hist_win = dat_choice{N}.log_hist_win;
    log_hist_bins =dat_choice{N}.log_hist_bins;
    log_H = dat_choice{N}.log_hist_counts;
    
    log_m = mean(log_dat);
    log_s = std(log_dat);
    log_gamma = skewness(log_dat);
    log_mu_guess = log_m-log_s*(log_gamma/2)^(1/3);
    log_sigma_guess = log_s^2*(1-(log_gamma/2)^(2/3));
    log_tau_guess = log_s*(log_gamma/2)^(1/3);
    
    % guesses 
    
    EMG_guess = [mu_guess,abs(sigma_guess),tau_guess];
    EMG2_guess = [1,mu_guess,abs(sigma_guess),tau_guess];
    EPG_guess = [mu_guess,s,tau_guess,1/N,1];
    
    log_EMG_guess = [log_mu_guess,abs(log_sigma_guess),log_tau_guess];
    log_EMG2_guess = [1,log_mu_guess,abs(log_sigma_guess),log_tau_guess];
    log_EPG_guess = [log_mu_guess,s,log_tau_guess,1/N,1];
    
    
% %     figure()
%     subplot(3,1,1)
%     plot(hist_bins,H,'-');
%     hold on
% %     plot(hist_bins,EXP(1/m,hist_bins));
%     plot(m,0.5*max(H),'x')
%     
%     title('Lin data')
% %     set(gca,'Yscale','log')
%     xlabel('x')
% 
%     subplot(3,1,2)
%     plot(log_hist_bins,log_H,'-');
%     hold on
%     plot(log_m,0.5*max(log_H),'x')
% %     plot(hist_bins,EXP(1/log_m,log_hist_bins));
%     title('log data')
%     xlabel('-log x')
    
    subplot(2,1,1)
    plot(log_hist_bins,log(log_H),'-');
    hold on
%     plot(log_hist_bins,EXP(1/m,log_hist_bins));
%     

       range = log_hist_bins>0.6 & log_hist_bins<0.85 & log_H > 0 ;

       X = log_hist_bins(range);
       X_aug = [X',ones(size(X'))];
       Y = log(log_H(range))';
       lin_fit = @(p,x) p(1) + p(2)*x;
       beta0 = [1,-2];
%        plot(X, lin_fit(beta0,X));
       fit = fitnlm(X,Y,lin_fit, beta0);
       plot(X, lin_fit(fit.Coefficients.Estimate,X));
       fit_pars(i,:) = fit.Coefficients.Estimate;

    title('log data')
%     set(gca,'Yscale','log')
    xlabel('-log x')
      
end
subplot(2,1,1)
hold off
subplot(2,2,3)
plot(N_list, fit_pars(:,1),'o')
hold off
subplot(2,2,4)
plot(N_list, fit_pars(:,2),'o')    
hold off

% legend('1','4','7','10')



    
% subplot(3,1,1)
hold off
% subplot(3,1,2)
% hold off
% subplot(3,1,3)
% hold off   
