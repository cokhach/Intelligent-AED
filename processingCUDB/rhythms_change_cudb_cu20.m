function ann_out = rhythms_change_cudb_cu20(ann,type)
% This function is for Cu20
   
infor(1).ann = 1;
infor(1).type = type(1);

for t=2:85
    infor(t).ann = ann(t-1);
    infor(t).type = type(t-1);
end

infor(86).ann = 24463;infor(86).type = '<';
infor(87).ann = ann(85);infor(87).type = type(85);
infor(88).ann = 24921;infor(88).type = '>';

for t=89:196
    infor(t).ann = ann(t-3);
    infor(t).type = type(t-3);
end

infor(197).ann = 58625;infor(197).type = '{';

for t=198:210
    infor(t).ann = ann(t-4);
    infor(t).type = type(t-4);
end

infor(211).ann = 60699;infor(211).type = '<';

for t=212:213
    infor(t).ann = ann(t-5);
    infor(t).type = type(t-5);
end

infor(214).ann = 67280;infor(214).type = '<';
infor(215).ann = 69501;infor(215).type = '[';
infor(216).ann = 72078;infor(216).type = '<';


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
