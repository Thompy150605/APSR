%compressive buckle di skin + stiffener (ESDU 71014)
%edit sesuai ESDU, default 4

    %{
    %kasus 1
    for i = 1:length(w)%t = 2
       K(i) = 5.15; 
    end
    for i = 3:7 %t = 2.1
       K(i) = 5.05;
    end
    for i = 19:23 %t = 2.2
       K(i) = 4.95;
    end71014
    for i = [1:2 24:27] %1.8
       K(i) = 5.28;
    end
    %}
    
    %kasus 2
%     for i = 1:length(w)%t = 2
%        K(i,j) = 5.45; 
%     end
%     for i = [1:2 15:17] %t = 1.5
%        K(i,j) = 5.75;
%     end

    for j = 1:length(c_section)
        for i = 1:((height(w(:,j))/2))
            K(i,j)=Kbuckle(1,j);
        end
        for i = ((height(w(:,j))/2)+1):(height(w(:,j)))
            K(i,j)=Kbuckle(2,j);
        end
    end    
    
    %{
    %kasus 3
    for i = 1:length(w)%t = 2
       K(i) = 4.25; 
    end
    %}
for j = 1:length(c_section)
    for i = 1:height(w(:,j))
            w(i,j).sigmaCrit = K(i,j)*w(i,j).material.E*(w(i,j).t/w(i,j).length/1000)^2*10^3;
            %fprintf('Wall %s normal stress critnya %.2f MPa\n',w(i).name,w(i).sigmaCrit)

    end
end
