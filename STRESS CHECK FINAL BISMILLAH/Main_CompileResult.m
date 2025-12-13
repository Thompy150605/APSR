for j = 1:length(c_section)
    fail = false;
    Stat = {};
    for i = 1:height(w(:,j))
        if w(i,j).MoSTresca < 0
           fail = true;
           Stat{1,i} = 'Fail';
        elseif w(i,j).MoSBuckle < 0
           fail = true;
           Stat{1,i} = 'Fail';
        else   
           Stat{1,i} = 'Safe';
        end
        Mate(i) = w(i,j).material;
        thicc(i) = w(i,j).t;
    end
    
    MoSCompile = [w(:,j).name ;thicc; Mate.name ; w(:,j).MoSTresca ; w(:,j).MoSBuckle; Stat]';
    MoStable = array2table(MoSCompile, 'VariableNames',{'Wall','Skin thickness','Material','MoS Von Misces','MoS Buckle', 'Status'});
    
    fig = uifigure("Position",[500 500 760 360]);
    fig.Name = ("Section "+j);
    MoStableUI =  uitable(fig,"Data",MoStable,"Position",[20 20 720 320]);

end