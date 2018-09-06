function ann_out = rhythms_change_vfdb615(ann,type)

    infor(1).ann = 1; infor(1).type = '(AFIB';   
    
 for i=2:6  infor(i).ann = ann(i); infor(i).type = type{i}; end  
    
    infor(7).ann = 151864; infor(7).type = '(N';   
    infor(8).ann = 153077; infor(8).type = '(VT';   
    infor(9).ann = 153586; infor(9).type = '(N';    
    infor(10).ann = 154037; infor(10).type = '(VT';   
    infor(11).ann = 154459; infor(11).type = '(N';     
    infor(12).ann = 154930; infor(12).type = '(VT';  
    
 for i=13:17  infor(i).ann = ann(i-6); infor(i).type = type{i-6}; end     
    
for j=1:length(infor)
  ann_out(j).type = infor(j).type;
  ann_out(j).sampNum = infor(j).ann;
end
