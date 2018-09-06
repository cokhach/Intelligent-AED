% Creighton University Ventricular Tachyarrhythmia Database processing
% http://www.physionet.org/physiobank/database/cudb/

clear; close all; clc;

addpath('./processingCUDB')
addpath('S:/public_codes/data/')
path        = 'cu';
signal_ref  = [1:35];

cases = {...
    '(AB';...       %1
    '(AFIB';...     %2
    '(AFL';...      %3
    '(ASYS';...     %4      
    '(B';...        %5
    '(BI';...       %6
    '(BII';...      %7
    '(HGEA';...     %8
    '(IVR';...      %9
    '(N';...        %10
    '(NOD';...      %11
    '(NOISE';...    %12     
    '(P';...        %13
    '(PREX';...     %14
    '(SBR';...      %15
    '(SVTA';...     %16
    '(T';...        %17
    '(VER';...      %18
    '(VF';...       %19
    '(VFL';...      %20
    '(VT';...       %21
    '(sTV';...      %22
    '(others';...   %23     
    '(fineVF'};     %24 

for i=1:1%length(signal_ref) 

    
    %--- read ECG
    if i < 10
       ecgName = [path '0' num2str(signal_ref(i))]; disp(ecgName)       
    else
        ecgName = [path num2str(signal_ref(i))]; disp(ecgName)
    end
    
    [ann,type]=rdann(ecgName,'atr');
        
    ann_out  = rhythms_change_cudb(i,ann,type);
        
    fs   = 250;
    [r,~,tm] = rdsamp(ecgName); 
    
    if i == 27
        r = r(4616:end);              
    end
    
    r = rhythms_not_values(r); 
    
    time = tm(:,1)./fs;
    labels = zeros(size(time)); % label for each sample
    ecg  = r(:); 
    ecg = ecg-mean(ecg);
   
    %---
   
       
    %--- label assignmnet 
    L = length(ann_out);
    for j=1:L
        
        label = label_table(ann_out(j).type);

        start = ann_out(j).sampNum;
        if j<L
            stop  = ann_out(j+1).sampNum-1;
        else
            stop  = length(labels);     
       end
        
        labels(start:stop) = label;
       
    end
    
    if i == 27
        ecg = [zeros(4615,1); ecg];
    end
      
    samples = artifact_removal(i,length(ecg));
    
    ecgr     = ecg(samples); size(ecgr)
    labels  = labels(samples);
    tiempo    = 0:1/fs:(length(ecgr)-1)/fs;
    
    ecga = filtering(ecgr,fs);    

    processed_cudb(i).name  = ecgName(1:end);
    processed_cudb(i).ecg   = ecga;
    processed_cudb(i).label = labels;
    processed_cudb(i).fs    = fs;
    processed_cudb(i).leads = 'ECG1';
    %---
    
end
savepath = 'S:/public_codes/data/';
filename = 'processed_cudb.mat';
save([savepath filename],'processed_cudb');