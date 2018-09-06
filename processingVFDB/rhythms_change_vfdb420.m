function ann_out = rhythms_change_vfdb420(ann,type)

    infor(1).ann = 1; infor(1).type = type{1};
    
for i=2:3  infor(i).ann = ann(i-1); infor(i).type = type{i-1}; end    
    
    infor(4).ann = 50519; infor(4).type = '(N';
    infor(5).ann = 66727; infor(5).type = '(NOISE';
    infor(6).ann = ann(3); infor(6).type = type{3};
    infor(7).ann = 357539; infor(7).type = '(VT';
  
    for i=8:11  infor(i).ann = ann(i-3); infor(i).type = type{i-3}; end

    infor(12).ann = 420796; infor(12).type = '(NOISE';
    infor(13).ann = 422305; infor(13).type = '(VT';
    infor(14).ann = ann(9); infor(14).type = type{9};
    infor(15).ann = 441126; infor(15).type = '(N';
    
  
for j=1:length(infor)
  ann_out(j).type = infor(j).type;
  ann_out(j).sampNum = infor(j).ann;
end
