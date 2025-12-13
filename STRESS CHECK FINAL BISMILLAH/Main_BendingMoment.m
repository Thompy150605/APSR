for j = 1:length(c_section)
    ymax = max([p(:,j).y]-ycd(j));
    ymin = min([p(:,j).y]-ycd(j));
    M = M_section(1,j);
    for i = 1:length(p)
        p(i,j).sigma = -M*(p(i,j).y-ycd(j))/Iy(j)*10^-6; % dalam MPa
        %fprintf('Point %s normal stress %.2f MPa\n',p(i).name,p(i).sigma)
    end
    
    %masukkan ke wall
    for i = 1:length(w)
        if w(i,j).point1.sigma*w(i,j).point2.sigma >= 0
            if abs(w(i,j).point1.sigma) > abs(w(i,j).point2.sigma)
                w(i,j).sigma = w(i,j).point1.sigma;
            else
                w(i,j).sigma = w(i,j).point2.sigma;
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
end