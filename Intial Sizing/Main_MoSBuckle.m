%semua satuan MPa. Pakai relasi Rs^2 + Rc = 1

for i = 1:length(w)
    if isnan(w(i).sigma) ~= true && w(i).sigma < 0
        Rs = w(i).tau/w(i).tauCrit*1.5;
        Rc = -w(i).sigma/w(i).sigmaCrit*1.5;
        m = Rc/Rs;
        OA = sqrt(Rs^2+Rc^2);
        OB = 0.5*(sqrt(m^2+4)-m)*sqrt(m^2+1);
        w(i).MoSBuckle = OB/OA - 1;    
    else %untuk spar (cuma ada shear) dan tension
        sigma_all = w(i).tauCrit/1.5;
        S = w(i).tau;
        w(i).MoSBuckle = sigma_all/S - 1;  
    end        
    
    if w(i).MoSBuckle < 0
       fail = true; 
    end
end

if fail == true
   warning('Struktur fail: Buckle') 
end
