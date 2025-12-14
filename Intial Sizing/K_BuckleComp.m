function K = K_BuckleComp(a, b)
    % K_BuckleComp Menghitung koefisien buckling kompresi untuk plat flat
    % simply supported (ESDU 71014 / Standard Plate Theory).
    %
    % Input:
    %   a = Panjang panel (Jarak Rib) dalam mm
    %   b = Lebar panel (Jarak Stringer) dalam mm
    
    aspect_ratio = a / b;
    
    % Mencari nilai m (jumlah gelombang) yang meminimalkan K
    % Biasanya m mendekati a/b. Kita cek range integer di sekitar a/b.
    
    m_guess = round(aspect_ratio);
    if m_guess < 1
        m_guess = 1;
    end
    
    % Cek m, m+1, dan 1 (jika aspect ratio kecil) untuk mencari minimum K
    m_candidates = [1, m_guess, m_guess+1];
    K_vals = zeros(1, length(m_candidates));
    
    for i = 1:length(m_candidates)
        m = m_candidates(i);
        K_vals(i) = (m/aspect_ratio + aspect_ratio/m)^2;
    end
    
    K = min(K_vals);
    
    % Batas bawah teoritis untuk a/b -> infinity adalah 4.0
    if K < 4.0
        K = 4.0;
    end
end