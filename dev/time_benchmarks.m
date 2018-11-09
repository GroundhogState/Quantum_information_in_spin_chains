%Timing stuff
close all
L_max = 8; 
num_trials = 3;
times = zeros(num_trials,L_max);
H_trials = cell(num_trials,L_max);
for i = 1:num_trials
    for j = 1:L_max
         U = gen_spectrum(j,W);
         H_trials{i,j} = U;
         times(i,j) = timeit(@() main);
    end
end

mean_times = mean(times);
err_times = std(times)/sqrt(num_trials);
errorbar(1:L_max,mean_times,err_times)

title('Time to generate Laplacian for full spectrum')
xlabel('number of sites')
ylabel('time (s)')
% for i = 1:num_trials
%     for j=1:L_max
%         times(i,j) = timeit(@() gen_spectrum(i,1));
%     end
% end