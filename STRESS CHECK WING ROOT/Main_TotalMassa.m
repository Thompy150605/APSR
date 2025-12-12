M = 0; %dalam kg
for i = 1:length(p)
    M = M + p(i).area*10^-6*p(i).material.rho;
end
for i = 1:length(w)
    M = M + w(i).area*10^-6*w(i).material.rho;
end

fprintf('Total massa %0.2f kg/m\n',M)