clear all

%input chord airfoil
%input data wing
taper_ratio = 0.4; % wing taper ratio
Sspan = 6.28; % wing semispan
rootchord = 2.75; % root chord
gradient = ((taper_ratio*rootchord)-rootchord)/Sspan; % perubahan panjang chord per m
Sroot = 0.36; % semispan exposed root
Sp1 = 3.45; % semispan point 1
Sp2 = 4.97; % semispan point 2
Croot = rootchord + (Sroot*gradient); % Panjang chord exposed root
Cp1 = rootchord + (Sp1*gradient); % Panjang chord point 1
Cp2 = rootchord + (Sp2*gradient); % Panjang chord point 2
L_rib = 0.4; % jarak antar rib

c_section = [Croot Cp1 Cp2]; %m

%kond Lift dalam
ShearLoad = readmatrix('ShearBNDAR.csv');
TorsionLoad = readmatrix('TorsionBNDAR.csv');
BendingLoad = readmatrix('BendingBNDAR.csv');

% Shear
Vroot = interp1(ShearLoad(:,1),ShearLoad(:,2),Sroot);
Vp1 = interp1(ShearLoad(:,1),ShearLoad(:,2),Sp1);
Vp2 = interp1(ShearLoad(:,1),ShearLoad(:,2),Sp2);

V_section = [Vroot Vp1 Vp2];

% Bending
Mroot = interp1(BendingLoad(:,1),BendingLoad(:,2),Sroot);
Mp1 = interp1(BendingLoad(:,1),BendingLoad(:,2),Sp1);
Mp2 = interp1(BendingLoad(:,1),BendingLoad(:,2),Sp2);

M_section = [Mroot Mp1 Mp2];

% Torsion
Troot = interp1(TorsionLoad(:,1),TorsionLoad(:,2),Sroot);
Tp1 = interp1(TorsionLoad(:,1),TorsionLoad(:,2),Sp1);
Tp2 = interp1(TorsionLoad(:,1),TorsionLoad(:,2),Sp2);

T_section = [Troot Tp1 Tp2];

d = c_section./2; %off set dari titik x=0 dalam m

%Notes:
% skin thickness perlu ditambah 0.5 mm agar struktur '

Main_Input1;
Main_IdealisasiLuas;
Main_ShearFlow;
Main_BendingMoment;
Main_Buckle1;
Main_Buckle2;
Main_MoSTresca;
Main_MoSBuckle;
Main_TotalMassa;
Main_CompileResult;
% fprintf('MoS tresca terkecil section 1 %0.2f\n', min([w(:,1).MoSTresca]))
% fprintf('MoS bukcle terkecil section 1 %0.3f\n', min([w(:,1).MoSBuckle]))
% fprintf('MoS tresca terkecil section 2 %0.2f\n', min([w(:,2).MoSTresca]))
% fprintf('MoS bukcle terkecil section 2 %0.3f\n', min([w(:,2).MoSBuckle]))
% fprintf('MoS tresca terkecil section 3 %0.2f\n', min([w(:,3).MoSTresca]))
% fprintf('MoS bukcle terkecil section 3 %0.3f\n', min([w(:,3).MoSBuckle]))