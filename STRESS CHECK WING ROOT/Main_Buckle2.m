%shear buckle di skin dan spar (ESDU 71005)

for i = 1:length(w)
    w(i).tauCrit = K_Buckle2(w(i).length/L_rib)*w(i).material.E*(w(i).t/1000/w(i).length)^2*10^3;
    %fprintf('Wall %s shear stress critnya %.2f MPa\n',w(i).name,w(i).tauCrit)
end

