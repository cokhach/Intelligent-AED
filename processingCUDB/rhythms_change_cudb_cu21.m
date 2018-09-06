function ann_out = rhythms_change_cudb_cu21(ann,type)
% This function is for Cu21
L = length(ann)+1;
type(type=='+') = 'N';   

    infor(1).ann = 1;
    infor(1).type = '[';

for t=2:15
    infor(t).ann = ann(t-1); %1-14
    infor(t).type = type(t-1);
end
    infor(16).type = '<'; infor(16).ann = 6865;
    
for t = 17:21
    infor(t).ann = ann(t-2); % 15-19
    infor(t).type = type(t-2);
end

    infor(22).ann = 7799; infor(22).type = '>';

for t = 23:42
    infor(t).ann = ann(t-3); % 20-39
    infor(t).type = type(t-3);
end

    infor(43).ann = 10693; infor(43).type = '{';

for t = 44:195
    infor(t).ann = ann(t-4); % 40-191
    infor(t).type = type(t-4);
end

    infor(196).ann = 47992; infor(196).type = '{';
    
for t = 197:276
    infor(t).ann = ann(t-5);
    infor(t).type = type(t-5);
end

    infor(277).ann = 60315; infor(277).type = '{';
    
for t = 278:356
    infor(t).ann = ann(t-6);
    infor(t).type = type(t-6);
end

    infor(357).ann = ann(351); infor(357).type = '{';

for t = 358:369
    infor(t).ann = ann(t-6);
    infor(t).type = type(t-6);
end

    infor(370).ann = 85100; infor(370).type = '<';

    infor(371).ann = 86143; infor(371).type = '[';
    
for t = 372:488
    infor(t).ann = ann(t-8);
    infor(t).type = type(t-8);
end   

    infor(489).ann = 111189; infor(489).type = '<';
    
for t = 490:500
    infor(t).ann = ann(t-9);
    infor(t).type = type(t-9);    
end    

    infor(501).ann = 112747; infor(501).type = '>';   
    
for t = 502:656
    infor(t).ann = ann(t-10);
    infor(t).type = type(t-10);    
end
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
