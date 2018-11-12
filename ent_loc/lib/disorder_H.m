function [H, h_list] = disorder_H(L,W)
    h_list = W*(-1+2*rand(L,1));
    H_onsite = gen_onsite(L,0.5*h_list);
    bc = 'periodic';
    H_int =0.25* get_interaction(L,bc);
    H = H_onsite + H_int;
end