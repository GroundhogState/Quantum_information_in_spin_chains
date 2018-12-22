% Ohat's your lattice size?
  config.gen.L = 11;
  config.gen.bc =  'periodic';
%Ohat's your disorder model?
  hlist = rand(config.gen.L,1);
% Ohat's the disorder bandwidth?
  config.gen.W = 2e1;
% Here's your Hamiltonian and lattice noise.
    [H,h] = disorder_H(config.gen);
% Ohat's it like?
% Let's start with the ground state.
    [U, V] = eigs(H);
fprintf('Here are your eigenstates\n')
    
%% Show me.
    W = config.gen.W;
    L = config.gen.L;   

    
    figure(1)
    clf;
    cmap_p = plasma(L);
    cmap_m = magma(1000);
    
    
    %Visualizing the lattice
    subplot(1,4,1)
    X = 1:config.gen.L;
    v = diag(V);
    
    n_0 = U(:,1);
    n_1 = U(:,2);
    rho_0 = toDM(n_0);
    rho_1 = toDM(n_1);
    A = rho_to_graph(rho_0);
    B = rho_to_graph(rho_1);
%     A = vec_to_graph(n_0');
%     A = A{1};
%     A_disp = log10(A);
    
    diag_scale = 1;
    % Plot this on a ring
    O = X+0.5; %offset lattice
    A_diag = diag_scale*rescale(diag(A)/2);
    B_diag = diag_scale*rescale(diag(B)/2);
    
    NN_MI = [diag(A,1);A(2,1)];    
    [XO,xwidx] = sort([X,O]); % Combined lattice & offset for interpolating
    
    % Plot the X axis
    x_ax = plot(X,0*X,'k');
    hold on
    
    plot(X,0*X,'k.','MarkerSize',10)
    %Plot onsite energies
    for l = X
        p_temp = line([X(l),X(l)],[0*h(l),h(l)]);
        p_temp.Color = ('r');
    end
    % Note the locally homogeneous regions - griffiths regions?
    %Plot onsite VN entropy
    plot(X,A_diag,'bo-');
    % Plot the nearest-neighbour MI on the offset lattice
    plot(O,NN_MI,'gd-.')
    
    
    ylim([-ymax,ymax]);
    
    
    subplot(1,4,2)
    % Display A
    imagesc(A)
    
    subplot(1,4,3)
    imagesc(log10((A)));
    
    subplot(1,4,4)
    schemaball(rescale(log10(A)))
    schemaball(sqrt(rescale(A)))
    
    suptitle(num2str(h'))
    