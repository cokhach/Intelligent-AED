function ann_out = rhythms_change_cudb_cu35(ann,type)
% This function is for Cu35

    infor(1).ann = 1;
    infor(1).type = '<';
        
for t=2:89
    infor(t).ann = ann(t-1); 
    infor(t).type = type(t-1);
end
    infor(90).type = '>'; infor(90).ann = 77854;
            
for t=91:331
    infor(t).type = type(t-2);
    infor(t).ann = ann(t-2);
end
 
L = length(infor);
if strcmp(infor(1).type,'N')
    infor(1).auxInfo = '(N'; 
    elseif strcmp(infor(1).type,'[')
     infor(1).auxInfo = '(VF'; 
    elseif strcmp(infor(1).type,'<')
     infor(1).auxInfo = '(NOISE';
end

for k=2:L
    if strcmp(infor(k).type,'[')
         infor(k).auxInfo = '(VF'; 
    elseif strcmp(infor(k).type,']')
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
