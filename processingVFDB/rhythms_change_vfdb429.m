function ann_out = rhythms_change_vfdb429(ann,type)

    infor(1).ann = 1; infor(1).type = '(BI';
    
 for i=2:3  infor(i).ann = ann(i); infor(i).type = type{i}; end 
 
     infor(4).ann = 108656; infor(4).type = '(NOISE';
     infor(5).ann = 109115; infor(5).type = '(BI';
 
  for i=6:25  infor(i).ann = ann(i-2); infor(i).type = type{i-2}; end 
  
for j=1:length(infor)
  ann_out(j).type = infor(j).type;
  ann_out(j).sampNum = infor(j).ann;
end
