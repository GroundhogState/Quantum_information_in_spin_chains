
function R = KL_distance(P,Q)
    % Issues: P=0 (div by 0)
    %           Q = 0 (log(0))
    mask = P>0 & Q>0;
    P_ = P(mask);
    Q_ = Q(mask);
    R = sum(-P_.*log(Q_./P_));

end