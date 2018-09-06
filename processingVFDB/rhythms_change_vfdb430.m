function ann_out = rhythms_change_vfdb430(ann,type)

    infor(1).ann = 1; infor(1).type = '(BI';
    
 for i=2:7  infor(i).ann = ann(i); infor(i).type = type{i}; end 
 
     infor(8).ann = 96891; infor(8).type = '(VT';
     infor(9).ann = 98390; infor(9).type = '(BI';
 
  for i=10:19  infor(i).ann = ann(i-1); infor(i).type = type{i-1}; end
  
     infor(20).ann = 170126; infor(20).type = '(VT';
     infor(21).ann = 175437; infor(21).type = '(VF';
     infor(22).ann = 176534; infor(22).type = '(N';
     infor(23).ann = 179405; infor(23).type = '(VF';
  
  for i=24:25  infor(i).ann = ann(i-1); infor(i).type = type{i-1}; end  
  
     infor(26).ann = 273251; infor(26).type = '(NOISE';
     infor(27).ann = 274762; infor(27).type = '(VF';
     infor(28).ann = 308409; infor(28).type = '(NOISE';
     infor(29).ann = 310610; infor(29).type = '(ASYS';
     
  for i=30:31  infor(i).ann = ann(i-2); infor(i).type = type{i-2}; end      
     
     infor(32).ann = 340366; infor(32).type = '(VT';
     infor(33).ann = 392027; infor(33).type = '(VF';  
     
  for i=34:35  infor(i).ann = ann(i-4); infor(i).type = type{i-4}; end  
  
     infor(36).ann = 414996; infor(36).type = '(VT';
     infor(37).ann = 464614; infor(37).type = '(VF';
     infor(38).ann = 483159; infor(38).type = '(VT';
     infor(39).ann = 489635; infor(39).type = '(VER';
     infor(40).ann = ann(34); infor(40).type = type{34};
     infor(41).ann = 497151; infor(41).type = '(VT';
     %infor(42).ann = 308409; infor(42).type = '(VT';    
     
for j=1:length(infor)
  ann_out(j).type = infor(j).type;
  ann_out(j).sampNum = infor(j).ann;
end
