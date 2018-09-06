function ann_out = rhythms_change_cudb_cu14(ann,type)
% This function is for Cu14

infor(1).ann = 1;
infor(1).type = type(1);

for t=2:411
    infor(t).ann = ann(t-1);
    infor(t).type = type(t-1);
end

infor(412).ann = 97735; infor(412).type = '(sVT';

for t=413:433
    infor(t).ann = ann(t-2);
    infor(t).type = type(t-2);
end

infor(434).ann = 100326; infor(434).type = 'sVT)';  

for t=435:458
    infor(t).ann = ann(t-3);
    infor(t).type = type(t-3);
end

infor(459).ann = 105907; infor(459).type = '<'; 

for t=460:473
    infor(t).ann = ann(t-4);
    infor(t).type = type(t-4);
end

infor(474).ann = 108698; infor(474).type = '>';  

for t=475:503
    infor(t).ann = ann(t-5);
    infor(t).type = type(t-5);
end

infor(504).ann = 116525; infor(504).type = '<'; 

for t=505:540
    infor(t).ann = ann(t-6);
    infor(t).type = type(t-6);
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
   elseif strcmp(infor(k).type,'(sVT')
         infor(k).auxInfo = '(sTV';
    elseif strcmp(infor(k).type,'sVT)')
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
