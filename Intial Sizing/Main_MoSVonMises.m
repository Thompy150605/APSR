% Perhitungan MoS menggunakan Von Mises Criterion
% Rumus: Sigma_VM = sqrt(sigma^2 + 3*tau^2)
% Semua satuan MPa

% MoS Calculation
fail = false;
clear Mate thicc 

% Coba Tresca Masuk
for z = 1:length(w)
    sigma_all = w(z).material.sigmaY/1.5;
    if isnan(w(z).sigma) ~= true
        S = sqrt(w(z).sigma^2 + 4*w(z).tau^2); 
        w(z).MoSTresca = sigma_all/S - 1;   
    else
        S = sqrt(4*w(z).tau^2); 
        w(z).MoSTresca = sigma_all/S - 1;  
    end
    
    if w(z).MoSTresca < 0
       fail = true; 
    end
end

for k = 1:length(w)
    % 1. Allowable Stress
    sigma_all = w(k).material.sigmaY / 1.5;
    
    % 2. Von Mises Equivalent Stress: S = sqrt(sigma^2 + 3*tau^2)
    if ~isnan(w(k).sigma)
        S = sqrt(w(k).sigma^2 + 3*w(k).tau^2);
    else
        % If only shear exists (e.g. spar webs)
        S = sqrt(3*w(k).tau^2);
    end
    
    % 3. Margin of Safety
    w(k).MoSVonMises = sigma_all/S - 1;
    
    % 4. Check Failure
    if w(k).MoSVonMises < 0
       fail = true;
    end
    
    % Collect Data for Table
    Mate(k) = w(k).material;
    thicc(k) = w(k).t;
end

% --- Generate Table ---
MoSCompile = [w.name; thicc; Mate.name; w.sigma; w.tau; w.MoSVonMises; w.MoSTresca; w.MoSBuckle]';
MoStable = array2table(MoSCompile, 'VariableNames', ...
    {'Wall','Thickness','Material','Normal(MPa)','Shear(MPa)','MoS_VonMises','MoS_Tresca','MoS_Buckle'});

% --- Display Figure ---
fig = uifigure("Name", "Result: Von Mises", "Position", [550 450 800 400]); % Slightly wider for extra column

lbl = uilabel(fig);
if exist('loc_name', 'var')
    lbl.Text = ['Results (Von Mises): ' loc_name]; 
else
    lbl.Text = 'Structure Analysis Results (Von Mises)';
end
lbl.FontSize = 18;
lbl.FontWeight = 'bold';
lbl.HorizontalAlignment = 'center';
lbl.Position = [20, 360, 760, 30]; % Top of the window

MoStableUI = uitable(fig, "Data", MoStable, "Position", [20 20 760 330]);

% --- Warnings ---
if fail
   warning('Structure failure detected (Von Mises Criterion). Check tables for details.') 
end

if any([w.MoSBuckle] < 0)
   warning('Structure failure detected (Buckling). Check tables for details.') 
end