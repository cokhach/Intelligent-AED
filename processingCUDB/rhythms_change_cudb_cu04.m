function ann_out = rhythms_change_cudb_cu04(ann,type)
% This function is for Cu04
   
infor(1).ann = 1;
infor(1).type = type(1);

for t=2:143
    infor(t).ann = ann(t-1);
    infor(t).type = type(t-1);
end
    infor(144).ann = 37875;
    infor(144).type = '[';

for t=145:166
    infor(t).ann = ann(t-2);
    infor(t).type = type(t-2);
end
    infor(167).ann = 55148;
    infor(167).type = '[';

for t=168:187
    infor(t).ann = ann(t-3);
    infor(t).type = type(t-3);
end
    infor(188).ann = 62931;
    infor(188).type = '[';

for t=189:219
    infor(t).ann = ann(t-4);
    infor(t).type = type(t-4);
end
    infor(220).ann = 91944;
    infor(220).type = '[';

for t=221:253
    infor(t).ann = ann(t-5);
    infor(t).type = type(t-5);
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
