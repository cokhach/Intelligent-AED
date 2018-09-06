function ann_out = rhythms_change_vfdb426(ann,type)

    infor(1).ann = 1; infor(1).type = '(N';
    infor(2).ann = 161433; infor(2).type = '(VF'; 
    infor(3).ann = 171866; infor(3).type = '(fineVF'; 
    infor(4).ann = 186397; infor(4).type = '(VF'; 
        
 for i=5:6  infor(i).ann = ann(i-2); infor(i).type = type{i-2}; end 
 
    infor(7).ann = 351831; infor(7).type = '(NOISE'; 
    infor(8).ann = 352397; infor(8).type = '(VF'; 
    
 for i=9:11  infor(i).ann = ann(i-4); infor(i).type = type{i-4}; end           

    infor(12).ann = 418331; infor(12).type = '(N'; 
    infor(13).ann = 435255; infor(13).type = '(VT'; 
    
for i=14:16  infor(i).ann = ann(i-4); infor(i).type = type{i-4}; end        
    
    infor(17).ann = 458516; infor(17).type = '(VT'; 
    infor(18).ann = 459820; infor(18).type = '(SVTA'; 
    infor(19).ann = 468004; infor(19).type = '(VF'; 
    infor(20).ann = 477696; infor(20).type = '(NOISE';
    infor(21).ann = 499754; infor(21).type = '(N';   
      
for j=1:length(infor)
  ann_out(j).type = infor(j).type;
  ann_out(j).sampNum = infor(j).ann;
end
