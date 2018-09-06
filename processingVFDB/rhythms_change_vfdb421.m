function ann_out = rhythms_change_vfdb421(ann,type)

    infor(1).ann = 1; infor(1).type = type{1};
    
for i=2:8  infor(i).ann = ann(i-1); infor(i).type = type{i-1}; end    
    
    infor(9).ann = 36699; infor(9).type = '(NOISE';
    infor(10).ann = 37115; infor(10).type = '(N';
    infor(11).ann = ann(8); infor(11).type = type{8};    
    infor(12).ann = 62520; infor(12).type = '(N';
    
 for i=13:20  infor(i).ann = ann(i-3); infor(i).type = type{i-3}; end

    infor(21).ann = 98801; infor(21).type = '(NOISE';
    infor(22).ann = 99820; infor(22).type = '(N';
    
 for i=23:26  infor(i).ann = ann(i-5); infor(i).type = type{i-5}; end    
    
    infor(27).ann = 119451; infor(27).type = '(NOISE';
    infor(28).ann = 120315; infor(28).type = '(N';
    
for i=29:30  infor(i).ann = ann(i-7); infor(i).type = type{i-7}; end        
    
    infor(31).ann = 166999; infor(31).type = '(NOISE';
    infor(32).ann = 167582; infor(32).type = '(N';
    
for i=33:35  infor(i).ann = ann(i-9); infor(i).type = type{i-9}; end            
    
    infor(36).ann = 223675; infor(36).type = '(VT';
 
for i=37:51  infor(i).ann = ann(i-8); infor(i).type = type{i-8}; end            
    
    infor(52).ann = 234026; infor(52).type = '(VT';
    
for i=53:56  infor(i).ann = ann(i-8); infor(i).type = type{i-8}; end    

    infor(57).ann = 237146; infor(57).type = '(NOISE';
    infor(58).ann = 237440; infor(58).type = '(VT';
    
for i=59:71  infor(i).ann = ann(i-8); infor(i).type = type{i-8}; end        

    infor(72).ann = 255454; infor(72).type = '(NOISE';
    infor(73).ann = 257110; infor(73).type = '(N';

for i=74:78  infor(i).ann = ann(i-10); infor(i).type = type{i-10}; end        
    
    infor(79).ann = 283574; infor(79).type = '(NOISE';
    infor(80).ann = 284432; infor(80).type = '(VT';
    
for i=81:126  infor(i).ann = ann(i-12); infor(i).type = type{i-12}; end         
    
    infor(127).ann = 315124; infor(127).type = '(NOISE';
    infor(128).ann = 316846; infor(128).type = '(VT';
    infor(129).ann = 319109; infor(129).type = '(N';
    infor(130).ann = 319589; infor(130).type = '(VT';
    infor(131).ann = 320996; infor(131).type = '(N';
    infor(132).ann = 321374; infor(132).type = '(VT';
    infor(133).ann = 322844; infor(133).type = '(N';
    infor(134).ann = 323226; infor(134).type = '(VT';
    infor(135).ann = 324719; infor(135).type = '(N';
    infor(136).ann = 325101; infor(136).type = '(VT';
    infor(137).ann = 327024; infor(137).type = '(N';
    infor(138).ann = 327356; infor(138).type = '(VT';
    infor(139).ann = 329004; infor(139).type = '(N';
    infor(140).ann = 329610; infor(140).type = '(VT';
    infor(141).ann = 331479; infor(141).type = '(N';
    infor(142).ann = 332696; infor(142).type = '(VT';
    infor(143).ann = 351174; infor(143).type = '(N';
    infor(144).ann = 507348; infor(144).type = '(NOISE';
    infor(145).ann = 511925; infor(145).type = '(N';
    infor(146).ann = 523679; infor(146).type = '(NOISE';
    
for j=1:length(infor)
  ann_out(j).type = infor(j).type;
  ann_out(j).sampNum = infor(j).ann;
end
