function [L1,R,R2,S,A]=inspect_state_graph(Lap,ii)
    

    Y = abs(diag(spec_list)');
    Y_ac = Y(1:end-1);
    X = 2:L;

    hold on
    subplot(3,3,2)
    p=plot((log(Y_ac)./X),X);
    p.Color = cm(ii,:);
    hold on

    A = -Lap;
    for j = 1:L
        A(j,j) = 0;
    end

    L1 = sum(Y_ac);
    L2 = sum(Y_ac.^2);
    R2 = (max(Y_ac)^2)/L2;
    S = -sum((Y_ac/L1).*log(Y_ac/L1));
    R = max(Y_ac)/L1;
end