DaftarMaterial
if exist('c','var') == false
   c = 2.635744312;
end

% --- Thickness Inputs ---
t_skin  = 2.3;   % Skin Thickness
t_spar  = 2.5;   % Spar Web Thickness

% Set 't' for AutoWall default
t = t_skin; 

% --- Area Definitions ---
% 1. Stringer Area
h_st = 62.19; t_st = 2;
A_st = h_st * t_st; 

% 2. Front Spar Cap Area
w_f_cap = 127.46; t_f_cap = 4.46;
A_sparf = w_f_cap * t_f_cap;

% 3. Rear Spar Cap Area
w_r_cap = 61.14; t_r_cap = 4.46;
A_sparr = w_r_cap * t_r_cap;

x_locs = linspace(20, 75, 14); 

% x_locs(1) is Front Spar (20)
% x_locs(14) is Rear Spar (75)
% x_locs(2:13) are the 12 Stringers
str_loc = x_locs(2:13); 

% --- DEFINISI TITIK (POINTS) - 12 STRINGERS (MUST DEFINE YOURSELF) ---
p = [ ...
    % 1. Front Spar Upper (20%)
    Point('1', c * NACA63415(20, 1), Al7075, A_sparf);
    
    % --- 12 UPPER STRINGERS ---
    Point('s1_u',  c * NACA63415(str_loc(1), 1), Al7075, A_st);
    Point('s2_u',  c * NACA63415(str_loc(2), 1), Al7075, A_st);
    Point('s3_u',  c * NACA63415(str_loc(3), 1), Al7075, A_st);
    Point('s4_u',  c * NACA63415(str_loc(4), 1), Al7075, A_st);
    Point('s5_u',  c * NACA63415(str_loc(5), 1), Al7075, A_st);
    Point('s6_u',  c * NACA63415(str_loc(6), 1), Al7075, A_st);
    Point('s7_u',  c * NACA63415(str_loc(7), 1), Al7075, A_st);
    Point('s8_u',  c * NACA63415(str_loc(8), 1), Al7075, A_st);
    Point('s9_u',  c * NACA63415(str_loc(9), 1), Al7075, A_st);
    Point('s10_u', c * NACA63415(str_loc(10), 1), Al7075, A_st);
    Point('s11_u', c * NACA63415(str_loc(11), 1), Al7075, A_st);
    Point('s12_u', c * NACA63415(str_loc(12), 1), Al7075, A_st);
    
    % 2. Rear Spar Upper (75%)
    Point('2', c * NACA63415(75, 1), Al7075, A_sparr);
    
    % 3. Rear Spar Lower (75%)
    Point('3', c * NACA63415(75, -1), Al7075, A_sparr);
    
    % --- 12 LOWER STRINGERS (Urutan Mundur: Rear -> Front) ---
    Point('s12_l', c * NACA63415(str_loc(12), -1), Al2024, A_st);
    Point('s11_l', c * NACA63415(str_loc(11), -1), Al2024, A_st);
    Point('s10_l', c * NACA63415(str_loc(10), -1), Al2024, A_st);
    Point('s9_l',  c * NACA63415(str_loc(9), -1), Al2024, A_st);
    Point('s8_l',  c * NACA63415(str_loc(8), -1), Al2024, A_st);
    Point('s7_l',  c * NACA63415(str_loc(7), -1), Al2024, A_st);
    Point('s6_l',  c * NACA63415(str_loc(6), -1), Al2024, A_st);
    Point('s5_l',  c * NACA63415(str_loc(5), -1), Al2024, A_st);
    Point('s4_l',  c * NACA63415(str_loc(4), -1), Al2024, A_st);
    Point('s3_l',  c * NACA63415(str_loc(3), -1), Al2024, A_st);
    Point('s2_l',  c * NACA63415(str_loc(2), -1), Al2024, A_st);
    Point('s1_l',  c * NACA63415(str_loc(1), -1), Al2024, A_st);
    
    % 4. Front Spar Lower (20%)
    Point('4', c * NACA63415(20, -1), Al7075, A_sparf);
];

% --- DEFINISI WALL (Single Cell) ---
w = [AutoWall(p, Al2024, t_skin)]; 

% Update Thickness for Spar Webs
% LOGIKA INDEKS BARU (12 Stringers):
% Urutan P: 
% 1 (FS_U) 
% + 12 Stringers (Index 2-13) 
% + 1 (RS_U / Index 14)
% 
% Wall ke-14 menghubungkan Point 14 (RS_U) ke Point 15 (RS_L).
w(14).t = t_spar; 
w(14).name = 'rear_web';

% Wall Terakhir (end): Menghubungkan Point Terakhir (FS_L) ke Point Awal (FS_U)
w(end).t = t_spar;
w(end).name = 'front_web';

% --- DEFINISI LOOP (CELL) ---
% Single Loop containing all points
loop = [
    Loop(1:length(p), p, w)
];

% Visualisasi
close all
figure(1)
hold on
for i=1:length(p) %untuk point
    p(i).plot();
    nameText = p(i).plotText(p(i).name);
    nameText.FontSize = 12;
    nameText.FontWeight = 'bold';
end
for i=1:length(w) %untuk wall
    w(i).plot();
end
axis equal
grid on

%% h1, h2, w value
% 1. Retrieve the Spar Points
% We find the point objects by their names
fs_u_pt = findP(p, '1'); % Front Spar Upper
fs_l_pt = findP(p, '4'); % Front Spar Lower
rs_u_pt = findP(p, '2'); % Rear Spar Upper
rs_l_pt = findP(p, '3'); % Rear Spar Lower

% 2. Calculate Dimensions
% h1 = Front Spar Height (Vertical distance)
h1 = fs_u_pt.y - fs_l_pt.y;

% h2 = Rear Spar Height (Vertical distance)
h2 = rs_u_pt.y - rs_l_pt.y;

% w = Width (Horizontal distance between Rear Spar and Front Spar)
width_box = rs_u_pt.x - fs_u_pt.x;

% 3. Print Results
fprintf('\n=================================================\n');
fprintf('WING BOX DIMENSION REPORT (Chord = %.2f mm)\n', c);
fprintf('=================================================\n');
fprintf('h1 (Front Spar Height) : %.4f mm\n', h1);
fprintf('h2 (Rear Spar Height)  : %.4f mm\n', h2);
fprintf('w  (Spar Width)        : %.4f mm\n', width_box);
fprintf('-------------------------------------------------\n');
fprintf('Coordinates Check:\n');
fprintf('FS Upper (1) : (%.2f, %.2f)\n', fs_u_pt.x, fs_u_pt.y);
fprintf('FS Lower (4) : (%.2f, %.2f)\n', fs_l_pt.x, fs_l_pt.y);
fprintf('RS Upper (2) : (%.2f, %.2f)\n', rs_u_pt.x, rs_u_pt.y);
fprintf('RS Lower (3) : (%.2f, %.2f)\n', rs_l_pt.x, rs_l_pt.y);
fprintf('=================================================\n');