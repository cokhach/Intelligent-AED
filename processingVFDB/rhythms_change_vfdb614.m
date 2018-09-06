function ann_out = rhythms_change_vfdb614(ann,type)

    infor(1).ann = 1; infor(1).type = '(B';   
    
 for i=2:19  infor(i).ann = ann(i); infor(i).type = type{i}; end  
    
    infor(20).ann = 355943; infor(20).type = '(VF';   
 

for j=1:length(infor)
  ann_out(j).type = infor(j).type;
  ann_out(j).sampNum = infor(j).ann;
end
