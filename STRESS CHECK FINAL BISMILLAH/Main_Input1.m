DaftarMaterial
% if exist('c','var') == false
%    c = 2.43; %chord daedalus
% end
tskinu = [1.5 1.5 1.5];   % input thickness upper skin
tskinl = [1.5 1.5 1.5];     % input thcickness lower skin
ts_t = 2;   % input ts/t (stringer/skin)
h = [25 25 25]; % height stringer
d_h = 0.5;  % rasio width/height stringer
d = h*d_h;  % width stringer
sparft = [4 4 4]; % spar flange thickness
fsparfl = [186.5 134 106.48]; % front spar flange length
rsparfl = [87.5 63 49.87]; % rear spar flange length
fsparw = [2 0.85 0.49]; % front spar web thickness
rsparw = [2 0.85 0.49]; % rear spar web thickness
panel = [9 9 9]; % number panel (stringer count +1)
Kbuckle = [6.2 6.15 6.15; 6.2 6.15 6.15]; % K Buckle

for i = 1 : length(c_section)
c = c_section(1,i);    
Npanel = panel(1,i);

tu = tskinu(1,i);
tl = tskinl(1,i);

A_ust = (tu*ts_t)*(h(1,i)+(2*d(1,i))); % kalkulasi upper stringer area
A_lst = (tl*ts_t)*(h(1,i)+(2*d(1,i))); % kalkulasi lower stringer area

A_fsparf = sparft(1,i)*fsparfl(1,i); % kalkulasi front spar flange
A_rsparf = sparft(1,i)*rsparfl(1,i); % kalkulasi rear spar flange

fst = fsparw(1,i); % front spar web
rst = rsparw(1,i); % rear spar web

if i ==1
    % Making the wing box geometry with idealization
p(:,i) = [Point('1',c*NACA63415(20,1),Al7075,A_fsparf);   % Upper front spar
    Point('2',c*NACA63415((20+(1*55/Npanel)),1),Al7075,A_ust);   % S
    Point('3',c*NACA63415((20+(2*55/Npanel)),1),Al7075,A_ust);    % S
    Point('4',c*NACA63415((20+(3*55/Npanel)),1),Al7075,A_ust);   % S
    Point('5',c*NACA63415((20+(4*55/Npanel)),1),Al7075,A_ust);    % S
    Point('6',c*NACA63415((20+(5*55/Npanel)),1),Al7075,A_ust);   % S
    Point('7',c*NACA63415((20+(6*55/Npanel)),1),Al7075,A_ust);    % S
    Point('8',c*NACA63415((20+(7*55/Npanel)),1),Al7075,A_ust);   % S
    Point('9',c*NACA63415((20+(8*55/Npanel)),1),Al7075,A_ust);    % S
    Point('10',c*NACA63415(75,1),Al7075,A_rsparf);    % Upper rear spar
    Point('11',c*NACA63415(75,-1),Al7075,A_rsparf);   % Lower front spar
    Point('12',c*NACA63415((20+(8*55/Npanel)),-1),Al7075,A_lst);   % S
    Point('13',c*NACA63415((20+(7*55/Npanel)),-1),Al7075,A_lst);  % S
    Point('14',c*NACA63415((20+(6*55/Npanel)),-1),Al7075,A_lst);   % S
    Point('15',c*NACA63415((20+(5*55/Npanel)),-1),Al7075,A_lst); % S
    Point('16',c*NACA63415((20+(4*55/Npanel)),-1),Al7075,A_lst);  % S
    Point('17',c*NACA63415((20+(3*55/Npanel)),-1),Al7075,A_lst); % S
    Point('18',c*NACA63415((20+(2*55/Npanel)),-1),Al7075,A_lst);  % S
    Point('19',c*NACA63415((20+(1*55/Npanel)),-1),Al7075,A_lst); % S
    Point('20',c*NACA63415(20,-1),Al7075,A_fsparf);]; % Lower front spar
w(:,i) = [Wall('1_2',findP(p(:,i),'1'),findP(p,'2'),Al2024,tu); 
    Wall('2_3',findP(p(:,i),'2'),findP(p(:,i),'3'),Al2024,tu);
    Wall('3_4',findP(p(:,i),'3'),findP(p(:,i),'4'),Al2024,tu);
    Wall('4_5',findP(p(:,i),'4'),findP(p(:,i),'5'),Al2024,tu);
    Wall('5_6',findP(p(:,i),'5'),findP(p(:,i),'6'),Al2024,tu);
    Wall('6_7',findP(p(:,i),'6'),findP(p(:,i),'7'),Al2024,tu);
    Wall('7_8',findP(p(:,i),'7'),findP(p(:,i),'8'),Al2024,tu);
    Wall('8_9',findP(p(:,i),'8'),findP(p(:,i),'9'),Al2024,tu);
    Wall('9_10',findP(p(:,i),'9'),findP(p(:,i),'10'),Al2024,tu);
    Wall('10_11',findP(p(:,i),'10'),findP(p(:,i),'11'),Al7075,3);%rspar
    Wall('11_12',findP(p(:,i),'11'),findP(p(:,i),'12'),Al7075,tl);
    Wall('12_13',findP(p(:,i),'12'),findP(p(:,i),'13'),Al7075,tl);
    Wall('13_14',findP(p(:,i),'13'),findP(p(:,i),'14'),Al7075,tl);
    Wall('14_15',findP(p(:,i),'14'),findP(p(:,i),'15'),Al7075,tl);
    Wall('15_16',findP(p(:,i),'15'),findP(p(:,i),'16'),Al7075,tl);
    Wall('16_17',findP(p(:,i),'16'),findP(p(:,i),'17'),Al7075,tl);
    Wall('17_18',findP(p(:,i),'17'),findP(p(:,i),'18'),Al7075,tl);
    Wall('18_19',findP(p(:,i),'18'),findP(p(:,i),'19'),Al7075,tl);
    Wall('19_20',findP(p(:,i),'19'),findP(p(:,i),'20'),Al7075,tl);
    Wall('20_1',findP(p(:,i),'20'),findP(p(:,i),'1'),Al7075,3);];%fspar

elseif i ==2
    % Making the wing box geometry with idealization
p(:,i) = [Point('1',c*NACA63415(20,1),Al7075,A_fsparf);   % Upper front spar
    Point('2',c*NACA63415((20+(1*55/Npanel)),1),Al7075,A_ust);   % S
    Point('3',c*NACA63415((20+(2*55/Npanel)),1),Al7075,A_ust);    % S
    Point('4',c*NACA63415((20+(3*55/Npanel)),1),Al7075,A_ust);   % S
    Point('5',c*NACA63415((20+(4*55/Npanel)),1),Al7075,A_ust);    % S
    Point('6',c*NACA63415((20+(5*55/Npanel)),1),Al7075,A_ust);   % S
    Point('7',c*NACA63415((20+(6*55/Npanel)),1),Al7075,A_ust);    % S
    Point('8',c*NACA63415((20+(7*55/Npanel)),1),Al7075,A_ust);   % S
    Point('9',c*NACA63415((20+(8*55/Npanel)),1),Al7075,0);    % S
    Point('10',c*NACA63415(75,1),Al7075,A_rsparf);    % Upper rear spar
    Point('11',c*NACA63415(75,-1),Al7075,A_rsparf);   % Lower front spar
    Point('12',c*NACA63415((20+(8*55/Npanel)),-1),Al7075,0);   % S
    Point('13',c*NACA63415((20+(7*55/Npanel)),-1),Al7075,A_lst);  % S
    Point('14',c*NACA63415((20+(6*55/Npanel)),-1),Al7075,A_lst);   % S
    Point('15',c*NACA63415((20+(5*55/Npanel)),-1),Al7075,A_lst); % S
    Point('16',c*NACA63415((20+(4*55/Npanel)),-1),Al7075,A_lst);  % S
    Point('17',c*NACA63415((20+(3*55/Npanel)),-1),Al7075,A_lst); % S
    Point('18',c*NACA63415((20+(2*55/Npanel)),-1),Al7075,A_lst);  % S
    Point('19',c*NACA63415((20+(1*55/Npanel)),-1),Al7075,A_lst); % S
    Point('20',c*NACA63415(20,-1),Al7075,A_fsparf);]; % Lower front spar
w(:,i) = [Wall('1_2',findP(p(:,i),'1'),findP(p,'2'),Al2024,tu); 
    Wall('2_3',findP(p(:,i),'2'),findP(p(:,i),'3'),Al2024,tu);
    Wall('3_4',findP(p(:,i),'3'),findP(p(:,i),'4'),Al2024,tu);
    Wall('4_5',findP(p(:,i),'4'),findP(p(:,i),'5'),Al2024,tu);
    Wall('5_6',findP(p(:,i),'5'),findP(p(:,i),'6'),Al2024,tu);
    Wall('6_7',findP(p(:,i),'6'),findP(p(:,i),'7'),Al2024,tu);
    Wall('7_8',findP(p(:,i),'7'),findP(p(:,i),'8'),Al2024,tu);
    Wall('8_9',findP(p(:,i),'8'),findP(p(:,i),'9'),Al2024,tu);
    Wall('9_10',findP(p(:,i),'9'),findP(p(:,i),'10'),Al2024,tu);
    Wall('10_11',findP(p(:,i),'10'),findP(p(:,i),'11'),Al7075,3);%rspar
    Wall('11_12',findP(p(:,i),'11'),findP(p(:,i),'12'),Al7075,tl);
    Wall('12_13',findP(p(:,i),'12'),findP(p(:,i),'13'),Al7075,tl);
    Wall('13_14',findP(p(:,i),'13'),findP(p(:,i),'14'),Al7075,tl);
    Wall('14_15',findP(p(:,i),'14'),findP(p(:,i),'15'),Al7075,tl);
    Wall('15_16',findP(p(:,i),'15'),findP(p(:,i),'16'),Al7075,tl);
    Wall('16_17',findP(p(:,i),'16'),findP(p(:,i),'17'),Al7075,tl);
    Wall('17_18',findP(p(:,i),'17'),findP(p(:,i),'18'),Al7075,tl);
    Wall('18_19',findP(p(:,i),'18'),findP(p(:,i),'19'),Al7075,tl);
    Wall('19_20',findP(p(:,i),'19'),findP(p(:,i),'20'),Al7075,tl);
    Wall('20_1',findP(p(:,i),'20'),findP(p(:,i),'1'),Al7075,3);];%fspar

else
    % Making the wing box geometry with idealization
p(:,i) = [Point('1',c*NACA63415(20,1),Al7075,A_fsparf);   % Upper front spar
    Point('2',c*NACA63415((20+(1*55/Npanel)),1),Al7075,0);   % S
    Point('3',c*NACA63415((20+(2*55/Npanel)),1),Al7075,A_ust);    % S
    Point('4',c*NACA63415((20+(3*55/Npanel)),1),Al7075,A_ust);   % S
    Point('5',c*NACA63415((20+(4*55/Npanel)),1),Al7075,A_ust);    % S
    Point('6',c*NACA63415((20+(5*55/Npanel)),1),Al7075,A_ust);   % S
    Point('7',c*NACA63415((20+(6*55/Npanel)),1),Al7075,A_ust);    % S
    Point('8',c*NACA63415((20+(7*55/Npanel)),1),Al7075,A_ust);   % S
    Point('9',c*NACA63415((20+(8*55/Npanel)),1),Al7075,0);    % S
    Point('10',c*NACA63415(75,1),Al7075,A_rsparf);    % Upper rear spar
    Point('11',c*NACA63415(75,-1),Al7075,A_rsparf);   % Lower front spar
    Point('12',c*NACA63415((20+(8*55/Npanel)),-1),Al7075,0);   % S
    Point('13',c*NACA63415((20+(7*55/Npanel)),-1),Al7075,A_lst);  % S
    Point('14',c*NACA63415((20+(6*55/Npanel)),-1),Al7075,A_lst);   % S
    Point('15',c*NACA63415((20+(5*55/Npanel)),-1),Al7075,A_lst); % S
    Point('16',c*NACA63415((20+(4*55/Npanel)),-1),Al7075,A_lst);  % S
    Point('17',c*NACA63415((20+(3*55/Npanel)),-1),Al7075,A_lst); % S
    Point('18',c*NACA63415((20+(2*55/Npanel)),-1),Al7075,A_lst);  % S
    Point('19',c*NACA63415((20+(1*55/Npanel)),-1),Al7075,0); % S
    Point('20',c*NACA63415(20,-1),Al7075,A_fsparf);]; % Lower front spar
w(:,i) = [Wall('1_2',findP(p(:,i),'1'),findP(p,'2'),Al2024,tu); 
    Wall('2_3',findP(p(:,i),'2'),findP(p(:,i),'3'),Al2024,tu);
    Wall('3_4',findP(p(:,i),'3'),findP(p(:,i),'4'),Al2024,tu);
    Wall('4_5',findP(p(:,i),'4'),findP(p(:,i),'5'),Al2024,tu);
    Wall('5_6',findP(p(:,i),'5'),findP(p(:,i),'6'),Al2024,tu);
    Wall('6_7',findP(p(:,i),'6'),findP(p(:,i),'7'),Al2024,tu);
    Wall('7_8',findP(p(:,i),'7'),findP(p(:,i),'8'),Al2024,tu);
    Wall('8_9',findP(p(:,i),'8'),findP(p(:,i),'9'),Al2024,tu);
    Wall('9_10',findP(p(:,i),'9'),findP(p(:,i),'10'),Al2024,tu);
    Wall('10_11',findP(p(:,i),'10'),findP(p(:,i),'11'),Al7075,3);%rspar
    Wall('11_12',findP(p(:,i),'11'),findP(p(:,i),'12'),Al7075,tl);
    Wall('12_13',findP(p(:,i),'12'),findP(p(:,i),'13'),Al7075,tl);
    Wall('13_14',findP(p(:,i),'13'),findP(p(:,i),'14'),Al7075,tl);
    Wall('14_15',findP(p(:,i),'14'),findP(p(:,i),'15'),Al7075,tl);
    Wall('15_16',findP(p(:,i),'15'),findP(p(:,i),'16'),Al7075,tl);
    Wall('16_17',findP(p(:,i),'16'),findP(p(:,i),'17'),Al7075,tl);
    Wall('17_18',findP(p(:,i),'17'),findP(p(:,i),'18'),Al7075,tl);
    Wall('18_19',findP(p(:,i),'18'),findP(p(:,i),'19'),Al7075,tl);
    Wall('19_20',findP(p(:,i),'19'),findP(p(:,i),'20'),Al7075,tl);
    Wall('20_1',findP(p(:,i),'20'),findP(p(:,i),'1'),Al7075,3);];%fspar
end
loop = [Loop([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20],p,w)];

figure(i)
hold on
for j=1:height(p) %untuk point
    p(j,i).plot();
    nameText = p(j,i).plotText(p(j,i).name);
    nameText.FontSize = 12;
    titletext = sprintf('SECTION %d',i);
    title(titletext);
    %nameText.FontWeight = 'bold';
end
for j=1:height(w) %untuk wall
    w(j,i).plot();
end

axis equal
grid on
hold off
end