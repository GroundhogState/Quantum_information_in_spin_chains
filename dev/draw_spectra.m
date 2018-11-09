%%
% For playing with spin chains. Uses QETLab for now, at least for the
% partial trace and Pauli functions. 
function draw_spectra(L)
close all

L = 10;
W = 18;

H = disorder_H(L,W);
[eig, nrg] = eigs(full(H),2^L);

% sel = 1:100:1000;
% for ii = 1:numel(sel)
%     v = eig(:,sel(ii));
%     L = vec_to_graph(v);
%     [L_V, L_v] = eigs(L);
%     plot(diag(L_v))
%     hold on
% end

end