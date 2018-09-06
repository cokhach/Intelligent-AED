function ann_out = rhythms_change_vfdb605(ann,type)

    infor(1).ann = 1; infor(1).type = '(NOISE';
    infor(2).ann = ann(2); infor(2).type = type{2};
    infor(3).ann = 418411; infor(3).type = '(NOISE';
       
for j=1:length(infor)
  ann_out(j).type = infor(j).type;
  ann_out(j).sampNum = infor(j).ann;
end
