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
    
    

%         if w(i).MoSTresca < 0
%            fail = true;
%            Stat(i,1) = 'Fail';
%         else
%            Stat(i,1) = 'Safe';
%         end
        Mate(i) = w(i).material;
        thicc(i) = w(i).t;
    end
    
    if fail == true
       warning('Struktur fail: Tresca Criterion') 
    end
    
    MoSCompile = [w.name ;thicc; Mate.name ; w.sigma ; w.tau ; w.MoSTresca ; w.MoSBuckle ]';
    MoStable = array2table(MoSCompile, 'VariableNames',{'Wall','Skin thickness','Material','Normal Stress (MPa)','Shear Stress (MPa)','MoS Von Misces','MoSBuckle'});
  
    fig = uifigure("Position",[500 500 760 360]);
    MoStableUI =  uitable(fig,"Data",MoStable,"Position",[20 20 720 320]);
    safe_back = uistyle("BackgroundColor","green");


if fail == true
   warning('Struktur fail: Tresca Criterion') 
end