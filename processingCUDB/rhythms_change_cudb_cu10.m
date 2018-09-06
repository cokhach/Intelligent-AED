function ann_out = rhythms_change_cudb_cu10(ann,type)
% This function is for Cu10
   
infor(1).ann = 1;
infor(1).type = type(1);  

for t=2:370
    infor(t).ann = ann(t-1);
    infor(t).type = type(t-1);
end

infor(371).ann = 56100;
infor(371).type = '<';  

for t=372:373
    infor(t).ann = ann(t-2);
    infor(t).type = type(t-2);
end

infor(374).ann = 56344;
infor(374).type = '>'; 

for t=375:510
    infor(t).ann = ann(t-3);
    infor(t).type = type(t-3);
end

infor(511).ann = 76445;
infor(511).type = '{'; 

for t=512:560
    infor(t).ann = ann(t-4);
    infor(t).type = type(t-4);
end

infor(561).ann = 120048;
infor(561).type = '<';  

infor(562).ann = ann(557);
infor(562).type = 'N';

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
