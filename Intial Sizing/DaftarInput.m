%% 1 cell
p = [Point('1',[-0.5 0.5],Al2024,0);
    Point('2',[0.5 0.5],Al2024,0);
	Point('3',[0.5 -0.5],Al2024,0);
    Point('4',[-0.5 -0.5],Al2024,0)];
w = [Wall('1_2',p(1),p(2),Al2024,1);
    Wall('2_3',p(2),p(3),Al2024,1);
    Wall('3_4',p(3),p(4),Al2024,1);
    Wall('4_1',p(4),p(1),Al2024,1)];
loop = [Loop([1 2 3 4],p,w)];

%% 2 cell
p = [Point('1',[-1 0.5],Al2024,0);
    Point('2',[0 0.5],Al2024,0);
	Point('3',[1 0.5],Al2024,0);
    Point('4',[1 -0.5],Al2024,0);
    Point('5',[0 -0.5],Al2024,0);
    Point('6',[-1 -0.5],Al2024,0)];
w = [Wall('1_2',p(1),p(2),Al2024,1);
    Wall('2_3',p(2),p(3),Al2024,1);
    Wall('3_4',p(3),p(4),Al2024,1);
    Wall('4_5',p(4),p(5),Al2024,1);
    Wall('5_6',p(5),p(6),Al2024,1);
    Wall('6_1',p(6),p(1),Al2024,1);
    Wall('2_5',p(2),p(5),Al2024,1)];
loop = [Loop([1 2 5 6],p,w);
    Loop([2 3 4 5],p,w)];

%% 3 cell
p = [Point('1',[-1.5 0.5],Al2024,0);
    Point('2',[-0.5 0.5],Al2024,0);
	Point('3',[0.5 0.5],Al2024,0);
    Point('4',[1.5 0.5],Al2024,0);
    Point('5',[1.5 -0.5],Al2024,0);
    Point('6',[0.5 -0.5],Al2024,0);
    Point('7',[-0.5 -0.5],Al2024,0);
    Point('8',[-1.5 -0.5],Al2024,0)];
w = [Wall('1_2',p(1),p(2),Al2024,1);
    Wall('2_3',p(2),p(3),Al2024,1);
    Wall('3_4',p(3),p(4),Al2024,1);
    Wall('4_5',p(4),p(5),Al2024,1);
    Wall('5_6',p(5),p(6),Al2024,1);
    Wall('6_7',p(6),p(7),Al2024,1);
    Wall('7_8',p(7),p(8),Al2024,1);
    Wall('8_1',p(8),p(1),Al2024,1);
    Wall('2_7',p(2),p(7),Al2024,1);
    Wall('3_6',p(3),p(6),Al2024,1)];
loop = [Loop([1 2 7 8],p,w);
    Loop([2 3 6 7],p,w);
    Loop([3 4 5 6],p,w)];

%% 4 cell
p = [Point('1',[-2 0.5],Al2024,0);
    Point('2',[-1 0.5],Al2024,0);
	Point('3',[0 0.5],Al2024,0);
    Point('4',[1 0.5],Al2024,0);
    Point('5',[2 0.5],Al2024,0);
    Point('6',[2 -0.5],Al2024,0);
    Point('7',[1 -0.5],Al2024,0);
    Point('8',[0 -0.5],Al2024,0);
    Point('9',[-1 -0.5],Al2024,0);
    Point('10',[-2 -0.5],Al2024,0)];
w = [Wall('1_2',p(1),p(2),Al2024,1);
    Wall('2_3',p(2),p(3),Al2024,1);
    Wall('3_4',p(3),p(4),Al2024,1);
    Wall('4_5',p(4),p(5),Al2024,1);
    Wall('5_6',p(5),p(6),Al2024,1);
    Wall('6_7',p(6),p(7),Al2024,1);
    Wall('7_8',p(7),p(8),Al2024,1);
    Wall('8_9',p(8),p(9),Al2024,1);
    Wall('9_10',p(9),p(10),Al2024,1);
    Wall('10_1',p(10),p(1),Al2024,1);
    Wall('2_9',p(2),p(9),Al2024,1);
    Wall('3_8',p(3),p(8),Al2024,1);
    Wall('4_7',p(4),p(7),Al2024,1)];
loop = [Loop([1 2 9 10],p,w);
    Loop([2 3 8 9],p,w);
    Loop([3 4 7 8],p,w);
    Loop([4 5 6 7],p,w)];

%% 5 cell
p = [Point('1',[-2.5 0.5],Al2024,0);
    Point('2',[-1.5 0.5],Al2024,0);
	Point('3',[-0.5 0.5],Al2024,0);
    Point('4',[0.5 0.5],Al2024,0);
    Point('5',[1.5 0.5],Al2024,0);
    Point('6',[2.5 0.5],Al2024,0);
    Point('7',[2.5 -0.5],Al2024,0);
    Point('8',[1.5 -0.5],Al2024,0);
    Point('9',[0.5 -0.5],Al2024,0);
    Point('10',[-0.5 -0.5],Al2024,0);
    Point('11',[-1.5 -0.5],Al2024,0);
    Point('12',[-2.5 -0.5],Al2024,0)];
w = [Wall('1_2',p(1),p(2),Al2024,1);
    Wall('2_3',p(2),p(3),Al2024,1);
    Wall('3_4',p(3),p(4),Al2024,1);
    Wall('4_5',p(4),p(5),Al2024,1);
    Wall('5_6',p(5),p(6),Al2024,1);
    Wall('6_7',p(6),p(7),Al2024,1);
    Wall('7_8',p(7),p(8),Al2024,1);
    Wall('8_9',p(8),p(9),Al2024,1);
    Wall('9_10',p(9),p(10),Al2024,1);
    Wall('10_11',p(10),p(11),Al2024,1);
    Wall('11_12',p(11),p(12),Al2024,1);
    Wall('12_1',p(12),p(1),Al2024,1);
    Wall('2_11',p(2),p(11),Al2024,1);
    Wall('3_10',p(3),p(10),Al2024,1);
    Wall('4_9',p(4),p(9),Al2024,1);
    Wall('5_8',p(5),p(8),Al2024,1)];
loop = [Loop([1 2 11 12],p,w);
    Loop([2 3 10 11],p,w);
    Loop([3 4 9 10],p,w);
    Loop([4 5 8 9],p,w);
    Loop([5 6 7 8],p,w)];
%% Save Thompy Config

DaftarMaterial
if exist('c','var') == false
   c = 1.869;
end

% --- Thickness Inputs (from Image) ---
t_skin  = 5.00;   % Skin Thickness (t_s)
t_spar  = 3.27;   % Spar Web Thickness
t_le    = 5.00;   % Leading Edge Thickness (Assumed same as skin)

% Set 't' variable for AutoWall function
t = t_skin; 

% --- 1. Stringer Area Calculation ---
% Formula used: Area = Height * Thickness (Blade Stringer assumption matches the value)
h_st = 62.19;  % Stringer Height
w_st = 24.87;  % Stringer Width (defined but not used in Area calc to match 310.95)
t_st = 5.00;   % Stringer Thickness

% Calculate A_st
A_st = h_st * t_st; 
% Check: 62.19 * 5 = 310.95 mm^2

% --- 2. Front Spar Cap Area Calculation ---
w_f_cap = 127.46; % Front Spar Flange Width
t_f_cap = 4.46;   % Spar Flange Thickness

% Calculate A_sparf
A_sparf = w_f_cap * t_f_cap;
% Check: 127.46 * 4.46 = 568.47 mm^2


% --- 3. Rear Spar Cap Area Calculation ---
% Keeping previous width (61.14) but updating thickness to match flange thickness.
w_r_cap = 61.14;  % Rear Spar Flange Width (Previous value)
t_r_cap = t_f_cap;   % Rear Spar Flange Thickness (Matches t_f)

% Calculate A_sparr
A_sparr = w_r_cap * t_r_cap;
% Check: 61.14 * 4.46 = 272.68 mm^2

% --- DEFINISI TITIK (POINTS) ---
% Urutan SANGAT PENTING untuk AutoWall:
% Mulai dari Front Spar Atas -> ke Belakang -> Rear Spar Bawah -> ke Depan
p = [ ...
    % 1. Front Spar Upper (20%)
    Point('1', c * NACA63415(20, 1), Al2024, A_sparf);
    
    % Stringers Atas (25% - 70%)
    Point('s1', c * NACA63415(25, 1), Al2024, A_st);
    Point('s2', c * NACA63415(30, 1), Al2024, A_st);
    Point('s3', c * NACA63415(35, 1), Al2024, A_st);
    Point('s4', c * NACA63415(40, 1), Al2024, A_st);
    Point('s5', c * NACA63415(45, 1), Al2024, A_st);
    Point('s6', c * NACA63415(50, 1), Al2024, A_st);
    Point('s7', c * NACA63415(55, 1), Al2024, A_st);
    Point('s8', c * NACA63415(60, 1), Al2024, A_st);
    Point('s9', c * NACA63415(65, 1), Al2024, A_st);
    Point('s10',c * NACA63415(70, 1), Al2024, A_st);
    
    % 2. Rear Spar Upper (75%)
    Point('2', c * NACA63415(75, 1), Al2024, A_sparr);
    
    % 3. Rear Spar Lower (75%)
    % Note: Use -1 for Lower Surface
    Point('3', c * NACA63415(75, -1), Al2024, A_sparr);
    
    % Stringers Bawah (70% - 25%) -> Mundur ke depan
    Point('s11',c * NACA63415(70, -1), Al2024, A_st);
    Point('s12',c * NACA63415(65, -1), Al2024, A_st);
    Point('s13',c * NACA63415(60, -1), Al2024, A_st);
    Point('s14',c * NACA63415(55, -1), Al2024, A_st);
    Point('s15',c * NACA63415(50, -1), Al2024, A_st);
    Point('s16',c * NACA63415(45, -1), Al2024, A_st);
    Point('s17',c * NACA63415(40, -1), Al2024, A_st);
    Point('s18',c * NACA63415(35, -1), Al2024, A_st);
    Point('s19',c * NACA63415(30, -1), Al2024, A_st);
    Point('s20',c * NACA63415(25, -1), Al2024, A_st);
    
    % 4. Front Spar Lower (20%)
    Point('4', c * NACA63415(20, -1), Al2024, A_sparf);
    
    % 5. Leading Edge Points (Nose)
    % REORDERED for AutoWall continuity: (Lower -> Tip -> Upper)
    % This ensures p(24) connects to p(25) smoothly without crossing.
    Point('n_l', c * NACA63415(10, -1), Al2024, A_st); % 25. Nose Lower
    Point('0',   c * NACA63415(0, 1),   Al2024, 0);    % 26. Tip
    Point('n_u', c * NACA63415(10, 1),  Al2024, A_st); % 27. Nose Upper
];

% --- DEFINISI WALL (Gaya Baru) ---
% 1. AutoWall untuk Skin (Menghubungkan semua p secara berurutan)
%    Ini otomatis membuat dinding dari P12(RS_Up) ke P13(RS_Low).
w = [AutoWall(p, Al2024, t_skin)]; 

% 2. UPDATE REAR SPAR WEB (Alih-alih membuat baru)
%    Wall ke-12 adalah penghubung RS Upper (12) ke RS Lower (13).
%    Kita ubah propertinya agar menjadi web (tebal t_spar).
w(12).t = t_spar;
w(12).name = 'rear_web';

% 3. TAMBAHKAN FRONT SPAR WEB (Manual)
%    Front Spar Web perlu manual karena AutoWall di depan melingkar ke Nose.
%    Kita hubungkan FS Lower (4) ke FS Upper (1).
w = [w; Wall('front_web', findP(p,'4'), findP(p,'1'), Al2024, t_spar)];

% CEK LOGIKA SOLVER:
% Total Wall = 27 (AutoWall) + 1 (FS Web) = 28 walls.
% Total Point = 27 points.
% Selisih = 28 - 27 = 1 persamaan twist.
% Jumlah Loop = 2 (Main Box + Nose).
% 2 Loop butuh 1 persamaan kompatibilitas (Loop 1 vs Loop 2). -> PAS!

% --- DEFINISI LOOP (CELL) ---
% Loop 1: Main Box (P1...P24)
% Loop class akan mencari wall yang menghubungkan titik-titik ini.
% Wall 12 (Rear Web) dan Wall 28 (Front Web) akan otomatis terpakai.
loop1_indices = [1:24]; 

% Loop 2: Leading Edge / Nose (P24, P25, P26, P27, P1)
% Menggunakan Front Web (P24->P1) sebagai penutup.
loop2_indices = [24, 25, 26, 27, 1];

loop = [
    Loop(loop1_indices, p, w);
    Loop(loop2_indices, p, w)
];

% Visualisasi
close all; figure; hold on;
for i=1:length(p), p(i).plot(); end
for i=1:length(w), w(i).plot(); end
axis equal; grid on;

% h1, h2, w value
% 1. Retrieve the Spar Points
% We find the point objects by their names
fs_u_pt = findP(p, '1'); % Front Spar Upper
fs_l_pt = findP(p, '4'); % Front Spar Lower
rs_u_pt = findP(p, '2'); % Rear Spar Upper
rs_l_pt = findP(p, '3'); % Rear Spar Lower

% 2. Calculate Dimensions
% Assumption: Your Point class uses .x and .y for coordinates
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