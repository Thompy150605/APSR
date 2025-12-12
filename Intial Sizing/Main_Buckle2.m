%shear buckle di skin dan spar (ESDU 71005)

for i = 1:length(w)
    ratio = w(i).length / L_rib;
    w(i).tauCrit = K_Buckle2(ratio)*w(i).material.E*(w(i).t/1000/w(i).length)^2*10^3;
    fprintf('Nilai K: %.4f\n', K_Buckle2(ratio));
end