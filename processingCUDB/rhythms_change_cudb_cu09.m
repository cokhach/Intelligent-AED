function ann_out = rhythms_change_cudb_cu09(ann,type)
% This function is for Cu09
   
infor(1).ann = 1;
infor(1).type = type(1);  

for t=2:533
      infor(t).ann = ann(t-1);
    if t==223
        infor(t).type = '(A';
    elseif t==312
        infor(t).type = 'A)';
    elseif t==385
        infor(t).type = '(A';
    elseif t==423
        infor(t).type = 'A)';
    else    
      infor(t).type = type(t-1);
    end
end

infor(534).ann = 66291;
infor(534).type = '<';  

infor(535).ann = 66351;
infor(535).type = '[';

infor(536).ann = 68273;
infor(536).type = '<';

infor(537).ann = 68716;
infor(537).type = '[';

infor(538).ann = 73983;
infor(538).type = '<';  

infor(539).ann = ann(533);
infor(539).type = 'N'; 

for t=540:542
    infor(t).ann = ann(t-6);
    infor(t).type = type(t-6);
end

infor(543).ann = ann(537);
infor(543).type = '>';

for t=544:738
    infor(t).ann = ann(t-6);
    infor(t).type = type(t-6);
end

    infor(739).ann = ann(733);
    infor(739).type = '<';

for t=740:744
    infor(t).ann = ann(t-6);
    infor(t).type = type(t-6);
end

    infor(745).ann = 109035;
    infor(745).type = '{';

for t=746:830
      infor(t).ann = ann(t-7);
      infor(t).type = type(t-7);
end

    infor(831).ann = 117513;
    infor(831).type = '<';

for t=832:836
    infor(t).ann = ann(t-8);
    infor(t).type = type(t-8);
end

    infor(837).ann = 118191;
    infor(837).type = '{';

for t=838:931
    infor(t).ann = ann(t-9);
    infor(t).type = type(t-9);
end

    infor(932).ann = 127001;
    infor(932).type = '(A';
    
for t=933:935
    infor(t).ann = ann(t-10);
    infor(t).type = type(t-10);
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
    elseif strcmp(infor(k).type,'(A')
         infor(k).auxInfo = '(AF'; 
    elseif strcmp(infor(k).type,'A)')
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
