function ann_out = rhythms_change_cudb_cu30(ann,type)
% This function is for Cu30

    infor(1).ann = 1;
    infor(1).type = type(1);
        
for t=2:62
    infor(t).ann = ann(t-1); 
    infor(t).type = type(t-1);
end
    infor(63).type = '{'; infor(63).ann = 6390;
        
for t=64:70   
    infor(t).type = type(t-2);
    infor(t).ann = ann(t-2);
end

    infor(71).type = '<'; infor(71).ann = 14850;
    
    infor(72).type = '['; infor(72).ann = 30039;
    
    infor(73).type = '<'; infor(73).ann = 33073;
    
    infor(74).type = '~'; infor(74).ann = ann(69);
    
for t=75:96
    infor(t).type = type(t-5);
    infor(t).ann = ann(t-5);
end

    infor(97).type = '~'; infor(97).ann = ann(92);
    infor(98).type = '['; infor(98).ann = 50759;
    infor(99).type = '<'; infor(99).ann = 51748;
    infor(100).type = '['; infor(100).ann = 68104;
    infor(101).type = '<'; infor(101).ann = 69573;
    infor(102).type = '~'; infor(102).ann = ann(93);

for t=103:126    
    infor(t).type = type(t-9);
    infor(t).ann = ann(t-9);
end

    infor(127).type = '~'; infor(127).ann = ann(118);
    infor(128).type = '['; infor(128).ann = 117330;
    infor(129).type = '<'; infor(129).ann = 119947;
    
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
