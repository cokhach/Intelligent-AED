function ann_out = rhythms_change_cudb_cu26(ann,type)
% This function is for Cu26


    infor(1).ann = 1;
    infor(1).type = type(1);

for t=2:391
    infor(t).ann = ann(t-1); 
    infor(t).type = type(t-1);
end

    infor(392).type = '<';
    infor(392).ann = 42198;
    
    infor(393).type = '[';
    infor(393).ann = 42589;
    
    infor(394).type = '<';
    infor(394).ann = 50775;
    
    infor(395).type = '>';
    infor(395).ann = 102278;
    
    infor(396).type = '<';
    infor(396).ann = 118682;
    
     infor(397).type = '[';
    infor(397).ann = 119317;
    
    infor(398).type = '<';
    infor(398).ann = 120923;
    
     infor(399).type = '[';
    infor(399).ann = 121161;
    
    infor(400).type = '<';
    infor(400).ann = 123316;
    
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
