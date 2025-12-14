clear all
% close all
clc

% ==========================================
% 1. DEFINISI LOKASI (Fine Tuned Parameters)
% ==========================================
% Locations: Root Exposed, Hardpoint 1, Hardpoint 2
locations = 0.47045; % [0.47045, 2.04, 3.15]
loc_names = {'Root Exposed', 'Hardpoint 1', 'Hardpoint 2'};

% Wing Geometry (For automatic Chord calc)
c_root = 2.76;   
c_tip  = 1.1;   
b_semi = 6.285;   

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
    Main_Input3          
    Main_IdealisasiLuas 
    Main_ShearFlow      
    Main_BendingMoment  
    Main_Buckle1  
    % Main_Buckle1_Auto
    Main_Buckle2  
    Main_MoSBuckle
    Main_MoSVonMises
    % fprintf('------------------------------------------------\n');
    % fprintf('Select Failure Criterion for Analysis:\n');
    % fprintf('1. Tresca Criterion (Conservative)\n');
    % fprintf('2. Von Mises Criterion (More Accurate)\n');
    % fprintf('------------------------------------------------\n');
    % crit_choice = input('Enter your choice (1 or 2): ');
    % 
    % if crit_choice ~= 1 && crit_choice ~= 2
    %     error('Invalid input! Please restart and choose 1 or 2.');
    % end
    % 
    % if crit_choice == 1
    %     % Run Tresca
    %     Main_MoSTresca
    %     % Optionally visualize Tresca specific plots if you have them
    %     % Visualisasi_MoSTresca; 
    % elseif crit_choice == 2
    %     % Run Von Mises (Ensure you have created Main_MoSVonMises.m)
    %     Main_MoSVonMises
    %     % Optionally visualize Von Mises specific plots
    %     % Visualisasi_MoSVonMises;
    % end

end

fprintf('\nAll sections analyzed. Check the 3 pop-up windows.\n');