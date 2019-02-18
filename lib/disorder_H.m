function [H, h_list] = disorder_H(config_gen)

%% Generates H for a disordered spin chain.
%   Inputs: 
%         config.gen.W -- Disorder bandwidth
%         config.gen.L -- System size
%         config.gen.bc - Boundary conditions
%   Outputs
%         H  -- Full Hamiltonian
%         h_list -- Onsite energies

    h_list = config_gen.W*(-1+2*rand(config_gen.L,1));
    H_onsite = 0.5*gen_onsite(config_gen.L,h_list);
    H_int =0.25* get_interaction(config_gen.L,config_gen.bc);
    H = H_onsite + H_int;
end
