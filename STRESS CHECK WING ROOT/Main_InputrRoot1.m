DaftarMaterial
if exist('c','var') == false
   %c = 2.66; % exposed root
    c = 1.85; % pylon 1
end
tu = 1.5;
tl = 1.5;
tLE = 0;
A_ust = 3*(25+2*12.5);
A_lst = 5*(25+2*12.5);
A_fsparf =4*186.5;
A_rsparf = 4*87.5;

p = [Point('1',c*NACA63415(20,1),Al7075,A_fsparf);   % Upper front spar
    Point('2',c*NACA63415(25,1),Al7075,A_ust);   % S
    Point('3',c*NACA63415(30,1),Al7075,A_ust);    % S
    Point('4',c*NACA63415(35,1),Al7075,A_ust);   % S
    Point('5',c*NACA63415(40,1),Al7075,A_ust);    % S
    Point('6',c*NACA63415(45,1),Al7075,A_ust);   % S
    Point('7',c*NACA63415(50,1),Al7075,A_ust);    % S
    Point('8',c*NACA63415(55,1),Al7075,A_ust);    % S
    Point('9',c*NACA63415(60,1),Al7075,A_ust);   % S
    Point('10',c*NACA63415(65,1),Al7075,A_ust);    % S
    Point('11',c*NACA63415(70,1),Al7075,A_ust);    % S
    Point('12',c*NACA63415(75,1),Al7075,A_rsparf);    % Upper rear spar
    Point('13',c*NACA63415(75,-1),Al7075,A_rsparf);   % Lower front spar
    Point('14',c*NACA63415(70,-1),Al7075,A_lst);   % S
    Point('15',c*NACA63415(65,-1),Al7075,A_lst);  % S
    Point('16',c*NACA63415(60,-1),Al7075,A_lst);   % S
    Point('17',c*NACA63415(55,-1),Al7075,A_lst); % S
    Point('18',c*NACA63415(50,-1),Al7075,A_lst);  % S
    Point('19',c*NACA63415(45,-1),Al7075,A_lst); % S
    Point('20',c*NACA63415(40,-1),Al7075,A_lst); % S
    Point('21',c*NACA63415(35,-1),Al7075,A_lst);  % s
    Point('22',c*NACA63415(30,-1),Al7075,A_lst); % S
    Point('23',c*NACA63415(25,-1),Al7075,A_lst); % S
    Point('24',c*NACA63415(20,-1),Al7075,A_fsparf);]; % Lower front spar
w = [Wall('1_2',findP(p,'1'),findP(p,'2'),Al2024,tu); 
    Wall('2_3',findP(p,'2'),findP(p,'3'),Al2024,tu);
    Wall('3_4',findP(p,'3'),findP(p,'4'),Al2024,tu);
    Wall('4_5',findP(p,'4'),findP(p,'5'),Al2024,tu);
    Wall('5_6',findP(p,'5'),findP(p,'6'),Al2024,tu);
    Wall('6_7',findP(p,'6'),findP(p,'7'),Al2024,tu);
    Wall('7_8',findP(p,'7'),findP(p,'8'),Al2024,tu);
    Wall('8_9',findP(p,'8'),findP(p,'9'),Al2024,tu);
    Wall('9_10',findP(p,'9'),findP(p,'10'),Al2024,tu);
    Wall('10_11',findP(p,'10'),findP(p,'11'),Al2024,tu);
    Wall('11_12',findP(p,'11'),findP(p,'12'),Al2024,tu);
    Wall('12_13',findP(p,'12'),findP(p,'13'),Al7075,2);%rspar
    Wall('13_14',findP(p,'13'),findP(p,'14'),Al7075,tl); 
    Wall('14_15',findP(p,'14'),findP(p,'15'),Al7075,tl);
    Wall('15_16',findP(p,'15'),findP(p,'16'),Al7075,tl);
    Wall('16_17',findP(p,'16'),findP(p,'17'),Al7075,tl);
    Wall('17_18',findP(p,'17'),findP(p,'18'),Al7075,tl);
    Wall('18_19',findP(p,'18'),findP(p,'19'),Al7075,tl);
    Wall('19_20',findP(p,'19'),findP(p,'20'),Al7075,tl);
    Wall('20_21',findP(p,'20'),findP(p,'21'),Al7075,tl);
    Wall('21_22',findP(p,'21'),findP(p,'22'),Al7075,tl);
    Wall('22_23',findP(p,'22'),findP(p,'23'),Al7075,tl);
    Wall('23_24',findP(p,'23'),findP(p,'24'),Al7075,tl);
    Wall('24_25',findP(p,'24'),findP(p,'1'),Al7075,2);];%fspar


loop = [Loop([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24],p,w)];
  

%gambar
close all
figure(1)
hold on
for i=1:length(p) %untuk point
    p(i).plot();
    nameText = p(i).plotText(p(i).name);
    nameText.FontSize = 12;
    %nameText.FontWeight = 'bold';
end
for i=1:length(w) %untuk wall
    w(i).plot();
end

axis equal
grid on
