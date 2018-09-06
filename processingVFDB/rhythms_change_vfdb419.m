function ann_out = rhythms_change_vfdb419(ann,type)

    infor(1).ann = 1; infor(1).type = type{1};
    infor(2).ann = ann(1); infor(2).type = type{1};
    infor(3).ann = 8249; infor(3).type = '(VT';
    infor(4).ann = 8622; infor(4).type = '(N';
    
for i=5:6  infor(i).ann = ann(i-3); infor(i).type = type{i-3}; end

    infor(7).ann = 11604; infor(7).type = '(VT';
    infor(8).ann = 11942; infor(8).type = '(N';
    infor(9).ann = 12146; infor(9).type = '(VT';
    infor(10).ann = 12687; infor(10).type = '(N';
    infor(11).ann = 16526; infor(11).type = '(VT';
    infor(12).ann = 16905; infor(12).type = '(N';    
    
for i=13:70  infor(i).ann = ann(i-9); infor(i).type = type{i-9}; end    
    
    infor(71).ann = 258431; infor(71).type = '(VT';
    infor(72).ann = 260449; infor(72).type = '(NOISE';
    infor(73).ann = 267082; infor(73).type = '(N';
    infor(74).ann = 289529; infor(74).type = '(VF';
    infor(75).ann = 293665; infor(75).type = '(N';
    infor(76).ann = 293889; infor(76).type = '(NOISE';
    infor(77).ann = 294322; infor(77).type = '(N';
    infor(78).ann = 306236; infor(78).type = '(NOISE';    
    infor(79).ann = 312977; infor(79).type = '(VT';
    infor(80).ann = 316746; infor(80).type = '(NOISE';
    infor(81).ann = 317567; infor(81).type = '(N';
    infor(82).ann = 326151; infor(82).type = '(NOISE';   
    infor(83).ann = 345217; infor(83).type = '(VFL';
    infor(84).ann = 354804; infor(84).type = '(N';
    infor(85).ann = 363754; infor(85).type = '(VT';
    infor(86).ann = 364279; infor(86).type = '(N';
    infor(87).ann = 367549; infor(87).type = '(VT';
    infor(88).ann = 369042; infor(88).type = '(NOISE';
    infor(89).ann = 377131; infor(89).type = '(VT';
    infor(90).ann = 377750; infor(90).type = '(NOISE';    
    infor(91).ann = 388774; infor(91).type = '(VT';
    infor(92).ann = 391040; infor(92).type = '(NOISE';
    infor(93).ann = 391821; infor(93).type = '(VT';
    infor(94).ann = 393650; infor(94).type = '(NOISE';        
    
    
 for i=95:100  infor(i).ann = ann(i-31); infor(i).type = type{i-31}; end  
 
  
for j=1:length(infor)
  ann_out(j).type = infor(j).type;
  ann_out(j).sampNum = infor(j).ann;
end
