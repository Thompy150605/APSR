t = 1.5;
A_sparf = 3*20*2-2*2^2;
p = [Point('1',c*NACA0008(15,1),Al2024,A_sparf);%1
    Point('2',c*NACA0008(45,1),Al2024,A_sparf);%2
    Point('3',c*NACA0008(75,1),Al2024,A_sparf);%3
    Point('4',c*NACA0008(75,-1),Al2024,A_sparf);%4
    Point('5',c*NACA0008(45,-1),Al2024,A_sparf);%5
    Point('6',c*NACA0008(15,-1),Al2024,A_sparf);%6
    Point('0',c*NACA0008(0.1,1),Al2024,0)];%7
w = [AutoWall(p,Al2024,t);
    Wall('6_1',findP(p,'6'),findP(p,'1'),Al2024,2);
    Wall('2_5',findP(p,'2'),findP(p,'5'),Al2024,2)];
w(3).t = 2; w(3).area = recalculateArea(w(3));
loop = [Loop([1 2 5 6],p,w);
    Loop([2 3 4 5],p,w);
    Loop([1 6 7],p,w)];