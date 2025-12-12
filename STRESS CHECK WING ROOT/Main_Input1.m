DaftarMaterial
if exist('c','var') == false
   c = 1.447;
end
tu = 1.13;
tl = 1.13;
tLE = 0;
A_ust = 1.13*(18.06+(2*7.22));
A_lst = 1.13*(18.06+(2*7.22));
A_fsparf =3.39*186.5;
A_rsparf = 3.39*87.5;
Npanel = 7;


p = [Point('1',c*NACA63415(20,1),Al7075,A_fsparf);   % Upper front spar
    Point('2',c*NACA63415((20+(1*55/Npanel)),1),Al7075,A_ust);   % S
    Point('3',c*NACA63415((20+(2*55/Npanel)),1),Al7075,A_ust);    % S
    Point('4',c*NACA63415((20+(3*55/Npanel)),1),Al7075,A_ust);   % S
    Point('5',c*NACA63415((20+(4*55/Npanel)),1),Al7075,A_ust);    % S
    Point('6',c*NACA63415((20+(5*55/Npanel)),1),Al7075,A_ust);   % S
    Point('7',c*NACA63415((20+(6*55/Npanel)),1),Al7075,A_ust);    % S
    Point('8',c*NACA63415(75,1),Al7075,A_rsparf);    % Upper rear spar
    Point('9',c*NACA63415(75,-1),Al7075,A_rsparf);   % Lower front spar
    Point('10',c*NACA63415((20+(6*55/Npanel)),-1),Al7075,A_lst);   % S
    Point('11',c*NACA63415((20+(5*55/Npanel)),-1),Al7075,A_lst);  % S
    Point('12',c*NACA63415((20+(4*55/Npanel)),-1),Al7075,A_lst);   % S
    Point('13',c*NACA63415((20+(3*55/Npanel)),-1),Al7075,A_lst); % S
    Point('14',c*NACA63415((20+(2*55/Npanel)),-1),Al7075,A_lst);  % S
    Point('15',c*NACA63415((20+(1*55/Npanel)),-1),Al7075,A_lst); % S
    Point('16',c*NACA63415(20,-1),Al7075,A_fsparf);]; % Lower front spar
w = [Wall('1_2',findP(p,'1'),findP(p,'2'),Al2024,0.58); 
    Wall('2_3',findP(p,'2'),findP(p,'3'),Al2024,tu);
    Wall('3_4',findP(p,'3'),findP(p,'4'),Al2024,tu);
    Wall('4_5',findP(p,'4'),findP(p,'5'),Al2024,tu);
    Wall('5_6',findP(p,'5'),findP(p,'6'),Al2024,tu);
    Wall('6_7',findP(p,'6'),findP(p,'7'),Al2024,tu);
    Wall('7_8',findP(p,'7'),findP(p,'8'),Al2024,tu);
    Wall('8_9',findP(p,'8'),findP(p,'9'),Al7075,1.74);%rspar
    Wall('9_10',findP(p,'9'),findP(p,'10'),Al7075,tl);
    Wall('10_11',findP(p,'10'),findP(p,'11'),Al7075,tl);
    Wall('11_12',findP(p,'11'),findP(p,'12'),Al7075,tl);
    Wall('12_13',findP(p,'12'),findP(p,'13'),Al7075,tl);
    Wall('13_14',findP(p,'13'),findP(p,'14'),Al7075,tl);
    Wall('14_15',findP(p,'14'),findP(p,'15'),Al7075,tl);
    Wall('15_16',findP(p,'15'),findP(p,'16'),Al7075,tl);
    Wall('16_1',findP(p,'16'),findP(p,'1'),Al7075,1.74);];%fspar


loop = [Loop([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16],p,w)];
  

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