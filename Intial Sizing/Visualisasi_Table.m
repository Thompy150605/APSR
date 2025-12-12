% Visualisasi_Table.m
% Generates the result table figure. Run this AFTER calculation scripts.

% --- 1. DETERMINE SECTION NAME BASED ON Y_LOCATION ---
% We define the specific y-locations we care about
loc_Root = 0.47045;
loc_HP1  = 2.04;
loc_HP2  = 3.15;
tol = 0.01; % Tolerance for comparison

% Default values
sectTitle = sprintf('Section at y=%.2f', y_location);
currentIdx = 1; % Default position index

if abs(y_location - loc_Root) < tol
    sectTitle = 'Root Exposed';
    currentIdx = 1;
elseif abs(y_location - loc_HP1) < tol
    sectTitle = 'Hardpoint 1';
    currentIdx = 2;
elseif abs(y_location - loc_HP2) < tol
    sectTitle = 'Hardpoint 2';
    currentIdx = 3;
end

% --- 2. EXTRACT DATA FROM 'w' ---
numWalls = length(w);

% Pre-allocate
WallName     = cell(numWalls, 1);
Thickness    = zeros(numWalls, 1);
Material     = cell(numWalls, 1);
NormalStress = zeros(numWalls, 1);
ShearStress  = zeros(numWalls, 1);
MoS_Tresca   = zeros(numWalls, 1);
MoS_Buckle   = zeros(numWalls, 1);

for k = 1:numWalls
    WallName{k}     = w(k).name;
    Thickness(k)    = w(k).t;
    Material{k}     = w(k).material.name;
    NormalStress(k) = w(k).sigma;
    ShearStress(k)  = w(k).tau;
    MoS_Tresca(k)   = w(k).MoSTresca;
    MoS_Buckle(k)   = w(k).MoSBuckle;
end

% --- 3. CREATE TABLE OBJECT ---
ResultTable = table(WallName, Thickness, Material, NormalStress, ShearStress, MoS_Tresca, MoS_Buckle, ...
    'VariableNames', {'Wall', 'Thick_mm', 'Material', 'Normal_MPa', 'Shear_MPa', 'MoS_Tresca', 'MoS_Buckle'});

% --- 4. DISPLAY WINDOW ---
% Calculate Position: Stagger windows so they don't cover each other
% X moves right, Y moves down based on the identified section index
x_pos = 50 + (currentIdx * 50);
y_pos = 600 - (currentIdx * 80); 

% Create Figure
fig = uifigure('Name', ['Results: ' sectTitle], ...
    'Position', [x_pos, y_pos, 780, 400]);

% Add Title Label
lbl = uilabel(fig);
lbl.Text = sectTitle;
lbl.FontSize = 18;
lbl.FontWeight = 'bold';
lbl.HorizontalAlignment = 'center';
lbl.Position = [20, 360, 740, 30]; % Top of window

% Add Table
uit = uitable(fig);
uit.Data = ResultTable;
uit.Position = [20, 20, 740, 330]; % Below label
uit.ColumnWidth = {80, 70, 90, 80, 80, 80, 80};

% --- 5. VISUAL WARNINGS ---
if any(MoS_Tresca < 0)
    warning('Failure (Tresca) at %s', sectTitle);
    s = uistyle('BackgroundColor', [1 0.8 0.8]);
    addstyle(uit, s, 'row', find(MoS_Tresca < 0));
end

if any(MoS_Buckle < 0)
    warning('Failure (Buckle) at %s', sectTitle);
    s2 = uistyle('BackgroundColor', [1 0.9 0.7]);
    addstyle(uit, s2, 'row', find(MoS_Buckle < 0));
end