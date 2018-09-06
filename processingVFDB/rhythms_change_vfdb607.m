function ann_out = rhythms_change_vfdb607(ann,type)

    infor(1).ann = 1; infor(1).type = '(NOD';
    
for i=2:4  infor(i).ann = ann(i-1); infor(i).type = type{i-1}; end
        
    infor(5).ann = 346796; infor(5).type = '(VT';
    infor(6).ann = 347652; infor(6).type = '(NOD';
    
    infor(7).ann = ann(4); infor(7).type = type{4};
    infor(8).ann = 398064; infor(8).type = '(VF';
    
for i=9:14  infor(i).ann = ann(i-4); infor(i).type = type{i-4}; end
    
for j=1:length(infor)
  ann_out(j).type = infor(j).type;
  ann_out(j).sampNum = infor(j).ann;
end
