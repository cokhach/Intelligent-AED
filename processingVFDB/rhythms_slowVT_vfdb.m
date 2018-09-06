function labels = rhythms_slowVT_vfdb(ecg,th)

labels = 21*ones( size(ecg) ) ;
level=0.01;

%if episode_number == 418 level = 0.01; end
%if episode_number == 607 level = 0.05; end
%if episode_number == 609 level = 0.05; end
%if episode_number == 610 level = 0.05; end
%if episode_number == 611 level = 0.5; end
%if episode_number == 612 level = 0.05; end
fs   = 250;
R    = peakdet(ecg./max(abs(ecg)), level );
rloc = R(:,1); tloc = rloc./fs; 

bpmo  = 60./diff(tloc);
bpma = [bpmo(1); bpmo; bpmo(end)];
if length(bpma) < 10
    bpm  = medfilt1(bpma,length(bpma)); 
else
    bpm  = medfilt1(bpma,10); 
end
bpm  = bpm(2:end-1);

%--- Slow TV detection

slowTV = bpm <= th;

if ~isempty( find(slowTV) )
    
    changes = [slowTV(1) diff(slowTV')];
    
    start = find(changes==1);
    stop  = find(changes==-1);
        
    if start(1)==1
        start_samples = [1; rloc( start(2:end)-1 )];
        stop_samples  = rloc( stop-1 );
    else
        start_samples = rloc( start-1 );
        stop_samples  = rloc( stop-1 );
    end
    
    if length(stop_samples) < length(start_samples)
        stop_samples = [stop_samples; length(labels)];
    end
    
    N = length(start_samples);
    for k=1:N
        label_index = start_samples(k):stop_samples(k);
        labels(label_index) = 22;           
    end  
end