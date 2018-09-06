function ann_out = rhythms_change_cudb_cu02(ann,type)
% This function is for Cu02


infor(1).ann = 1;
infor(1).type = type(1);

for t=2:101
    infor(t).ann = ann(t-1);
    infor(t).type = type(t-1);
end

infor(102).ann = 13405;
infor(102).type = '<';

for t=103:110
    infor(t).ann = ann(t-2);
    infor(t).type = type(t-2);
end

infor(111).ann = 14487;
infor(111).type = '>';

for t=112:732
      infor(t).ann = ann(t-3);
    if t == 356 
        infor(t).type = '{';
    elseif t == 360
        infor(t).type = '}';
    elseif t == 366
        infor(t).type = '{';
    elseif t == 396
        infor(t).type = '}';
    else    
      infor(t).type = type(t-3);    
    end
end

infor(733).ann = 98316;
infor(733).type = '<';

for t=734:749
    infor(t).ann = ann(t-4);
    infor(t).type = type(t-4);
end

infor(750).ann = 100665;
infor(750).type = '>';

for t=751:975
    infor(t).ann = ann(t-5);
    if t == 905 
        infor(t).type = '{';
    elseif t == 914
        infor(t).type = '}';
    elseif t == 916
        infor(t).type = '{';
    elseif t == 925
        infor(t).type = '}';
    elseif t == 927
        infor(t).type = '{';
    else            
    infor(t).type = type(t-5);
    end
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
