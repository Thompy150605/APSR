t = 2;
tmidl = 2.2;
tmidu = 2.1;
tLE = 1.6;
A_st = t*40-2*t^2;
A_sparf = 3*30*4-2*4^2;
p = [Point('s1',c*NACA0008(5,1),Al2024,A_st);%1
    Point('s2',c*NACA0008(10,1),Al2024,A_st);%2
    Point('1',c*NACA0008(15,1),Al2024,A_sparf);%3
    Point('s3',c*NACA0008(21,1),Al2024,A_st);%4
	Point('s4',c*NACA0008(27,1),Al2024,A_st);%5
    Point('s5',c*NACA0008(33,1),Al2024,A_st);%6
    Point('s6',c*NACA0008(39,1),Al2024,A_st);%7
    Point('2',c*NACA0008(45,1),Al2024,A_sparf);%8
    Point('s7',c*NACA0008(51,1),Al2024,A_st);%9
    Point('s8',c*NACA0008(57,1),Al2024,A_st);%10
    Point('s9',c*NACA0008(63,1),Al2024,A_st);%11
    Point('s10',c*NACA0008(69,1),Al2024,A_st);%12
    Point('3',c*NACA0008(75,1),Al2024,A_sparf);%13
    Point('4',c*NACA0008(75,-1),Al2024,A_sparf);%14
    Point('s11',c*NACA0008(69,-1),Al2024,A_st);%15
    Point('s12',c*NACA0008(63,-1),Al2024,A_st);%16
    Point('s13',c*NACA0008(57,-1),Al2024,A_st);%17
    Point('s14',c*NACA0008(51,-1),Al2024,A_st);%18
    Point('5',c*NACA0008(45,-1),Al2024,A_sparf);%19
    Point('s15',c*NACA0008(39,-1),Al2024,A_st);%20
    Point('s16',c*NACA0008(33,-1),Al2024,A_st);%21
    Point('s17',c*NACA0008(27,-1),Al2024,A_st);%22
    Point('s18',c*NACA0008(21,-1),Al2024,A_st);%23
    Point('6',c*NACA0008(15,-1),Al2024,A_sparf);%24
    Point('s19',c*NACA0008(10,-1),Al2024,A_st);%25
    Point('s20',c*NACA0008(5,-1),Al2024,A_st);%26
    Point('0',c*NACA0008(0,1),Al2024,0)];%27
w = [AutoWall(p,Al2024,t);
    Wall('6_1',findP(p,'6'),findP(p,'1'),Al2024,2);
    Wall('2_5',findP(p,'2'),findP(p,'5'),Al2024,2)];
% for i = 3:7
%    w(i).t = tmidu; w(i).area = recalculateArea(w(i));
% end
% for i = 19:23
%    w(i).t = tmidl; w(i).area = recalculateArea(w(i));
% end
% for i = [1:2 24:27]
%    w(i).t = tLE; w(i).area = recalculateArea(w(i));
% end
loop = [Loop([3 4 5 6 7 8 19 20 21 22 23 24],p,w);
    Loop([8 9 10 11 12 13 14 15 16 17 18 19],p,w);
    Loop([1 2 3 24 25 26 27],p,w)];