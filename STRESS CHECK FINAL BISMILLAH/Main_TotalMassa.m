for j = 1:length(c_section)
M(1,j) = 0; %dalam kg
for i = 1:height(p(:,j))
    M(1,j) = M(1,j) + p(i,j).area*10^-6*p(i,j).material.rho;
end
for i = 1:height(w(:,j))
    M(1,j) = M(1,j) + w(i,j).area*10^-6*p(i,j).material.rho;
end

fprintf('Total massa %0.2f kg/m\n',M)
end