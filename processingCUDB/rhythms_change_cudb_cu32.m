function ann_out = rhythms_change_cudb_cu32(ann,type)
% This function is for Cu32

    infor(1).ann = 1;
    infor(1).type = type(1);
        
for t=2:134
    infor(t).ann = ann(t-1); 
    infor(t).type = type(t-1);
end

    infor(135).type = '{';
    infor(135).ann = 19878;
    
for t=136:139   
    infor(t).type = type(t-2);
    infor(t).ann = ann(t-2);
    
end
    infor(140).type = '}';
    infor(140).ann = 20224;   
     
for t=141:742
    infor(t).type = type(t-3);
    infor(t).ann = ann(t-3);
end

    infor(743).type = '{';
    infor(743).ann = 109958;
   
for t=744:784    
    infor(t).type = type(t-4);
    infor(t).ann = ann(t-4);
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
