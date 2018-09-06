function ann_out = rhythms_change_cudb_cu34(ann,type)
% This function is for Cu34

    infor(1).ann = 1;
    infor(1).type = type(1);
        
for t=2:73
    infor(t).ann = ann(t-1); 
    infor(t).type = type(t-1);
end

    infor(74).type = '<'; infor(74).ann = 38338;
    infor(75).type = '>'; infor(75).ann = 40336;   
     
for t=76:82
    infor(t).type = type(t-3);
    infor(t).ann = ann(t-3);
end
      
    infor(83).type = '<'; infor(83).ann = 41765;    
    infor(84).type = '>'; infor(84).ann = 42974;

for t=85:197
    infor(t).type = type(t-5);
    infor(t).ann = ann(t-5);
end
    infor(198).type = '<'; infor(198).ann = 103420; 
    infor(199).type = '['; infor(199).ann = 103816;    
    infor(200).type = '<'; infor(200).ann = 107018;    
    infor(201).type = '['; infor(201).ann = 107191;   

for t=202:264
    infor(t).type = type(t-9);
    infor(t).ann = ann(t-9);
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
