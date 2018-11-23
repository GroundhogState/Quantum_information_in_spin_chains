EMG = @(p,x) (p(3)/2)*(exp((p(3)/2)*(2*p(1)+p(3)*p(2)^2-2*x))).*erfc((p(1)+p(3)*p(2)^2-x)/(sqrt(2)*p(2)));
EMG2 = @(p,x) sqrt(pi/2) * (p(1)*p(3)/p(4)) * exp( 0.5*(p(3)/p(4))^2 - (x-p(2))/p(4) ).*erfc( (p(3)/p(4) - (x-p(2))/p(3) )/sqrt(2));
EPG = @(p,x) p(4)*(1/sqrt(2*pi*p(2)^2))*exp(-((x-p(1))/(sqrt(2*p(2)))).^2) + p(5)*p(3)*exp(-p(3)*x);


    N =2; 
    dat = spec_viz{N}.dat;
    hist_win = spec_viz{N}.hist_win;
    hist_bins =spec_viz{N}.hist_bins;
    H = spec_viz{N}.hist_counts;
    
    m = mean(dat);
    s = std(dat);
    gamma = skewness(dat);
    mu_guess = m-s*(gamma/2)^(1/3);
    sigma_guess = s^2*(1-(gamma/2)^(2/3));
    tau_guess = s*(gamma/2)^(1/3);
    
    
    % Log setup
    log_dat = spec_viz{N}.log_dat;
    log_hist_win = spec_viz{N}.log_hist_win;
    log_hist_bins =spec_viz{N}.log_hist_bins;
    log_H = spec_viz{N}.log_hist_counts;
    
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
    
    
    figure()
    subplot(2,1,1)
    plot(hist_bins,H,'-');
    hold on
    title('Lin data')
    xlabel('x')

    subplot(2,1,2)
    plot(log_hist_bins,log_H,'-');
    hold on
    title('log data')
    xlabel('-log x')
    
    % test plots
    subplot(2,1,1)
    plot(hist_bins,EMG(EMG_guess,hist_bins))
    plot(hist_bins,EMG2(EMG2_guess,hist_bins))
    EPG_plt = EPG(EPG_guess,hist_bins);
    EPG_plt = EPG_plt/trapz(hist_bins,EPG_plt);
    plot(hist_bins,EPG_plt)
    
    subplot(2,1,2)
    plot(log_hist_bins,EMG(log_EMG_guess,log_hist_bins))
    plot(log_hist_bins,EMG2(log_EMG2_guess,log_hist_bins))
    log_EPG_plt = EPG(log_EPG_guess,log_hist_bins);
    log_EPG_plt = log_EPG_plt/trapz(log_hist_bins,log_EPG_plt);
    plot(hist_bins,log_EPG_plt)       

    
    
    % FITTING
%         
      EMG_fit = fitnlm(hist_bins,H,EMG,EMG_guess);
      plot(hist_bins,EMG(EMG_fit.Coefficients.Estimate,hist_bins))     
      EMG2_fit = fitnlm(hist_bins,H,EMG2,EMG2_guess);
      plot(hist_bins,EMG2(EMG2_fit.Coefficients.Estimate,hist_bins))
      EPG_fit = fitnlm(hist_bins,H,EPG,EPG_guess);
      plot(hist_bins,EPG(EPG_fit.Coefficients.Estimate,hist_bins))  
        
%         log_EMG2_fit = fitnlm(log_hist_bins,log_H,EMG2,log_EMG2_guess);
%         plot(log_hist_bins,EMG2(log_EMG2_fit.Coefficients.Estimate,log_hist_bins))    
%         log_EPG_fit = fitnlm(hist_bins,H,EPG,log_EPG_guess);
%         plot(hist_bins,EPG(log_EPG_fit.Coefficients.Estimate,log_hist_bins))  
%     
    



    
%     legend('data','EMG','EMG2','EPG')
      
