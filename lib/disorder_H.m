function [H, h_list] = disorder_H(L,W)
    h_list = W*(-1+2*rand(L,1));
% <<<<<<< HEAD
    H_onsite = 0.5*gen_onsite(L,h_list);
% =======
%     H_onsite = gen_onsite(L,0.5*h_list);
% >>>>>>> 501355829750fddf03df7a6f16452b7f6c42956f
    bc = 'periodic';
    H_int =0.25* get_interaction(L,bc);
    H = H_onsite + H_int;
end