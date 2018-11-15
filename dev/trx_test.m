P = cell(4);
P{1} = eye(2);
P{2} = Pauli('X',0);
P{3} = Pauli('Y',0);
P{4} = Pauli('Z',0);

% bloch

rho1 = qubit([0 0 0]);
rho2 = qubit([1 0 1]);
rho3 = qubit([0 1 0]);
rho4 = qubit([1 1 1]);
rho = Tensor(rho1,rho2,rho3,rho4);

systems = [1,4];

% rho_out = TrX2(rho,systems)
%Cool! Seems to work. Let's put it through some paces.

Ls = 3:10;
num_trials = 10;
times = zeros(2,length(Ls),num_trials); %Toby vs Me

profile on
for i=1:length(Ls)
    for j = 1:num_trials
        L = Ls(i);
        idxs = 1:L;
        dims = 2*ones(L,1);
        v_test = 2*(rand(2^L,1)-0.5);
        v_test = v_test/norm(v_test);
        rho_test = toDM(v_test);
        systems =[1 L];
        sys_cubitt = setdiff(idxs,systems);
%         t0 = clock;
        TrX(rho_test,sys_cubitt,dims);
%         t1 = clock;
        TrX2(rho_test,systems);
%         t2 = clock;
%         times(1,i,j) = (t1(end)-t0(end));
%         times(2,i,j) = (t2(end)-t1(end));
    end
end

profile off
profile viewer

% close all
% figure()
% plot(Ls,mean(times(1,:,:),3))
% hold on
% plot(Ls,mean(times(2,:,:),3))
% legend('Toby','Me')

