for j = 1:length(c_section)
    for i = 1:height(w(:,j))
        if w(i,j).MoSTresca < 1
            w(i,j).stat = 'Fail';
        elseif w(i,j).MoSBuckle < 1
            w(i,j).stat = 'Fail';
        else
            w(i,j).stat = 'Safe';
        end
    end
end
