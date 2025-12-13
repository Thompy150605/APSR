function point = findP(p,name)
point = Point.empty();
for i=1:size(p,1)
   if p(i).name == name
      point = p(i); 
   end
end
if length(point) == 0
   error('tidak ada point bernama %s',name) 
end

end