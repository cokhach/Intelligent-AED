function ann_out = rhythms_change_vfdb612

    infor(1).ann = 1; infor(1).type = '(N';      
    infor(2).ann = 10534; infor(2).type = '(NOISE';   
    infor(3).ann = 14065; infor(3).type = '(N';      
    infor(4).ann = 275671; infor(4).type = '(NOISE';   
    infor(5).ann = 276737; infor(5).type = '(N';      
    infor(6).ann = 369986; infor(6).type = '(NOISE';   
    infor(7).ann = 370857; infor(7).type = '(N';      
    infor(8).ann = 425601; infor(8).type = '(VT';   
    infor(9).ann = 427086; infor(9).type = '(N';      
    infor(10).ann = 428037; infor(10).type = '(VT';       
    
    infor(11).ann = 431511; infor(11).type = '(VF';      
      
    infor(12).ann = 435654; infor(12).type = '(NOISE';      
    infor(13).ann = 435807; infor(13).type = '(VT';       
    
    infor(14).ann = 438164; infor(14).type = '(VF';      
    infor(15).ann = 477776; infor(15).type = '(NOISE';   
    infor(16).ann = 478210; infor(16).type = '(VF';      
    infor(17).ann = 489714; infor(17).type = '(NOISE';          
    
    infor(18).ann = 493365; infor(18).type = '(VT';      
    infor(19).ann = 500289; infor(19).type = '(NOISE';   
    infor(20).ann = 501044; infor(20).type = '(VF';     
    
for j=1:length(infor)
  ann_out(j).type = infor(j).type;
  ann_out(j).sampNum = infor(j).ann;
end
