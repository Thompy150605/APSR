%% ITERASI 1 (Initial Sizing)

y_sections = [0.47045, 3.20, 4.96]; 

% Wing Geometry Constants
c_root = 2.76; 
c_tip  = 1.1; 
b_semi = 6.285;

% --- GEOMETRY CONFIGURATION (VECTORS) ---
% You can now vary the number of stringers per section!
% CHANGE APPLIED HERE: Section 1 stringers changed from 12 to 8
n_str_vec  = [6, 6, 6];      % Number of stringers (Top & Bottom)

% --- SKIN THICKNESS (CONSISTENT) ---
t_skin_u_vec = [1.5, 1.5, 1.5]; 
t_skin_l_vec = [1.5, 1.5, 1.5]; 

% --- SPAR WEB THICKNESS ---
% Front spar takes 70-80% shear, usually tapers out
t_sparf_vec  = [3.3, 2.2, 2.2]; 
t_sparr_vec  = [3.3,  2.2, 2.2];

% --- STRINGER GEOMETRY (Z-STRINGER) ---
h_st_vec    = [8.3, 5.8, 5.8];    % Height (mm)
t_st_vec    = [1.55, 1.55, 1.55]; % Thickness (mm)
w_flange_vec= [4.97, 17.3, 17.3];    % Flange (mm)

% --- SPAR CAP GEOMETRY ---
w_f_cap_vec = [128, 56, 56];   % Effective Width Front (mm)
w_r_cap_vec = [62,  27, 27];   % Effective Width Rear (mm)
t_cap_vec   = [2.5, 2.5, 2.5]; % Effective Thickness

%% ITERASI 2
% ==========================================
% 1. VECTOR INPUT DEFINITIONS (3 SECTIONS)
% ==========================================
% Define the spanwise locations for your sections
% Section 1 (Root), Section 2 (Mid), Section 3 (Tip)
y_sections = [0.47045, 3.20, 4.96]; 

% Wing Geometry Constants
c_root = 2.76; 
c_tip  = 1.1; 
b_semi = 6.285;

% --- GEOMETRY CONFIGURATION (VECTORS) ---
% You can now vary the number of stringers per section!
% CHANGE APPLIED HERE: Section 1 stringers changed from 12 to 8
n_str_vec  = [8, 8, 8];      % Number of stringers (Top & Bottom)

% --- SKIN THICKNESS (CONSISTENT) ---
t_skin_u_vec = [2.6, 2.6, 2.6]; 
t_skin_l_vec = [2.1, 2.1, 2.1]; 

% --- SPAR WEB THICKNESS ---
% Front spar takes 70-80% shear, usually tapers out
t_sparf_vec  = [4.65, 3.5, 2.5]; 
t_sparr_vec  = [2.4,  2.0, 1.8];

% --- STRINGER GEOMETRY (Z-STRINGER) ---
h_st_vec    = [30, 30, 25];    % Height (mm)
t_st_vec    = [5.2, 4.0, 3.0]; % Thickness (mm)
w_flange_vec= [15, 15, 12.5];    % Flange (mm)

% --- SPAR CAP GEOMETRY ---
w_f_cap_vec = [128, 90, 60];   % Effective Width Front (mm)
w_r_cap_vec = [64,  50, 40];   % Effective Width Rear (mm)
t_cap_vec   = [2.5, 2.5, 2.5]; % Effective Thickness

%% ITERASI 3
% ==========================================
% 1. VECTOR INPUT DEFINITIONS (3 SECTIONS)
% ==========================================
% Define the spanwise locations for your sections
% Section 1 (Root), Section 2 (Mid), Section 3 (Tip)
y_sections = [0.47045, 3.20, 4.96]; 

% Wing Geometry Constants
c_root = 2.76; 
c_tip  = 1.1; 
b_semi = 6.285;

% --- GEOMETRY CONFIGURATION (VECTORS) ---
% You can now vary the number of stringers per section!
% CHANGE APPLIED HERE: Section 1 stringers changed from 12 to 8
n_str_vec  = [8, 8, 8];      % Number of stringers (Top & Bottom)

% --- SKIN THICKNESS (CONSISTENT) ---
t_skin_u_vec = [3.5, 3.5, 3.5]; 
t_skin_l_vec = [3.5, 3.5, 3.5]; 

% --- SPAR WEB THICKNESS ---
% Front spar takes 70-80% shear, usually tapers out
t_sparf_vec  = [4.65, 3.5, 2.5]; 
t_sparr_vec  = [2.4,  2.0, 1.8];

% --- STRINGER GEOMETRY (Z-STRINGER) ---
h_st_vec    = [30, 30, 25];    % Height (mm)
t_st_vec    = [5.2, 4.0, 3.0]; % Thickness (mm)
w_flange_vec= [15, 15, 12.5];    % Flange (mm)

% --- SPAR CAP GEOMETRY ---
w_f_cap_vec = [128, 90, 60];   % Effective Width Front (mm)
w_r_cap_vec = [64,  50, 40];   % Effective Width Rear (mm)
t_cap_vec   = [2.5, 2.5, 2.5]; % Effective Thickness

%% ITERASI 4
% ==========================================
% 1. VECTOR INPUT DEFINITIONS (3 SECTIONS)
% ==========================================
% Define the spanwise locations for your sections
% Section 1 (Root), Section 2 (Mid), Section 3 (Tip)
y_sections = [0.47045, 3.20, 4.96]; 

% Wing Geometry Constants
c_root = 2.6357; 
c_tip  = 1.1; 
b_semi = 6.285;

% --- GEOMETRY CONFIGURATION (VECTORS) ---
% You can now vary the number of stringers per section!
n_str_vec  = [12, 10, 8];      % Number of stringers (Top & Bottom)

% --- SKIN THICKNESS (CONSISTENT) ---
t_skin_u_vec = [2.6, 2.6, 2.6]; 
t_skin_l_vec = [2.1, 2.1, 2.1]; 

% --- SPAR WEB THICKNESS ---
% Front spar takes 70-80% shear, usually tapers out
t_sparf_vec  = [4.65, 3.5, 2.5]; 
t_sparr_vec  = [2.4,  2.0, 1.8];

% --- STRINGER GEOMETRY (Z-STRINGER) ---
h_st_vec    = [30, 30, 25];    % Height (mm)
t_st_vec    = [5.2, 4.0, 3.0]; % Thickness (mm)
w_flange_vec= [15, 15, 12.5];    % Flange (mm)

% --- SPAR CAP GEOMETRY ---
w_f_cap_vec = [128, 90, 60];   % Effective Width Front (mm)
w_r_cap_vec = [64,  50, 40];   % Effective Width Rear (mm)
t_cap_vec   = [2.5, 2.5, 2.5]; % Effective Thickness