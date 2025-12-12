function pos = NACA63415(persen, var)
% NACA63415 Returns the [x, y] coordinate for a given percent chord.
% usage: pos = NACA63415(20, 1)   -> Upper surface at 20% chord
%        pos = NACA63415(20, -1)  -> Lower surface at 20% chord
%
% Data Source: NACA 63-415 Selig Format (Provided)

    % --- 1. UPPER SURFACE COORDINATES ---
    % Note: These have been sorted (flipped) to go from 0.0 -> 1.0
    % for proper interpolation.
    upper = [ ...
        0.000000  0.000000;
        0.003000  0.012870;
        0.005250  0.015850;
        0.009910  0.020740;
        0.021980  0.029640;
        0.046600  0.042640;
        0.071470  0.052610;
        0.096470  0.060770;
        0.146690  0.073480;
        0.197050  0.082790;
        0.247500  0.089410;
        0.298000  0.093620;
        0.348520  0.095590;
        0.399050  0.095270;
        0.449550  0.092890;
        0.500000  0.088710;
        0.550390  0.082980;
        0.600700  0.075950;
        0.650930  0.067800;
        0.701060  0.058770;
        0.751090  0.049070;
        0.801020  0.039000;
        0.850850  0.028850;
        0.900590  0.018840;
        0.950280  0.009310;
        1.000000  0.000000;
    ];

    % --- 2. LOWER SURFACE COORDINATES ---
    % These already go from 0.0 -> 1.0 in the source file.
    lower = [ ...
        0.000000  0.000000;
        0.007000 -0.010870;
        0.009750 -0.013050;
        0.015090 -0.016460;
        0.028020 -0.022200;
        0.053400 -0.030000;
        0.078530 -0.035650;
        0.103530 -0.040090;
        0.153310 -0.046560;
        0.202950 -0.050950;
        0.252500 -0.053610;
        0.302000 -0.054740;
        0.351480 -0.054390;
        0.400950 -0.052430;
        0.450450 -0.049090;
        0.500000 -0.044590;
        0.549610 -0.039180;
        0.599300 -0.033110;
        0.649070 -0.026600;
        0.698940 -0.019890;
        0.748910 -0.013270;
        0.799890 -0.007160;
        0.849150 -0.001930;
        0.899410  0.001840;
        0.949720  0.003330;
        1.000000  0.000000;
    ];

    % --- 3. INTERPOLATION ---
    x_req = persen / 100;
    
    % Clamp input to 0-1 range to prevent errors
    x_req = max(0, min(1, x_req));

    if var == 1
        % Upper Surface Interpolation
        y = interp1(upper(:,1), upper(:,2), x_req, 'linear');
    elseif var == -1
        % Lower Surface Interpolation
        y = interp1(lower(:,1), lower(:,2), x_req, 'linear');
    else
        error('Var must be 1 (upper) or -1 (lower)');
    end

    pos = [x_req, y];
end