function ann_out = rhythms_change_cudb_cu15(ann,type)
% This function is for Cu15
   
infor(1).ann = 1;
infor(1).type = type(1);

for t=2:28
    infor(t).ann = ann(t-1);
    infor(t).type = type(t-1);
end

infor(29).ann = 9303; infor(29).type = '<';
infor(30).ann = ann(28); infor(30).type = type(28);
infor(31).ann = 9681; infor(31).type = '>';

for t=32:57
    infor(t).ann = ann(t-3);
    infor(t).type = type(t-3);
end

infor(58).ann = 18420; infor(58).type = '<';  

for t=59:64
    infor(t).ann = ann(t-4);
    infor(t).type = type(t-4);
end

infor(65).ann = 20481; infor(65).type = '>'; 

for t=66:100
    infor(t).ann = ann(t-5);
    infor(t).type = type(t-5);
end

infor(101).ann = 32345; infor(101).type = '<';  

for t=102:113
    infor(t).ann = ann(t-6);
    infor(t).type = type(t-6);
end

infor(114).ann = 37041; infor(114).type = '>'; 

for t=115:147
    infor(t).ann = ann(t-7);
    infor(t).type = type(t-7);
end

infor(148).ann = 50748; infor(148).type = '<';
infor(149).ann = ann(141); infor(149).type = type(141);
infor(150).ann = 51331; infor(150).type = '>';

for t=151:157
    infor(t).ann = ann(t-9);
    infor(t).type = type(t-9);
end

infor(158).ann = 54545; infor(158).type = '<'; 

for t=159:160
    infor(t).ann = ann(t-10);
    infor(t).type = type(t-10);
end

infor(161).ann = 54771; infor(161).type = '>'; 

for t=162:295
    infor(t).ann = ann(t-11);
    infor(t).type = type(t-11);
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
