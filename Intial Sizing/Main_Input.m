DaftarMaterial
if exist('c','var') == false
   c = 2.635744312;
end

% --- Thickness Inputs ---
t_skin  = 2.3;   % Skin Thickness (Applied to both Upper and Lower)
t_spar  = 2.5;   % Spar Web Thickness

% Set 't' for reference if needed
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

% --- DEFINISI TITIK (POINTS) - 12 STRINGERS ---
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
    
    % --- 12 LOWER STRINGERS (Reverse Order: Rear -> Front) ---
    % Note: Lower Stringer points set to Al2024 to match skin
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

% --- DEFINISI WALL (MANUAL DEFINITION) ---
% Upper Skin: Al7075 (High Compressive Strength)
% Lower Skin: Al2024 (High Fatigue Resistance/Tension)
% Webs: Al7075 (High Strength)

w = [
    % --- UPPER SKIN (Front to Rear) - Al7075 ---
    Wall('1_s1u',   findP(p,'1'),     findP(p,'s1_u'),  Al7075, t_skin);
    Wall('s1u_s2u', findP(p,'s1_u'),  findP(p,'s2_u'),  Al7075, t_skin);
    Wall('s2u_s3u', findP(p,'s2_u'),  findP(p,'s3_u'),  Al7075, t_skin);
    Wall('s3u_s4u', findP(p,'s3_u'),  findP(p,'s4_u'),  Al7075, t_skin);
    Wall('s4u_s5u', findP(p,'s4_u'),  findP(p,'s5_u'),  Al7075, t_skin);
    Wall('s5u_s6u', findP(p,'s5_u'),  findP(p,'s6_u'),  Al7075, t_skin);
    Wall('s6u_s7u', findP(p,'s6_u'),  findP(p,'s7_u'),  Al7075, t_skin);
    Wall('s7u_s8u', findP(p,'s7_u'),  findP(p,'s8_u'),  Al7075, t_skin);
    Wall('s8u_s9u', findP(p,'s8_u'),  findP(p,'s9_u'),  Al7075, t_skin);
    Wall('s9u_s10u',findP(p,'s9_u'),  findP(p,'s10_u'), Al7075, t_skin);
    Wall('s10u_s11u',findP(p,'s10_u'),findP(p,'s11_u'), Al7075, t_skin);
    Wall('s11u_s12u',findP(p,'s11_u'),findP(p,'s12_u'), Al7075, t_skin);
    Wall('s12u_2',  findP(p,'s12_u'), findP(p,'2'),     Al7075, t_skin);
    
    % --- REAR SPAR WEB - Al7075 ---
    Wall('rear_web', findP(p,'2'),    findP(p,'3'),     Al7075, t_spar);
    
    % --- LOWER SKIN (Rear to Front) - Al2024 ---
    Wall('3_s12l',   findP(p,'3'),     findP(p,'s12_l'), Al2024, t_skin);
    Wall('s12l_s11l',findP(p,'s12_l'), findP(p,'s11_l'), Al2024, t_skin);
    Wall('s11l_s10l',findP(p,'s11_l'), findP(p,'s10_l'), Al2024, t_skin);
    Wall('s10l_s9l', findP(p,'s10_l'), findP(p,'s9_l'),  Al2024, t_skin);
    Wall('s9l_s8l',  findP(p,'s9_l'),  findP(p,'s8_l'),  Al2024, t_skin);
    Wall('s8l_s7l',  findP(p,'s8_l'),  findP(p,'s7_l'),  Al2024, t_skin);
    Wall('s7l_s6l',  findP(p,'s7_l'),  findP(p,'s6_l'),  Al2024, t_skin);
    Wall('s6l_s5l',  findP(p,'s6_l'),  findP(p,'s5_l'),  Al2024, t_skin);
    Wall('s5l_s4l',  findP(p,'s5_l'),  findP(p,'s4_l'),  Al2024, t_skin);
    Wall('s4l_s3l',  findP(p,'s4_l'),  findP(p,'s3_l'),  Al2024, t_skin);
    Wall('s3l_s2l',  findP(p,'s3_l'),  findP(p,'s2_l'),  Al2024, t_skin);
    Wall('s2l_s1l',  findP(p,'s2_l'),  findP(p,'s1_l'),  Al2024, t_skin);
    Wall('s1l_4',    findP(p,'s1_l'),  findP(p,'4'),     Al2024, t_skin);
    
    % --- FRONT SPAR WEB - Al7075 ---
    Wall('front_web', findP(p,'4'),    findP(p,'1'),     Al7075, t_spar);
];


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
fs_u_pt = findP(p, '1'); % Front Spar Upper
fs_l_pt = findP(p, '4'); % Front Spar Lower
rs_u_pt = findP(p, '2'); % Rear Spar Upper
rs_l_pt = findP(p, '3'); % Rear Spar Lower

% 2. Calculate Dimensions
h1 = fs_u_pt.y - fs_l_pt.y;
h2 = rs_u_pt.y - rs_l_pt.y;
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