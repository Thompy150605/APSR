%semua satuan MPa

for j = 1:length(c_section)
    fail = false;
    Stat = {};
    for i = 1:length(w(:,j))
        sigma_all = w(i,j).material.sigmaY/1.5;
        if isnan(w(i,j).sigma) ~= true
            S = sqrt(w(i,j).sigma^2+3*w(i,j).tau^2);
            w(i,j).MoSTresca = sigma_all/S - 1;   
        else
            S = sqrt(3*w(i,j).tau^2);
            w(i,j).MoSTresca = sigma_all/S - 1;  
        end
        
    end
    
    if fail == true
       warning('Struktur fail: Von Mises Criterion') 
    end

end