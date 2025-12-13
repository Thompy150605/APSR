%semua satuan MPa. Pakai relasi Rs^2 + Rc = 1
for j = 1:length(c_section)
for i = 1:height(w(:,j))
    if isnan(w(i,j).sigma) ~= true && w(i,j).sigma < 0
        Rs = w(i,j).tau/w(i,j).tauCrit*1.5;
        Rc = -w(i,j).sigma/w(i,j).sigmaCrit*1.5;
        m = Rc/Rs;
        OA = sqrt(Rs^2+Rc^2);
        OB = 0.5*(sqrt(m^2+4)-m)*sqrt(m^2+1);
        w(i,j).MoSBuckle = OB/OA - 1;    
    else %untuk spar (cuma ada shear) dan tension
        sigma_all = w(i,j).tauCrit/1.5;
        S = w(i,j).tau;
        w(i,j).MoSBuckle = sigma_all/S - 1;  
    end        
    
    if w(i,j).MoSBuckle < 0
       fail = true; 
    end
end


end