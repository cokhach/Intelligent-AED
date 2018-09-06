function ann_out = rhythms_change_cudb_cu17(ann,type)
% This function is for Cu17
   
infor(1).ann = 1;
infor(1).type = type(1);

for t=2:463
    infor(t).ann = ann(t-1);
    infor(t).type = type(t-1);
end

infor(464).ann = 110751;infor(464).type = '(AS';
infor(465).ann = 112051;infor(465).type = 'AS)';

for t=466:536
    infor(t).ann = ann(t-3);
    infor(t).type = type(t-3);
end

L = length(infor);

if strcmp(infor(1).type,'N')
    infor(1).auxInfo = '(N'; 
    elseif strcmp(infor(1).type,'[')
     infor(1).auxInfo = '(VF'; 
    elseif strcmp(infor(1).type,'{')
     infor(1).auxInfo = '(VT';
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
    elseif strcmp(infor(k).type,'(AS')
         infor(k).auxInfo = '(ASYS';
    elseif strcmp(infor(k).type,'AS)')
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
