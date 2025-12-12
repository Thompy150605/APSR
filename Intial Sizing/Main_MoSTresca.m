%semua satuan MPa

fail = false;

for k = 1:length(w)
    % 1. Calculate Allowable Stress
    sigma_all = w(k).material.sigmaY / 1.5;
    
    % 2. Calculate Combined Stress (Von Mises / Tresca)
    if ~isnan(w(k).sigma)
        S = sqrt(w(k).sigma^2 + 3*w(k).tau^2);
    else
        S = sqrt(3*w(k).tau^2);
    end
    
    % 3. Calculate Margin of Safety
    w(k).MoSTresca = sigma_all/S - 1;
    
    % 4. Check Failure
    if w(k).MoSTresca < 0
       fail = true; 
    end
end

if fail
   warning('Structure failure detected (Tresca Criterion). Check tables for details.') 
end