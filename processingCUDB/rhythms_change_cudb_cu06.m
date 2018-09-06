function ann_out = rhythms_change_cudb_cu06(ann,type)
% This function is for Cu06

    infor(1).ann = 1;
    infor(1).type = type(1);
      
for t=2:289
    infor(t).ann = ann(t-1); 
    infor(t).type = type(t-1);
end

    infor(290).ann = 70155; 
    infor(290).type = '<';

for t=291:294
      infor(t).ann = ann(t-2); 
    if t==292
        infor(t).type = 'N';
    else
      infor(t).type = type(t-2);
    end  
end

    infor(295).ann = 77346; 
    infor(295).type = '>';
    
for t=296:316
    infor(t).ann = ann(t-3); 
    infor(t).type = type(t-3);
end    

    infor(317).ann = 82873; 
    infor(317).type = '<';

for t=318:323
      infor(t).ann = ann(t-4); 
    if t==319
        infor(t).type = 'N';
    else
      infor(t).type = type(t-4);
    end  
end
 
    infor(324).ann = 84444; 
    infor(324).type = '>';
 
for t=325:458
    infor(t).ann = ann(t-5); 
    infor(t).type = type(t-5);
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
