function ann_out = rhythms_change_cudb_cu29(ann,type)
% This function is for Cu29

    infor(1).ann = 1;
    infor(1).type = type(1);
        
for t=2:88
    infor(t).ann = ann(t-1); 
    infor(t).type = type(t-1);
end

    infor(89).type = '<'; infor(89).ann = 15126;
 
for t=90:95   
    infor(t).type = type(t-2);
    infor(t).ann = ann(t-2);
end

    infor(96).type = '>'; infor(96).ann = 16778;
    
for t=97:546
    infor(t).type = type(t-3);
    infor(t).ann = ann(t-3);
end

    infor(547).type = '<'; infor(547).ann = 101794;    
    infor(548).type = '['; infor(548).ann = 102035;    
    infor(549).type = '<'; infor(549).ann = 110542;    
    infor(550).type = '['; infor(550).ann = 113225;    
    infor(551).type = '<'; infor(551).ann = 114744;    
    infor(552).type = '['; infor(552).ann = 115500;    
    infor(553).type = '<'; infor(553).ann = 118222;    
    infor(554).type = '['; infor(554).ann = 118988;    
    infor(555).type = '<'; infor(555).ann = 124092;
    
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
