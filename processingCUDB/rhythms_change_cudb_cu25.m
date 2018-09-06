function ann_out = rhythms_change_cudb_cu25(ann,type)
% This function is for Cu25

    infor(1).ann = 1;
    infor(1).type = type(1);

for t=2:503
    infor(t).ann = ann(t-1); 
    infor(t).type = type(t-1);
end

    infor(504).type = '<';
    infor(504).ann = 108010;
    
    infor(505).type = '[';
    infor(505).ann = 110076;
    
    infor(506).type = '(AS';
    infor(506).ann = 115018;
    
    infor(507).type = 'N';
    infor(507).ann = ann(503);
    
for t = 508:509
    infor(t).ann = ann(t-4); 
    infor(t).type = type(t-4);
end

    infor(510).ann = 117695;
    infor(510).type = 'AS)';
     
for t = 511:564
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
