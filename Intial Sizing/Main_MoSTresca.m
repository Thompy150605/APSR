%semua satuan MPa

fail = false;
for i = 1:length(w)
    sigma_all = w(i).material.sigmaY/1.5;
    if isnan(w(i).sigma) ~= true
        S = sqrt(w(i).sigma^2+3*w(i).tau^2);
        w(i).MoSTresca = sigma_all/S - 1;   
    else
        S = sqrt(3*w(i).tau^2);
        w(i).MoSTresca = sigma_all/S - 1;  
    end
    
    if w(i).MoSTresca < 0
       fail = true; 
    end
end

if fail == true
   warning('Struktur fail: Tresca Criterion') 
end