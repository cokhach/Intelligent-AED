function ann_out = rhythms_change_vfdb427   %(ann,type)

    infor(1).ann = 1; infor(1).type = '(N';
    infor(2).ann = 162290; infor(2).type = '(VT'; 
    infor(3).ann = 322866; infor(3).type = '(fineVF'; 
    infor(4).ann = 323415; infor(4).type = '(VT';     
      infor(5).ann = 359819; infor(5).type = '(fineVF'; 
    infor(6).ann = 360897; infor(6).type = '(VT'; 
    infor(7).ann = 365146; infor(7).type = '(fineVF';
    infor(8).ann = 365552; infor(8).type = '(VT'; 
    infor(9).ann = 370229; infor(9).type = '(fineVF'; 
    infor(10).ann = 371307; infor(10).type = '(VT';
    infor(11).ann = 383254; infor(11).type = '(N'; 
    infor(12).ann = 427710; infor(12).type = '(ASYS'; 
      
for j=1:length(infor)
  ann_out(j).type = infor(j).type;
  ann_out(j).sampNum = infor(j).ann;
end
