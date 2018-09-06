function ann_out = rhythms_change_vfdb610(ann,type)

    infor(1).ann = 1; infor(1).type = '(HGEA';
    
for i=2:3  infor(i).ann = ann(i-1); infor(i).type = type{i-1}; end
        
    infor(4).ann = 49219; infor(4).type = '(VT';
    infor(5).ann = 49820; infor(5).type = '(HGEA';    
    
for i=6:7  infor(i).ann = ann(i-3); infor(i).type = type{i-3}; end   

    infor(8).ann = 70994; infor(8).type = '(VT';
    infor(9).ann = 71477; infor(9).type = '(HGEA';
    infor(10).ann = 74579; infor(10).type = '(VT';
    infor(11).ann = 75310; infor(11).type = '(HGEA';
    
for i=12:15  infor(i).ann = ann(i-7); infor(i).type = type{i-7}; end
    
    infor(16).ann = 114946; infor(16).type = '(VT';
    infor(17).ann = 115740; infor(17).type = '(HGEA';
    
for i=18:23  infor(i).ann = ann(i-9); infor(i).type = type{i-9}; end    
    
    infor(24).ann = 205489; infor(24).type = '(VT';
    infor(25).ann = 206935; infor(25).type = '(HGEA';
    infor(26).ann = 208189; infor(26).type = '(VT';
    infor(27).ann = 208885; infor(27).type = '(HGEA';
    infor(28).ann = 210791; infor(28).type = '(VT';
    infor(29).ann = 211400; infor(29).type = '(HGEA';    
    
for i=30:33  infor(i).ann = ann(i-15); infor(i).type = type{i-15}; end  

    infor(34).ann = 229951; infor(34).type = '(NOISE';
    infor(35).ann = 250307; infor(35).type = '(N';
    infor(36).ann = 256251; infor(36).type = '(NOISE';
    infor(37).ann = 258212; infor(37).type = '(N';
    infor(38).ann = 270614; infor(38).type = '(NOISE';
    infor(39).ann = 281712; infor(39).type = '(N';    
    infor(40).ann = 282834; infor(40).type = '(NOISE';
    infor(41).ann = 299627; infor(41).type = '(N';
    infor(42).ann = 324424; infor(42).type = type{19};
    infor(43).ann = 328324; infor(43).type = '(VT';
    infor(44).ann = 329310; infor(44).type = '(HGEA';
    infor(45).ann = 329804; infor(45).type = '(VT';    
    infor(46).ann = 330455; infor(46).type = '(HGEA';
    infor(47).ann = 335964; infor(47).type = '(VT';
    infor(48).ann = 336437; infor(48).type = '(HGEA';    

for i=49:52  infor(i).ann = ann(i-29); infor(i).type = type{i-29}; end  

    infor(53).ann = 456659; infor(53).type = '(VT';
    infor(54).ann = 457040; infor(54).type = '(HGEA';   

for i=55:56  infor(i).ann = ann(i-31); infor(i).type = type{i-31}; end  

    infor(57).ann = 473844; infor(57).type = '(VT';
    infor(58).ann = 474317; infor(58).type = '(HGEA';
    infor(59).ann = 475269; infor(59).type = '(VT';    
    infor(60).ann = 475920; infor(60).type = '(HGEA';
    infor(61).ann = ann(26); infor(61).type = type{26};
    

for j=1:length(infor)
  ann_out(j).type = infor(j).type;
  ann_out(j).sampNum = infor(j).ann;
end
