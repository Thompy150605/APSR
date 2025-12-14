% Buckle Compressive (Automated)
% Compressive Buckle Check pada Skin (ESDU 71014)

fprintf('\n--- Calculating Compressive Buckling (Main_Buckle1) ---\n');

% Pastikan L_rib terdefinisi (default dari Main.m biasanya 0.4m)
if exist('L_rib','var') == false
   L_rib = 0.4; % Default 400 mm
   warning('L_rib not found, defaulting to 0.4m');
end

% Konversi L_rib ke mm untuk konsistensi dengan w(i).length (biasanya mm di rumus buckling)
a = L_rib * 1000; 

for j = 1:length(c_section)
    for i = 1:height(w(:,j))
        
        % 1. Identifikasi Lebar Panel (b)
        % w(i).length adalah jarak antar node (lebar panel kulit) dalam Meter
        b = w(i,j).length * 1000; % Convert ke mm
        
        % 2. Hitung K (Compressive) secara Dinamis
        % Gunakan fungsi K_BuckleComp yang baru dibuat
        K_val = K_BuckleComp(a, b);
        
        % Simpan nilai K untuk referensi (opsional)
        w(i,j).K_BuckleComp = K_val; 
        
        % 3. Hitung Tegangan Kritis (Sigma Critical)
        % Rumus: sigma_cr = K * E * (t/b)^2 * conversion_factor
        % (t/b) adalah unitless ratio. E dalam MPa. Result dalam MPa.
        % Perhatikan satuan: w.length dalam meter, w.t dalam mm.
        % Jadi (t / b) = (w.t) / (w.length * 1000)
        
        thickness = w(i,j).t;           % mm
        width     = w(i,j).length * 1000; % mm
        
        w(i,j).sigmaCrit = K_val * w(i,j).material.E * (thickness / width)^2;
        
        % Note: Faktor 10^3 di kode lama anda mungkin karena konversi unit yang tidak konsisten.
        % Jika E dalam MPa (misal 72000), t dalam mm, b dalam mm:
        % sigma_cr = 4.0 * 72000 * (1.8 / 110)^2 = ~77 MPa
        % Pastikan tidak mengalikan 10^3 lagi jika E sudah MPa.
        
        % DEBUG PRINT (Aktifkan jika ingin cek per panel)
        % if j==1 && i < 5
        %    fprintf('Wall %s: a=%.0f, b=%.0f, K=%.2f, SigCrit=%.2f MPa\n', ...
        %        w(i,j).name, a, b, K_val, w(i,j).sigmaCrit);
        % end
    end
end