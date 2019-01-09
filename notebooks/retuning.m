close all
% What's your lattice size?
  config.gen.L = 12;
  config.gen.bc =  'periodic';
% What's your disorder model?
  hlist = rand(config.gen.L,1);
% What's the disorder bandwidth?
  config.gen.W = 2e1;
% Here's your Hamiltonian and lattice noise.
    h_list = (-1+2*rand(config.gen.L,1));
    H_onsite = 0.5*gen_onsite(config.gen.L,h_list);
    H_int =0.25* get_interaction(config.gen.L,config.gen.bc);
    
% What's it like?
% Let's start with the ground state.

fprintf('Here are your eigenstates\n')
    
%% Show me.
    Ws = [0.1, 1, 3, 5];
    Wmax = length(Ws);
    L = config.gen.L; 
    Nmax = 6;
    
counter = 1;
for w = 1:Wmax
    H = Ws(w)*H_onsite + H_int;    
    [U, V] = eigs(H,L);
    for n = 1:Nmax
%         figure(n);
%         clf;
%         cmap_p = plasma(L);
%         cmap_m = magma(1000);
        cmap = colormap(plasma);


        %Visualizing the lattice


        n_0 = U(:,2*n-1);
        rho_0 = toDM(n_0);
        A = abs(rho_to_graph(rho_0));

        
        figure(1);
        subplot(Wmax,Nmax,counter)
        imagesc(A)

        figure(2);
        subplot(Wmax,Nmax,counter)
        imagesc(log10((A)));

        counter = counter + 1;
    %     subplot(6,3,4)
    %     schemaball(rescale(log10(A)))
    %     schemaball(sqrt(rescale(A)))     
%         suptitle(num2str(h'))
    end
end


%         subplot(6,3,1)
%         X = 1:config.gen.L;
%         v = diag(V);
    %     
    %     diag_scale = 1;
    %     % Plot this on a ring
    %     O = X+0.5; %offset lattice
    %     A_diag = diag_scale*rescale(diag(A)/2);
    %     
    %     NN_MI = [diag(A,1);A(2,1)];    
    %     [XO,xwidx] = sort([X,O]); % Combined lattice & offset for interpolating
    %     
    %     % Plot the X axis
    %     x_ax = plot(X,0*X,'k');
    %     hold on    
    %     plot(X,0*X,'k.','MarkerSize',10)
    %     %Plot onsite energies
    %     for l = X
    %         p_temp = line([X(l),X(l)],[0*h(l),h(l)]);
    %         p_temp.Color = ('r');
    %     end
    %     % Note the locally homogeneous regions - griffiths regions?
    %     %Plot onsite VN entropy
    %     plot(X,A_diag,'bo-');
    %     % Plot the nearest-neighbour MI on the offset lattice
    %     plot(O,NN_MI,'gd-.')