function ann_out = rhythms_change_vfdb611(ann,type)

    infor(1).ann = 1; infor(1).type = '(SVTA';      
    infor(2).ann = ann(2); infor(2).type = type{2};   

for j=1:length(infor)
  ann_out(j).type = infor(j).type;
  ann_out(j).sampNum = infor(j).ann;
end
