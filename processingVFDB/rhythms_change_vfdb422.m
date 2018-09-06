function ann_out = rhythms_change_vfdb422(ann,type)

    infor(1).ann = 1; infor(1).type = type{1};
    
for i=2:4  infor(i).ann = ann(i-1); infor(i).type = type{i-1}; end    
    
    infor(5).ann = 73479; infor(5).type = '(NOISE';
    infor(6).ann = 74147; infor(6).type = '(N';    
 
 for i=7:10  infor(i).ann = ann(i-3); infor(i).type = type{i-3}; end

    infor(11).ann = 125471; infor(11).type = '(NOISE';
    infor(12).ann = 129057; infor(12).type = '(N';
    
 for i=13:24  infor(i).ann = ann(i-5); infor(i).type = type{i-5}; end    
    
    infor(25).ann = 312446; infor(25).type = '(NOISE';
    infor(26).ann = 321810; infor(26).type = '(N';
    
for i=27:28  infor(i).ann = ann(i-7); infor(i).type = type{i-7}; end        
    
    infor(29).ann = 333943; infor(29).type = '(VT';
    infor(30).ann = 381924; infor(30).type = '(VF';
    
for i=31:35  infor(i).ann = ann(i-6); infor(i).type = type{i-6}; end            
        
for j=1:length(infor)
  ann_out(j).type = infor(j).type;
  ann_out(j).sampNum = infor(j).ann;
end
