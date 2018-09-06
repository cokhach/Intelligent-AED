function ann_out = rhythms_change_cudb_cu05(ann,type)
% This function is for Cu05
   
infor(1).ann = 1;
infor(1).type = type(1);

for t=2:138
    infor(t).ann = ann(t-1);
    infor(t).type = type(t-1);
end
    infor(139).ann = 22050;
    infor(139).type = '{';

for t=140:233
    infor(t).ann = ann(t-2);
    if t == 157
        infor(t).type = '}';
    else   
    infor(t).type = type(t-2);
    end
end
    infor(234).ann = 35728;
    infor(234).type = '{';

for t=235:256
    infor(t).ann = ann(t-3);
    infor(t).type = type(t-3);
end
    infor(257).ann = 37136 ;
    infor(257).type = '}';

for t=258:330
    infor(t).ann = ann(t-4);
    infor(t).type = type(t-4);
end
    infor(331).ann = 48190;
    infor(331).type = '{';

for t=332:358
    infor(t).ann = ann(t-5);
    infor(t).type = type(t-5);
end        
    infor(359).ann = 49924;
    infor(359).type = '}'; 
    
for t=360:377
    infor(t).ann = ann(t-6);
    infor(t).type = type(t-6);
end 

    infor(378).ann = 52743;
    infor(378).type = '{'; 
    
for t=379:390
    infor(t).ann = ann(t-7);
    infor(t).type = type(t-7);
end 

    infor(391).ann = 53584;
    infor(391).type = '}'; 
    
    infor(392).ann = ann(384);
    infor(392).type = type(384);
    
    infor(393).ann = 53835;
    infor(393).type = '{'; 
    
for t=394:398
    infor(t).ann = ann(t-9);
    infor(t).type = type(t-9);
end 

    infor(399).ann = 54199;
    infor(399).type = '}'; 

for t=400:404
    infor(t).ann = ann(t-10);
    infor(t).type = type(t-10);
end

    infor(405).ann = 54823;
    infor(405).type = '{'; 

for t=406:420
    infor(t).ann = ann(t-11);
    infor(t).type = type(t-11);
end
   
    infor(421).ann = 55891;
    infor(421).type = '}'; 
    
for t=422:633
    infor(t).ann = ann(t-12);
    infor(t).type = type(t-12);
end
       
    infor(634).ann = 111353;
    infor(634).type = '<';     
    
for t=635:650
    infor(t).ann = ann(t-13);
    if t==636
        infor(t).type = '~';
    else    
        infor(t).type = type(t-13);
    end
end
       
    infor(651).ann = 115147;
    infor(651).type = '>';  
    
for t=652:689
    infor(t).ann = ann(t-14);
    infor(t).type = type(t-14);
end   
    
    infor(690).ann = 122636;
    infor(690).type = '<';    
    
for t=691:692
    infor(t).ann = ann(t-15);
    infor(t).type = type(t-15);
end       
    infor(693).ann = 122990;
    infor(693).type = '>';    
    
for t=694:713
    infor(t).ann = ann(t-16);
    infor(t).type = type(t-16);
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
