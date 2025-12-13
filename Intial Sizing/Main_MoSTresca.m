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
    MoStable = array2table(MoSCompile, 'VariableNames',{'Wall','Skin thickness','Material','Normal Stress (MPa)','Shear Stress (MPa)','MoS Tresca','MoSBuckle'});

    fig = uifigure("Position", [500 500 760 400], "Name", "Analysis Results");
    lbl = uilabel(fig);
    if exist('loc_name', 'var')
        lbl.Text = ['Results: ' loc_name]; 
    else
        lbl.Text = 'Structure Analysis Results';
    end
    lbl.FontSize = 18;
    lbl.FontWeight = 'bold';
    lbl.HorizontalAlignment = 'center';
    lbl.Position = [20, 360, 720, 30];
    MoStableUI =  uitable(fig,"Data",MoStable,"Position",[20 20 720 320]);
    safe_back = uistyle("BackgroundColor","green");


if fail == true
   warning('Struktur fail: Tresca Criterion') 
end

if fail == true
   warning('Struktur fail: Buckle') 
end