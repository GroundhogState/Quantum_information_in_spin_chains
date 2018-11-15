function rho_out = TrX2(rho, systems)
% Computes inner product between rho and the basis vectors spanning the
% product space of specified systems. Returns a 2^l*2^l reduced density
% matrix from a 2^L*2^L, where L is total system size and l is reduced
% system size. Works only for collections of two level systems, but should
% generalize OK, assuming one can efficiently generate a basis for the
% local spaces... 
    
    P = cell(4);
    P{1} = eye(2);
    P{2} = Pauli('X',0);
    P{3} = Pauli('Y',0);
    P{4} = Pauli('Z',0);
    
    L = log2(length(rho));
    l = length(systems);
    
    eye_list = cell(L,1);
    for ii=1:L
        eye_list{ii} = eye(2);
    end
    
    %Generate all pairs of Pauli operators acting on the subsystem
    % Assuming l=2 for now... Perhaps need to recurse in general?
    rho_out = zeros(2^l,2^l);
    
    %Doing this the filthy way... You can only trace down to 1 or 2
    %systems. But this is consistent with needs for now....

    if length(systems) == 1
        for ii=1:4 %loop over Paulis
                op_list = eye_list;
                op_list{systems(1)} = 0.5*P{ii};
                basis_vec = Tensor(op_list);
                exp_val =  trace(rho*basis_vec); %Coefficient of basis_ii,jj
                rho_out = rho_out + exp_val*P{ii};
        end
    elseif length(systems) == 2
        for ii=1:4 %loop over Paulis
            for jj=1:4
                op_list = eye_list;
                op_list{systems(1)} = 0.5*P{ii};
                op_list{systems(2)} = 0.5*P{jj};
                basis_vec = Tensor(op_list);
                exp_val =  trace(rho*basis_vec); %Coefficient of basis_ii,jj
                rho_out = rho_out + exp_val*Tensor(P{ii},P{jj});
            end
        end
    elseif length(systems) >2
        disp("Sorry, I don't know what to do with that input.")
    end
end

    
%     function basis_list = basis_list(systems,L)
%         %Computes the basis set of the product space of *systems* within a
%         %total system size L.
%         eye_list = cell(L,1);
%         for ii=1:L
%             eye_list{ii} = eye(2);
%         end %Maybe I can get away without generating this every time?
%             
%             
%         if length(systems) == 1 %base case
%             for np = 1:4
%                 op_list = eye_list;
%                 op_list(systems) = 
%             
%         else 
%             for jj=1:length(systems)
%             subsystems = systems;
%             subsystems(jj) = [];
%         end
%          
%         
%     end
    
    

%     



% end