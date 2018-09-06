function ann_out = rhythms_change_cudb_cu27(ann,type)
% This function is for Cu27

    infor(1).ann = 1;
    infor(1).type = '<';
        
for t=2:19
    infor(t).ann = ann(t-1); 
    infor(t).type = type(t-1);
end

   infor(20).type = '>';
    infor(20).ann = 4616;
 
for t=21:617   
    infor(t).type = type(t-2);
    infor(t).ann = ann(t-2);
end

    infor(618).type = '{';
    infor(618).ann = 76148;
    
for t=619:790
    infor(t).type = type(t-3);
    infor(t).ann = ann(t-3);
end

    infor(791).type = '}';
    infor(791).ann = 92058;
    
for t=792:1006    
    infor(t).type = type(t-4);
    infor(t).ann = ann(t-4);
end

    infor(1007).type = '<';
    infor(1007).ann = 110864;
    
for t=1008:1033  
    infor(t).type = type(t-4);
    infor(t).ann = ann(t-4);
end

    infor(1034).type = '<';
    infor(1034).ann = 118706;
    
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
