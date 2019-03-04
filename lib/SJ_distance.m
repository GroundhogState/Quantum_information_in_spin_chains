function D = SJ_distance(P,Q)
    % Computes the shannon-jensen divergence of two PDFs (normalized)
   
    R = (P+Q)/2; % 'average' distribution
    D = 0.5*(KL_distance(P,R) + KL_distance(Q,R));
    
end
