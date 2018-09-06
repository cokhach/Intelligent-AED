function ann_out = rhythms_change_cudb_cu12(ann,type)
% This function is for Cu12
   
infor(1).ann = 1;
infor(1).type = type(1);  

for t=2:28
    infor(t).ann = ann(t-1);
    infor(t).type = type(t-1);
end

infor(29).ann = 5100;
infor(29).type = '<';  

for t=39:33
    infor(t).ann = ann(t-2);
    infor(t).type = type(t-2);
end

infor(34).ann = 6089;
infor(34).type = '>';  

for t=35:355
    infor(t).ann = ann(t-3);
    infor(t).type = type(t-3);
end

infor(356).ann = 72990; infor(356).type = '<';  
infor(357).ann = 73964; infor(357).type = '['; 
infor(358).ann = 77460; infor(358).type = '<';  
infor(359).ann = 77596; infor(359).type = '['; 
infor(360).ann = 78438; infor(360).type = '<';  
infor(361).ann = 80329; infor(361).type = '['; 
infor(362).ann = 84278; infor(362).type = '<';  
infor(363).ann = 103904; infor(363).type = '['; 
infor(364).ann = 113678; infor(364).type = '<';  
infor(365).ann = ann(353); infor(365).type = 'N'; 
infor(366).ann = 115371; infor(366).type = '>'; 

for t=367:423
    infor(t).ann = ann(t-13);
    infor(t).type = type(t-13);
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
