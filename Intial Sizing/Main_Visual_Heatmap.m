% Main_Visual_Heatmap.m
% Generates structural heatmaps for Buckling, Yield (Stress), and Shear.
% Based on Main.m logic.

clear all; clc; close all;

% ==========================================
% 1. SETUP & GEOMETRY
% ==========================================
locations = [0.47045, 2.04, 3.15];
loc_names = {'Root Exposed', 'Hardpoint 1', 'Hardpoint 2'};

c_root = 2.76;   
c_tip  = 1.1;   
b_semi = 6.285;   

% Load Load Data
dataFilename = 'LoadData.csv'; 
if ~isfile(dataFilename)
    error('File %s not found!', dataFilename);
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
    loc_name = loc_names{i};
    
    % B. Calculate Chord & Interpolate Loads
    c = c_root - (c_root - c_tip) * (y_location / b_semi);
    
    M = interp1(y_ref, M_ref, y_location, 'linear', 'extrap');
    V = interp1(y_ref, V_ref, y_location, 'linear', 'extrap');
    T = interp1(y_ref, T_ref, y_location, 'linear', 'extrap');
    
    d = c/2; 
    L_rib = 0.700; % Spacing
    
    fprintf('Analyzing %s (y=%.2fm)...\n', loc_name, y_location);
    
    % C. Run Calculation Scripts (Suppressing Output)
    evalc('Main_Input_Auto');          
    evalc('Main_IdealisasiLuas'); 
    evalc('Main_ShearFlow');      
    evalc('Main_BendingMoment');  
    evalc('Main_Buckle1');  
    evalc('Main_Buckle2');  
    evalc('Main_MoSBuckle');
    evalc('Main_MoSVonMises');
    
    % ==========================================
    % 3. GENERATE HEATMAP VISUALIZATION
    % ==========================================
    fig = figure('Name', ['Heatmap: ' loc_name], 'Units', 'normalized', 'Position', [0.1 0.1 0.8 0.6]);
    t = tiledlayout(1, 3, 'TileSpacing', 'compact', 'Padding', 'compact');
    title(t, ['Structural Analysis Heatmap - ' loc_name], 'FontSize', 16, 'FontWeight', 'bold');

    % --- PREPARE DATA FOR PATCH PLOTTING ---
    % We construct matrices for X, Y, and C (Color Data)
    % Each column represents one wall.
    
    num_w = length(w);
    X_dat = zeros(2, num_w);
    Y_dat = zeros(2, num_w);
    
    % Metrics
    Data_Buckle = zeros(1, num_w);
    Data_Yield  = zeros(1, num_w);
    Data_Shear  = zeros(1, num_w);
    
    for k = 1:num_w
        X_dat(1, k) = w(k).point1.x;
        X_dat(2, k) = w(k).point2.x;
        Y_dat(1, k) = w(k).point1.y;
        Y_dat(2, k) = w(k).point2.y;
        
        % 1. Buckling Data (MoS)
        % We cap high MoS at 2.0 so the color scale focuses on dangerous areas (MoS < 0)
        mos_b = w(k).MoSBuckle;
        if isnan(mos_b), mos_b = 5; end % Handle NaNs (e.g., pure tension)
        Data_Buckle(k) = mos_b;
        
        % 2. Yield Data (MoS Von Mises)
        mos_v = w(k).MoSVonMises;
        Data_Yield(k) = mos_v;
        
        % 3. Shear Data (Tau Magnitude)
        Data_Shear(k) = w(k).tau; 
    end
    
    % --- SUBPLOT 1: BUCKLING RISK (MoS) ---
    ax1 = nexttile;
    plotHeatmap(ax1, X_dat, Y_dat, Data_Buckle, 'MoS Buckle (Red = Fail)', true);
    
    % --- SUBPLOT 2: YIELD RISK (MoS Von Mises) ---
    ax2 = nexttile;
    plotHeatmap(ax2, X_dat, Y_dat, Data_Yield, 'MoS Yield/VM (Red = Fail)', true);
    
    % --- SUBPLOT 3: SHEAR STRESS (Intensity) ---
    ax3 = nexttile;
    plotHeatmap(ax3, X_dat, Y_dat, Data_Shear, 'Shear Stress \tau (MPa)', false);
    
end

fprintf('\nHeatmap generation complete.\n');

% ==========================================
% HELPER FUNCTION FOR PLOTTING
% ==========================================
function plotHeatmap(ax, X, Y, C_vec, title_str, isMoS)
    % Prepare Color Data for Patch (2xN matrix, same value for start and end of line)
    C_mat = [C_vec; C_vec];
    
    % Draw Lines using Patch
    % 'EdgeColor','flat' uses the CData to color the line segments
    patch(ax, X, Y, C_mat, 'LineWidth', 4, 'EdgeColor', 'flat');
    
    hold(ax, 'on');
    axis(ax, 'equal'); grid(ax, 'on');
    title(ax, title_str, 'FontWeight', 'bold');
    
    % Colormap Handling
    colormap(ax, turbo); % 'turbo' or 'jet' gives good contrast
    cb = colorbar(ax);
    
    if isMoS
        % For Margin of Safety: Red should be LOW (Fail), Blue/Green HIGH (Safe)
        % We fix the range to focus on the danger zone [-0.5 to 2.0]
        caxis(ax, [-0.5, 2.0]); 
        
        % Optional: Reverse colors so Red is bottom? 
        % Default Jet/Turbo: Blue is Low, Red is High.
        % For MoS, we want Low (Fail) to stand out. 
        % Let's use 'flipud(turbo)' so Blue is High MoS (Safe) and Red is Low MoS (Fail).
        colormap(ax, flipud(turbo));
    else
        % For Stress: Red should be HIGH (Hot), Blue LOW (Cool)
        % Standard Turbo works: Red is High.
        colormap(ax, turbo);
    end
    
    % Annotate Failures (MoS < 0)
    if isMoS
        fails = find(C_vec < 0);
        if ~isempty(fails)
            % Plot X markers on failed elements
            failX = mean(X(:, fails), 1);
            failY = mean(Y(:, fails), 1);
            plot(ax, failX, failY, 'rx', 'MarkerSize', 10, 'LineWidth', 2);
            text(ax, mean(failX), mean(failY)+0.05, 'FAIL', 'Color', 'r', 'HorizontalAlignment', 'center');
        end
    end
    
    % Cleanup
    xlabel(ax, 'x (m)'); ylabel(ax, 'z (m)');
end