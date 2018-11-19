


% rho_out = TrX2(rho,systems)
%Cool! Seems to work. Let's put it through some paces.

% User spec

% Ls = 3:15;
% %Init variables
% 
% basis_vec = cell(2,2);
% 
% time_toby = zeros(size(Ls));
% time_jacob = zeros(size(Ls));       
% 
% num_trials = 1;
% for i=1:length(Ls)
%     L=Ls(i)
%     systems =[1 L];
%     l = length(systems);
%     idxs = 1:L;
%     sys_cubitt = setdiff(idxs,systems);
%     dims = 2*ones(L,1);
%     eye_list = cell(L,1);
% 
%     for j = 1:num_trials
%         v_test = 2*(rand(2^L,1)-0.5);
%         v_test = v_test/norm(v_test);
%         rho_test = toDM(v_test);
% 
%         toby  = @() TrX(rho_test,sys_cubitt,dims);
%         
%         time_toby(i) = timeit(toby);
% 
%     end
% end
close all
figure();
subplot(2,1,1)
plot(Ls,log(time_toby));
hold on
expmdl = @(p,x) p(1) + p(2)*exp(p(3)*x);
p0 = [-8 1 1];
fit = fitnlm(Ls,log(time_toby),expmdl,p0);
plot(Ls,expmdl(fit.Coefficients.Estimate,Ls));
p1 = fit.Coefficients.Estimate;
% plot(Ls,time_jacob);
% poly_J = polyfit(Ls,time_jacob,5);
% poly_T = polyfit(Ls,time_toby,5);
% plot(polyval(poly_T,Ls));
% plot(polyval(poly_J,Ls));
legend('permutation method',['fit log(T)=',num2str(p1(1)),'+',num2str(p1(2)),'exp(',...
            num2str(p1(3)),'L)'])
title('Time scaling: trace to 2 systems')
xlabel('L')
ylabel('log(walltime)')

subplot(2,1,2)
plot(1:13,exp(expmdl(p1,1:13)));
% set(gca,'Yscale','log')
profile off
profile viewer

%Conclusion: The homebrew sucks. Toby's TrX is good. What if we
%   Remove the Pauli calls? Probably not much different.
%       With        Without
%       49.7/43.5   48.4/42.4       Gains trivial, as expected.
%   The time in kron() is not so small, which is from all the Tensor calls.
%   But it looks like all the time is in TrX2. What if we generate the
%   basis vectors and then pass them in? Expect a few seconds less in TrX2
%   - and if basis vectors reused in multiple calls, this will add up. But
%   probably still marginal.
%   NICE. Now we're talking. Taking the basis generation out makes things
%   much faster, as it happens. Now TrX and TrX2 have comparable total
%   times - but TrX has more self-time! Note that I'm currently averaging
%   over lengths. Let's look at how the cost scales with L.
% Looks like Toby's is quadratically faster... Let's fit a polynomial model
