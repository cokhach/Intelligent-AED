function ann_out = rhythms_change_cudb_cu31(ann,type)
% This function is for Cu31

    infor(1).ann = 1;
    infor(1).type = type(1);
        
for t=2:44
    infor(t).ann = ann(t-1); 
    infor(t).type = type(t-1);
end
    infor(45).type = '(AS'; infor(45).ann = 15863;
    infor(46).type = 'AS)'; infor(46).ann = 18209;
 
for t=47:60
    infor(t).ann = ann(t-3); 
    infor(t).type = type(t-3);
end
         
    infor(61).type = '(AS'; infor(61).ann = 21560;
    infor(62).type = 'AS)'; infor(62).ann = 24569;
 
for t=63:74
    infor(t).type = type(t-5);
    infor(t).ann = ann(t-5);
end
    infor(75).type = '(AS'; infor(75).ann = 29830;
    infor(76).type = 'AS)'; infor(76).ann = 32056;
 
for t=77:144
    infor(t).type = type(t-7);
    infor(t).ann = ann(t-7);
end

    infor(145).type = '(AS'; infor(145).ann = 63968;
    infor(146).type = 'AS)'; infor(146).ann = 66031;
 
for t=147:158
    infor(t).type = type(t-9);
    infor(t).ann = ann(t-9);
end

    infor(159).type = '(AS'; infor(159).ann = 70780;
    infor(160).type = 'AS)'; infor(160).ann = 74224;
 
for t=161:195
    infor(t).type = type(t-11);
    infor(t).ann = ann(t-11);
end  

    infor(196).type = '(AS'; infor(196).ann = 90118;
    infor(197).type = 'AS)'; infor(197).ann = 92224;
 
for t=198:259
    infor(t).type = type(t-13);
    infor(t).ann = ann(t-13);
end  

    infor(260).type = '(AS'; infor(260).ann = 112935;
    infor(261).type = 'AS)'; infor(261).ann = 115591;
 
for t=262:274
    infor(t).type = type(t-15);
    infor(t).ann = ann(t-15);
end  

    infor(275).type = '(AS'; infor(275).ann = 118708;
    infor(276).type = '['; infor(276).ann = 123626;

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
