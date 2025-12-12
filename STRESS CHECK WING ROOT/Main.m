clear all
%input chord airfoil
%c = 2.66; % exposed root
c = 2.66; 
% N MAX
V = 64635.66646; %dalam N
d = c/2; %off set dari titik x=0 dalam m
T = -6522.480373; %dalam Nm
M = 123959.8142;



%input data ribs
L_rib = 0.3; %jarak antar ribs dalam m

Main_InputRoot4
Main_IdealisasiLuas
Main_ShearFlow
Main_BendingMoment
Main_BuckleRoot4
Main_Buckle2
Main_MoSBuckle
Main_MoSTresca
Main_TotalMassa
fprintf('MoS tresca terkecil %0.2f\n', min([w.MoSTresca]))
fprintf('MoS bukcle terkecil %0.3f\n', min([w.MoSBuckle]))
