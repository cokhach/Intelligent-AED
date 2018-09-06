function ann_out = rhythms_change_cudb_cu13(ann,type)
% This function is for Cu13
   
infor(1).ann = 1;
infor(1).type = type(1);

for t=2:688
    infor(t).ann = ann(t-1);
    infor(t).type = type(t-1);
end

infor(689).ann = 95433;
infor(689).type = '{';

for t=690:850
    infor(t).ann = ann(t-2);
    infor(t).type = type(t-2);
end

infor(851).ann = 106846; infor(851).type = '<';  
infor(852).ann = 108689; infor(852).type = '['; 
infor(853).ann = 110973; infor(853).type = '<';  
infor(854).ann = 113689; infor(854).type = '['; 
infor(855).ann = 120028; infor(855).type = '<'; 
infor(856).ann = ann(849); infor(856).type = 'N'; 

for t=857:858
    infor(t).ann = ann(t-7);
    infor(t).type = type(t-7);
end

infor(859).ann = 122682; infor(859).type = '>'; 

for t=860:878
    infor(t).ann = ann(t-8);
    infor(t).type = type(t-8);
end

L = length(infor);
if strcmp(infor(1).type,'N')
    infor(1).auxInfo = '(N'; 
    elseif strcmp(infor(1).type,'[')
     infor(1).auxInfo = '(VF'; 
    elseif strcmp(infor(1).type,'{')
     infor(1).auxInfo = '(VT';
    elseif strcmp(infor(1).type,'<')
     infor(1).auxInfo = '(NOISE';
end

for k=2:L
    if strcmp(infor(k).type,'[')
         infor(k).auxInfo = '(VF'; 
    elseif strcmp(infor(k).type,']')
         infor(k).auxInfo = '(N';
    elseif strcmp(infor(k).type,'{')
         infor(k).auxInfo = '(VT';   
    elseif strcmp(infor(k).type,'}')
         infor(k).auxInfo = '(N';
    elseif strcmp(infor(k).type,'<')
         infor(k).auxInfo = '(NOISE';
    elseif strcmp(infor(k).type,'>')
         infor(k).auxInfo = '(N';
    else
    end
end

j = 1; 
for i=1:L
    if ~isempty(infor(i).auxInfo)
        ann_out(j).type = infor(i).auxInfo;
        ann_out(j).sampNum = infor(i).ann;        
        j = j + 1;
    end
end
