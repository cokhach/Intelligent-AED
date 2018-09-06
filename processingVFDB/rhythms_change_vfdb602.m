function ann_out = rhythms_change_vfdb602(ann,type)

    infor(1).ann = 1; infor(1).type = '(PM';
    
 for i=2:8  infor(i).ann = ann(i); infor(i).type = type{i}; end 
 
     infor(9).ann = 365551; infor(9).type = '(NOISE';
     infor(10).ann = 367316; infor(10).type = '(VF';
     infor(11).ann = 397187; infor(11).type = '(NOISE';
     infor(12).ann = 402251; infor(12).type = '(VF';
     infor(13).ann = 405251; infor(13).type = '(NOISE';
      
  for i=14:17  infor(i).ann = ann(i-5); infor(i).type = type{i-5}; end
       
for j=1:length(infor)
  ann_out(j).type = infor(j).type;
  ann_out(j).sampNum = infor(j).ann;
end
