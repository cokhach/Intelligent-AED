function ann_out = rhythms_change_cudb_cu23(ann,type)
% This function is for Cu23
   
infor(1).ann = 1;
infor(1).type = type(1);

for t=2:409
    infor(t).ann = ann(t-1);
    infor(t).type = type(t-1);
end

infor(410).ann = 89983;infor(410).type = '<';
infor(411).ann = 90409;infor(411).type = '[';
infor(412).ann = 101390;infor(412).type = '<';
infor(413).ann = ann(409);infor(413).type = 'N';
infor(414).ann = 113244;infor(414).type = '(AS';

for t=415:435
    infor(t).ann = ann(t-5);
    infor(t).type = type(t-5);
end

infor(436).ann = 121121;infor(436).type = '<';
infor(437).ann = 121531;infor(437).type = '>';

for t=438:450
    infor(t).ann = ann(t-7);
    infor(t).type = type(t-7);
end

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
