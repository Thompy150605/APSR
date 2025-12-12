%skin
t = 2.3; % Sesuaikan
%ribs
L_rib = 0.349; %jarak antar ribs dalam m (Sesuaikan)
h_rib = 0.15; %tinggi ribs dalam m (Sesuaikan)
t_rib = 1; %tebal ribs dalam mm (Sesuaikan)

sigmaT = max([w.sigma]);
sigmaC = -min([w.sigma]);
sigmaMax = (sigmaT + sigmaC)/2;

sigmaB = 2*sigmaMax^2*t*L_rib/Al7075.E/h_rib/t_rib*10^-3 %satuan MPa
MoSBrazier = Al7075.sigmaY/sigmaB*1.5 - 1