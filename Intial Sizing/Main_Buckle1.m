%compressive buckle di skin + stiffener (ESDU 71014)
%edit sesuai ESDU, default 4

% Define K-factors for [Root, Mid, Tip]
K_vec = [6.12, 5.7, 5]; % Here I use K upper skin because K_upper < K_lower
% Assume that if the upper does not fail, therefore the bottom will not
% fail too

% Determine the current K-factor
% We use 'loc_name' or 'y_location' if available to avoid index confusion,
% otherwise we fallback to 'i'.
idx_section = 1; % Default
if exist('loc_name', 'var')
    if contains(loc_name, 'Root', 'IgnoreCase', true)
        idx_section = 1;
    elseif contains(loc_name, 'Hardpoint 1', 'IgnoreCase', true)
        idx_section = 2;
    elseif contains(loc_name, 'Hardpoint 2', 'IgnoreCase', true)
        idx_section = 3;
    end
elseif exist('i', 'var')
    % Fallback to i, though 'i' might be shadowed by Main_Input_Auto
    idx_section = i;
end

% Ensure index is within bounds (1 to 3)
idx_section = max(1, min(idx_section, length(K_vec)));
Current_K = K_vec(idx_section);

fprintf('   -> Calculating Buckling (K=%.2f)...\n', Current_K);

% Iterate through ALL walls in the CURRENT section (w)
% We use 'k' instead of 'i' to avoid overwriting the Main.m loop variable
for k = 1:length(w)
    
    % Assign Critical Buckling Stress
    % Formula: SigmaCrit = K * E * (t / b)^2 * 10^3
    w(k).sigmaCrit = Current_K * w(k).material.E * (w(k).t / w(k).length / 1000)^2 * 10^3;
    
    % Optional Debug Print
    % fprintf('Wall %d: K=%.2f, SigmaCrit=%.2f MPa\n', k, Current_K, w(k).sigmaCrit);
end