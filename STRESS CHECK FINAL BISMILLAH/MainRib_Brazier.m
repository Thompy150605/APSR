%skin
t = 2.2;
%ribs
L_rib = 0.723; %jarak antar ribs dalam m
h_rib = 0.15; %tinggi ribs dalam m
t_rib = 1; %tebal ribs dalam mm

sigmaT = max([w.sigma]);
sigmaC = -min([w.sigma]);
sigmaMax = (sigmaT + sigmaC)/2;

sigmaB = 2*sigmaMax^2*t*L_rib/Al7075.E/h_rib/t_rib*10^-3 %satuan MPa
MoSBrazier = Al7075.sigmaY/sigmaB*1.5 - 1