function ann_out = rhythms_change_cudb_cu22(ann,type)
% This function is for Cu22

    infor(1).ann = 1;
    infor(1).type = type(1);

for t=2:377
    infor(t).ann = ann(t-1); 
    infor(t).type = type(t-1);
end 
    infor(378).type = '<'; infor(378).ann = 91553;
    
    infor(379).type = '['; infor(379).ann = 92490;
    
for t = 380:382
    infor(t).ann = ann(t-3); 
    infor(t).type = type(t-3);
end

    infor(383).ann = 114219; infor(383).type = '(AS';

    infor(384).ann = 116077; infor(384).type = 'AS)';
    
for t = 385:445
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
