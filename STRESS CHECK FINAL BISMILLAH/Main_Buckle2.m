%shear buckle di skin dan spar (ESDU 71005)
for j = 1:length(c_section)
    for i = 1:height(w(:,j))
        w(i,j).tauCrit = K_Buckle2(w(i,j).length/L_rib)*w(i,j).material.E*(w(i,j).t/1000/w(i,j).length)^2*10^3;
        %fprintf('Wall %s shear stress critnya %.2f MPa\n',w(i).name,w(i).tauCrit)
    end
end
