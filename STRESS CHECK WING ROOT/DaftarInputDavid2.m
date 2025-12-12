t = 1.9;
tLE = 1.5;
A_st = 2*40-2*2^2;
A_sparf = 3*30*4-2*4^2;
p = [Point('s2',c*NACA0008(10,1),Al2024,A_st);%1
    Point('1',c*NACA0008(15,1),Al2024,A_sparf);%2
    Point('s3',c*NACA0008(21,1),Al2024,A_st);%3
    Point('s5',c*NACA0008(33,1),Al2024,A_st);%4
    Point('2',c*NACA0008(45,1),Al2024,A_sparf);%5
    Point('s7',c*NACA0008(51,1),Al2024,A_st);%6
    Point('s9',c*NACA0008(63,1),Al2024,A_st);%7
    Point('3',c*NACA0008(75,1),Al2024,A_sparf);%8
    Point('4',c*NACA0008(75,-1),Al2024,A_sparf);%9
    Point('s12',c*NACA0008(63,-1),Al2024,A_st);%10
    Point('s14',c*NACA0008(51,-1),Al2024,A_st);%11
    Point('5',c*NACA0008(45,-1),Al2024,A_sparf);%12
    Point('s16',c*NACA0008(33,-1),Al2024,A_st);%13
    Point('s18',c*NACA0008(21,-1),Al2024,A_st);%14
    Point('6',c*NACA0008(15,-1),Al2024,A_sparf);%15
    Point('s19',c*NACA0008(10,-1),Al2024,A_st);%16
    Point('0',c*NACA0008(0.1,-1),Al2024,0)];%17
w = [AutoWall(p,Al2024,t);
    Wall('6_1',findP(p,'6'),findP(p,'1'),Al2024,2);
    Wall('2_5',findP(p,'2'),findP(p,'5'),Al2024,2)];
w(8).t = 2; w(8).area = recalculateArea(w(8));
for i = [1 15:17]
   w(i).t = tLE; w(i).area = recalculateArea(w(i));
end
loop = [Loop([2 3 4 5 12 13 14 15],p,w);
    Loop([5 6 7 8 9 10 11 12],p,w);
    Loop([1 2 15 16 17],p,w)];