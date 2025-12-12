clear all

% From Wing Initial Sizing, we can calculate as below

% Chord at Root Exposed
c = 2.635744312;  % Calculated: Spar Dist 1.388m / (0.75-0.20)

% Loads (Ultimate or Limit as per sheet)
V = -107934.3286;  % Shear Force [N] (From Row 39)
M = 262881.9280; % Bending Moment [Nm] (From Row 38)
T = 69131.6799;      % [Nm] Torque due to Lift Offset
d = c/2;    % Offset (standard assumption)

% Rib Spacing
L_rib = 0.349; % [m] (From Row 10)

Main_Input
Main_IdealisasiLuas
Main_ShearFlow
Main_BendingMoment
Main_Buckle1
Main_Buckle2
Main_MoSTresca
Main_MoSBuckle
Main_TotalMassa
fprintf('MoS tresca terkecil %0.2f\n', min([w.MoSTresca]))
fprintf('MoS bukcle terkecil %0.3f\n', min([w.MoSBuckle]))