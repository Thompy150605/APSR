clear all
close all
clc

% ==========================================
% 1. DEFINISI LOKASI (Fine Tuned Parameters)
% ==========================================
% Locations: Root Exposed, Hardpoint 1, Hardpoint 2
locations = [0.47045, 2.04, 3.15]; 
loc_names = {'Root Exposed', 'Hardpoint 1', 'Hardpoint 2'};

% Wing Geometry (For automatic Chord calc)
c_root = 2.76;   
c_tip  = 1.13;   
b_semi = 6.18;   

% Load Data Source (Ensure MomentData.csv is in the folder)
dataFilename = 'LoadData.csv'; 
if ~isfile(dataFilename)
    error('File %s not found! Please rename your .csv file to MomentData.csv', dataFilename);
end
rawData = readmatrix(dataFilename);
y_ref = rawData(:, 1);
M_ref = rawData(:, 2);
V_ref = rawData(:, 3);
T_ref = rawData(:, 4);

% ==========================================
% 2. ANALYSIS LOOP
% ==========================================
for i = 1:length(locations)
    % A. Set Variables for this Section
    y_location = locations(i);
    loc_name = loc_names{i}; % <--- Variable used by Main_MoSTresca
    
    % B. Calculate Chord & Interpolate Loads
    c = c_root - (c_root - c_tip) * (y_location / b_semi);
    
    M = interp1(y_ref, M_ref, y_location, 'linear', 'extrap');
    V = interp1(y_ref, V_ref, y_location, 'linear', 'extrap');
    T = interp1(y_ref, T_ref, y_location, 'linear', 'extrap');
    
    % C. Fixed Parameters
    d = c/2; 
    L_rib = 0.700; % Optimized spacing to prevent NaN
    
    fprintf('Running Analysis: %s (y=%.2fm)...\n', loc_name, y_location);
    
    % D. Run Calculation Scripts
    Main_Input          
    Main_IdealisasiLuas 
    Main_ShearFlow      
    Main_BendingMoment  
    Main_Buckle1        
    Main_Buckle2        % <--- Contains the NaN fix
    Main_MoSTresca      % <--- Generates the named Table
    Main_MoSBuckle      
    Visualisasi_Table
end

fprintf('\nAll sections analyzed. Check the 3 pop-up windows.\n');