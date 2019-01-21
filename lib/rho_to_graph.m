function A = rho_to_graph(rho)
% INPUT: One density matrix. 
%OUTPUT: One Aleph. Diagonal is 2x VN entropy, off-diag is MI.
% SUPERSEDES vec_to_graph
% Should try parfor (versus recursive method)
        rho = rho/trace(rho);
        num_sys = log2(length(rho));
        dims = 2*ones(1,num_sys);
%         ent_list = zeros(L,1);
%         A = zeros(L);
%         A_temp = zeros(L);
%         systems = 1:L;
        
        A = rho_reduce(rho, dims,num_sys);

%         for ii=1:L 
%             for jj = ii+1:L
%                trace_pair = systems;
%                trace_pair(ii) =[];
%                trace_pair(jj-1) = [];
%                rho_red = TrX(rho,trace_pair,dims);
%                A_temp(ii,jj) =  Entropy(rho_red);
%             end
%             if ii==L
%                 ent_list(ii) = Entropy(TrX(rho_red,1,[2,2]));
%             else
%                 ent_list(ii) = Entropy(TrX(rho_red,2,[2,2]));
%             end
%         end
% 
%         A_temp = abs(A_temp + A_temp');
%         for ii=1:L
%             for jj=1:L
%             A(ii,jj) = abs(ent_list(ii)) + abs(ent_list(jj)) - A_temp(ii,jj);  
%             end
%         end

end

function A = rho_reduce(rho,dims,num_sys)
% In this version: Try to optimize second stage (loop over subsystems)
  % Accepts a many-body density matrix, a list of dimensions of its subsystems,
  % and the length L of the total initial system
  N = length(dims);
  A = zeros(N,N);  % Will eventually hold output.
  if N == 2
    % Base case
    A(N-1,N)= Entropy(rho);
    A(N-1,N-1)= Entropy(TrX(rho,2,dims));
    A(N,N)= Entropy(TrX(rho,1,dims));
  elseif N > 2
    % Super-cases:
    % Obtain first pair and first single site
    B = TrX(rho, 3:N,dims);
    A(num_sys-N+1,num_sys-N+2)= Entropy(B);
    A(num_sys-N+1,num_sys-N+1)= Entropy(TrX(B,2,dims(1:2)));
    % Obtain all pairs involving the first system but not the second
    A(num_sys-N+1,num_sys-N+3:end) = cleave_trace(TrX(rho,2,dims),dims([1,3:end]));
    % Call the next recursion and use it to fill out the Delta array
    A(2:end,2:end) = rho_reduce(TrX(rho,1,dims),dims(2:end),N-1);
  end
end

function A_row = cleave_trace(rho,dims)
    % A tailored function which computes all the 2-body density matrices of
    % a many-body state, constrained such that each 2BDM includes the first
    % site.
    N = length(dims);
    % Returns a cell array of all 2BDMs involving the first system
    % of which there are N-1
    A_row = zeros(1,N-1);
    if N == 2
        % base case
        A_row(1) = Entropy(rho);
    elseif N>2
        % Superior case
        n1 = ceil(N/2);
        % obtain RDM1 by tracing out the right half, = [s1,s2,...,sn1]
        A_row(1:n1-1) = cleave_trace(TrX(rho, n1+1:N,dims),dims(1:n1));
        % Obtain RDM2 by tracing out the left half except S1, = [s1,s(n1+1),...,sN]
        A_row(n1:end) = cleave_trace(TrX(rho, 2:n1,dims),dims([1,n1+1:N]));
    else 
        error('Wrong system size')
    end

end