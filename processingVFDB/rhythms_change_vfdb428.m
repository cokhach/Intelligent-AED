function ann_out = rhythms_change_vfdb428(ann,type)

    infor(1).ann = 1; infor(1).type = '(BI';
    
 for i=2:9  infor(i).ann = ann(i); infor(i).type = type{i}; end 
       
for j=1:length(infor)
  ann_out(j).type = infor(j).type;
  ann_out(j).sampNum = infor(j).ann;
end
