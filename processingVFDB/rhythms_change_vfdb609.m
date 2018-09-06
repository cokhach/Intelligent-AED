function ann_out = rhythms_change_vfdb609(ann,type)

    infor(1).ann = 1; infor(1).type = '(AFIB';
    
for i=2:8  infor(i).ann = ann(i); infor(i).type = type{i}; end
        
    infor(9).ann = 318540; infor(9).type = '(VT';
    infor(10).ann = 319126; infor(10).type = '(HGEA';    
    infor(11).ann = 319460; infor(11).type = '(VT';
    infor(12).ann = 320904; infor(12).type = '(HGEA';
    
for i=13:16  infor(i).ann = ann(i-4); infor(i).type = type{i-4}; end
    
for j=1:length(infor)
  ann_out(j).type = infor(j).type;
  ann_out(j).sampNum = infor(j).ann;
end
