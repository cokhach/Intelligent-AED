function ann_out = rhythms_change_vfdb424(ann,type)

    infor(1).ann = 1; infor(1).type = '(N';
    infor(2).ann = ann(2); infor(2).type = type{2}; 
    infor(3).ann = 341101; infor(3).type = '(NOISE'; 
    infor(4).ann = 347677; infor(4).type = '(NOD';
    
for i=5:6  infor(i).ann = ann(i+1); infor(i).type = type{i+1}; end        
    
    infor(7).ann = 383416; infor(7).type = '(NOISE';    
    infor(8).ann = ann(9); infor(8).type = type{9};
    infor(9).ann = 386177; infor(9).type = '(VF';
    infor(10).ann = 396354; infor(10).type = '(NOISE';
    infor(11).ann = 398432; infor(11).type = '(NOD';   
    infor(12).ann = 411462; infor(12).type = '(N';
    infor(13).ann = 457509; infor(13).type = '(NOISE';
       
for j=1:length(infor)
  ann_out(j).type = infor(j).type;
  ann_out(j).sampNum = infor(j).ann;
end
