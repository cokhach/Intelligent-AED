function ann_out = rhythms_change_vfdb423(ann,type)

    infor(1).ann = 1; infor(1).type = '(N';
    infor(2).ann = 47609; infor(2).type = '(ASYS'; 
    infor(3).ann = 48850; infor(3).type = '(N'; 
    
for i=4:6  infor(i).ann = ann(i-2); infor(i).type = type{i-2}; end    
    
    infor(7).ann = 338511; infor(7).type = '(NOISE';
    infor(8).ann = 342692; infor(8).type = '(NOD';    
 
 for i=9:13  infor(i).ann = ann(i-1); infor(i).type = type{i-1}; end

    infor(14).ann = 438369; infor(14).type = '(N';
       
for j=1:length(infor)
  ann_out(j).type = infor(j).type;
  ann_out(j).sampNum = infor(j).ann;
end
