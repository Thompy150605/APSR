DaftarMaterial

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

% ==========================================
% 2. LOOP GENERATION & WEIGHT CALCULATION
% ==========================================
% Initialize Cell Arrays
p_cell = {}; 
w_cell = {};
loop_cell = {};

Total_Wing_Weight = 0; % Accumulator for weight

fprintf('\n======================================================\n');
fprintf('       WING SECTION GEOMETRY & WEIGHT REPORT       \n');
fprintf('======================================================\n');

for i = 1:length(y_sections)
    
    % A. Calculate Local Parameters
    y_loc = y_sections(i);
    c = c_root - (c_root - c_tip) * (y_loc / b_semi);
    
    % Get Vector Values
    N_str = n_str_vec(i);
    t_su  = t_skin_u_vec(i); t_sl = t_skin_l_vec(i);
    t_sf  = t_sparf_vec(i);  t_sr = t_sparr_vec(i);
    h_st  = h_st_vec(i);     t_st = t_st_vec(i);
    w_fl  = w_flange_vec(i);
    
    % Calculate Areas
    A_st = t_st * (h_st + 2 * w_fl); 
    A_sparf = w_f_cap_vec(i) * t_cap_vec(i);
    A_sparr = w_r_cap_vec(i) * t_cap_vec(i);
    
    % B. Generate Points (Dynamic)
    pitch_percent = 55 / (N_str + 1);
    points = [];
    
    % 1. Front Spar Upper (Pt 1)
    points = [points; Point('1', c * NACA63415(20, 1), Al7075, A_sparf)];
    % 2. Upper Stringers
    for k = 1:N_str
        loc_percent = 20 + (k * pitch_percent);
        points = [points; Point(sprintf('s%d_u', k), c * NACA63415(loc_percent, 1), Al7075, A_st)];
    end
    % 3. Rear Spar Upper & Lower
    idx_ru = N_str + 2; idx_rl = N_str + 3;
    points = [points; Point(sprintf('%d', idx_ru), c * NACA63415(75, 1), Al7075, A_sparr)];
    points = [points; Point(sprintf('%d', idx_rl), c * NACA63415(75, -1), Al7075, A_sparr)];
    % 4. Lower Stringers
    for k = N_str:-1:1
        loc_percent = 20 + (k * pitch_percent);
        points = [points; Point(sprintf('s%d_l', k), c * NACA63415(loc_percent, -1), Al2024, A_st)];
    end
    % 5. Front Spar Lower
    points = [points; Point('Last', c * NACA63415(20, -1), Al7075, A_sparf)];
    p_current = points; 
    
    % C. Generate Walls (Dynamic)
    walls = [];
    % Upper Skin
    walls = [walls; Wall('skin_u_1', p_current(1), p_current(2), Al7075, t_su)];
    for k = 2:(N_str+1)
        walls = [walls; Wall('skin_u', p_current(k), p_current(k+1), Al7075, t_su)];
    end
    % Rear Web
    walls = [walls; Wall('rear_web', p_current(idx_ru), p_current(idx_rl), Al7075, t_sr)];
    % Lower Skin
    walls = [walls; Wall('skin_l_1', p_current(idx_rl), p_current(idx_rl+1), Al2024, t_sl)];
    start_l = idx_rl + 1;
    for k = start_l : (start_l + N_str - 1)
         if k < length(p_current)
            walls = [walls; Wall('skin_l', p_current(k), p_current(k+1), Al2024, t_sl)];
         end
    end
    % Front Web
    walls = [walls; Wall('front_web', p_current(end), p_current(1), Al7075, t_sf)];
    
    % Save Results
    p_cell{i} = p_current;
    w_cell{i} = walls;
    loop_cell{i} = Loop(1:length(p_current), p_current, walls);

    % D. MASS & WEIGHT CALCULATION
    % -----------------------------------------------------
    % 1. Determine Section Length Automatically
    % Logic: Section extends to the start of the NEXT section. 
    % If it's the last section, it extends to the Wing Tip (b_semi).
    if i < length(y_sections)
        y_end = y_sections(i+1);
    else
        y_end = b_semi;
    end
    L_section = y_end - y_loc;

    % 2. Calculate Linear Mass Density (kg/m)
    M_linear = 0;
    
    % Sum Points (Stringers & Caps): Area(mm2) -> m2
    for k=1:length(p_current)
        M_linear = M_linear + p_current(k).area * 1e-6 * p_current(k).material.rho; 
    end
    
    % Sum Walls (Skins & Webs): Thickness(mm) * Length(m) * Rho
    % Note: Wall.length is usually calculated in meters from point coordinates
    for k=1:length(walls)
        M_linear = M_linear + walls(k).t * 1e-3 * walls(k).length * walls(k).material.rho; 
    end
    
    % 3. Calculate Section Weight
    W_section = M_linear * L_section;
    Total_Wing_Weight = Total_Wing_Weight + W_section;

    % =========================================================
    % E. ESDU 71014 PARAMETER CHECK (DYNAMIC)
    % =========================================================
    % 1. Get Coordinates of Front and Rear Spars
    % Point 1 is Front Spar Upper
    % Point idx_ru is Rear Spar Upper
    x_front = p_current(1).x;       % Meters
    x_rear  = p_current(idx_ru).x;  % Meters
    
    % 2. Calculate Box Width & Pitch
    box_width_mm = (x_rear - x_front) * 1000; 
    num_bays     = N_str + 1; 
    b_avg        = box_width_mm / num_bays; % Average pitch (b)
    
    % 3. Calculate Ratios
    ratio_h_b  = h_st / b_avg;   % h/b
    ratio_d_h  = w_fl / h_st;    % d/h (Flange/Height)
    ratio_ts_t = t_st / t_su;    % ts/t (Stringer Thick / Skin Thick)

   % E. PRINT REPORT
    % -----------------------------------------------------
    % Determine section name using standard if/else
    if i == 1
        sec_name = 'Root';
    elseif i == 2
        sec_name = 'Mid';
    else
        sec_name = 'Tip';
    end

    fprintf('SECTION %d: %s\n', i, sec_name);
    fprintf('   Range      : y = %.4f to %.4f m\n', y_loc, y_end);
    fprintf('   Length     : %.4f m\n', L_section);
    fprintf('   Stringers  : %d Top / %d Bottom\n', N_str, N_str);
    fprintf('   Lin. Dens. : %.2f kg/m\n', M_linear);
    fprintf('   WEIGHT     : %.2f kg\n', W_section);
    fprintf('   --- ESDU 71014 CHECK ---\n');
    fprintf('   Pitch (b)     : %.2f mm\n', b_avg);
    fprintf('   h/b           : %.4f  (Target: < 0.3 for efficiency)\n', ratio_h_b);
    fprintf('   d/h           : %.4f  (Target: < 0.3 for local buckling)\n', ratio_d_h);
    fprintf('   ts/t          : %.4f  (Target: 0.6 - 1.2 typical)\n', ratio_ts_t);
    fprintf('------------------------------------------------------\n');
    
    % F. Visualization
    figure(i); clf; hold on;
    for j=1:length(p_current), p_current(j).plot(); end
    for j=1:length(walls), walls(j).plot(); end
    axis equal; grid on; title(sprintf('Section %d (Mass: %.2f kg)', i, W_section));
end

fprintf('======================================================\n');
fprintf('TOTAL HALF-WING WEIGHT: %.2f kg\n', Total_Wing_Weight);
fprintf('TOTAL FULL-WING WEIGHT: %.2f kg\n', Total_Wing_Weight * 2);
fprintf('======================================================\n');

% Set Default Output (Root) for Compatibility
p = p_cell{1};
w = w_cell{1};
loop = loop_cell{1};