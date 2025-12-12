function w = AutoWall(p,material,t) %fungsi ini berguna untuk otomatis list semua wall mengelilingi

w= Wall.empty(0,length(p));

for i = 1:length(p)-1
   w(i) = Wall(join([p(i).name '_' p(i+1).name],''),p(i),p(i+1),material,t);
end
w(length(p)) = Wall(join([p(length(p)).name '_' p(1).name],''),p(length(p)),p(1),material,t);

w = w';
end