function [L1,R,R2,S,A]=inspect_state_graph(Lap,ii)
L = size(Lap,1);
    colormap winter(110)
    cm = colormap;
[vec_list,spec_list] = eigs(Lap,L);
%     subplot(3,3,7)
%     disc_vec = ones(L,1)/sqrt(L);
%     disc_proj = sum(vec_list.*disc_vec');
%     disc_tot = sum(disc_proj);
%     dp=plot(disc_proj);
%     dp.Color = cm(ii,:);
%     hold on
%     subplot(3,3,8)
%     plot(ii,disc_tot,'x');
%     hold on

%     subplot(3,2,1)
    Y = abs(diag(spec_list)');
    Y_ac = Y(1:end-1);
    X = 2:L;
%     ar=area((Y_ac),X);
%     alpha(0.1)
%     ar.Color = cm(ii,:);
%     hold on
%     ylim([min(X),max(X)])
%     camroll(180)
%     subplot(2,2,3)
%     plot(X,log10(Y(1:end-1)))
    hold on
    subplot(3,3,2)
    p=plot((log(Y_ac)./X),X);
    p.Color = cm(ii,:);
    hold on
%     VL = vec_list;
%     for j = 1:L-1
%        plot(VL(:,end-j)/max(abs(VL(:,end-j)))+2*j)
%        alpha(0.4)
%        hold on
%     end
    A = -Lap;
    for j = 1:L
        A(j,j) = 0;
    end
%     A;
%     G = graph(A);
%     LW = (G.Edges.Weight)/max(G.Edges.Weight);
%     plot(G,'Layout','circle','LineWidth',LW)
%     hold on
%     subplot(3,2,4)
%     F = sum(diag(spec_list).*vec_list,2);
%     plot(F)
%     hold on
%     plot(diag(Lap))
    L1 = sum(Y_ac);
    L2 = sum(Y_ac.^2);
    R2 = (max(Y_ac)^2)/L2;
    S = -sum((Y_ac/L1).*log(Y_ac/L1));
    R = max(Y_ac)/L1;
end