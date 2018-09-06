function ann_out = rhythms_change_cudb_cu28(ann,type)
% This function is for Cu28

    infor(1).ann = 1;
    infor(1).type = type(1);
        
for t=2:263
    infor(t).ann = ann(t-1); 
    infor(t).type = type(t-1);
end
    infor(264).type = '(AS'; infor(264).ann = 45573;
    infor(265).type = '<'; infor(265).ann = 95075;
    infor(266).type = '(AS'; infor(266).ann = 96466;
    infor(267).type = 'AS)'; infor(267).ann = 101961;
 
for t=268:390
    infor(t).type = type(t-5);
    infor(t).ann = ann(t-5);
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
         infor(k).auxInfo = '(NOISE';
    elseif strcmp(infor(k).type,'{')
         infor(k).auxInfo = '(VT';   
    elseif strcmp(infor(k).type,'}')
         infor(k).auxInfo = '(N';
    elseif strcmp(infor(k).type,'<')
         infor(k).auxInfo = '(NOISE';
    elseif strcmp(infor(k).type,'>')
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
