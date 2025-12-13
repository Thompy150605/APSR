function wall = findW(w,point1,point2)
wall = Wall.empty();

for i=1:size(w,1)
   if (w(i).point1 == point1 && w(i).point2 == point2) || (w(i).point1 == point2 && w(i).point2 == point1)
      wall = w(i); 
   end
end

if length(wall) == 0
   error('tidak ada wall dari point %s ke point %s',point1.name,point2.name) 
end

end