ymax = max([p.y]-ycd);
ymin = min([p.y]-ycd);
for i = 1:length(p)
    p(i).sigma = -M*(p(i).y-ycd)/Iy*10^-6; % dalam MPa
    %fprintf('Point %s normal stress %.2f MPa\n',p(i).name,p(i).sigma)
end

%masukkan ke wall
for i = 1:length(w)
    if w(i).point1.sigma*w(i).point2.sigma >= 0
        if abs(w(i).point1.sigma) > abs(w(i).point2.sigma)
            w(i).sigma = w(i).point1.sigma;
        else
            w(i).sigma = w(i).point2.sigma;
        end
        %{
    else
        if abs(w(i).point1.sigma) > abs(w(i).point2.sigma)
            w(i).sigma = w(i).point1.sigma;
        else
            w(i).sigma = w(i).point2.sigma;
        end
        %}
    end
end