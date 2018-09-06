function ann_out = rhythms_change_vfdb425(ann,type)

    infor(1).ann = 1; infor(1).type = '(N';
    
 for i=2:5  infor(i).ann = ann(i); infor(i).type = type{i}; end 
 
    infor(6).ann = 82949; infor(6).type = '(NOISE'; 
    infor(7).ann = 86722; infor(7).type = '(N'; 
    
 for i=8:9  infor(i).ann = ann(i-2); infor(i).type = type{i-2}; end           

    infor(10).ann = 139876; infor(10).type = '(NOISE'; 
    infor(11).ann = 140932; infor(11).type = '(N'; 
    infor(12).ann = 191111; infor(12).type = '(NOISE'; 
    infor(13).ann = 197157; infor(13).type = '(N';     
    
for i=14:17  infor(i).ann = ann(i-6); infor(i).type = type{i-6}; end        
    
    infor(18).ann = 238821; infor(18).type = '(N'; 
    infor(19).ann = 240507; infor(19).type = '(NOISE'; 
    infor(20).ann = 244104; infor(20).type = '(N'; 
    infor(21).ann = 256647; infor(21).type = '(B';
    infor(22).ann = 284566; infor(22).type = '(NOISE';
    
for i=23:25  infor(i).ann = ann(i-7); infor(i).type = type{i-7}; end      
    
    infor(26).ann = 357481; infor(26).type = '(NOISE';   
    infor(27).ann = 358517; infor(27).type = '(N';
    
for i=28:29  infor(i).ann = ann(i-9); infor(i).type = type{i-9}; end          
    
    infor(30).ann = 483064; infor(30).type = '(NOISE';
    infor(31).ann = 486795; infor(31).type = '(N';
       
for j=1:length(infor)
  ann_out(j).type = infor(j).type;
  ann_out(j).sampNum = infor(j).ann;
end
