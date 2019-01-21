function graph_data = v2g_rec_atomized(v_in)

        v = v_in/norm(v_in); %just in case
        rho = v.*v';
     
        graph_data = rho_to_graph(rho); 
        %Aleph - has 2*on-site entropy on diagonal. Can recover G (zero diag) & L easy

end