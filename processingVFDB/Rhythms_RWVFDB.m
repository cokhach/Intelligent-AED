% MIT Malignant Ventricular Ectopy Database processing, 
% http://www.physionet.org/physiobank/database/vfdb/

clear; close all;  clc;

addpath('./processingVFDB')
addpath('S:/public_codes/data/')
signal_ref  = [418:430 602 605 607 609:612 614 615];

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
    '(fineVF';...   %24 
    '(AF';...       %25
    '(NSR';...      %26
    '(PM';...       %27
    '(VFIB'};       %28

% We consider rapid VT (>150bpm) and slow VT, therefore we create a new
% case after preprocessing, VT (label = 21) and VTslow (label = 22)
threshold = 150; % bpm

for i=1:1%length(signal_ref) 
    
    %--- read ECG
    ecgName = [num2str(signal_ref(i))]; disp(ecgName)
    
    % Read comments instead of annotations
    [ann,~,~,~,~,comments] = rdann(ecgName,'atr');
     for k=1:length(ann)
         com{k} = char(comments{k});
     end
    
     ann_out = rhythms_change_vfdb(i,ann,com);
        
    fs   = 250;
    [r,~,tm] = rdsamp(ecgName); 
    
    time = tm./fs; % in minute
    
    labels = zeros(size(time));
    
    ecga  = r(:,1);
    ecga  = ecga-mean(ecga);
    ecga = filtering(ecga,fs);
   %--- label assignment
    L = length(ann_out);
          
    for j=1:L
                
        label = label_table_VFDB(ann_out(j).type);        
        
        start = ann_out(j).sampNum;
        if j<L
            stop  = ann_out(j+1).sampNum-1;
        else
            stop  = length(labels);     
        end
        
        %VT assignment (VT and VTslow)
        if strcmp('(VT',ann_out(j).type)
            verbose = 0;
            label = rhythms_slowVT_vfdb(ecga(start:stop),threshold);                 
        end      
        
        labels(start:stop) = label;        
    end
    loc = find((labels==4) | (labels==12) | (labels==22) | (labels==24));
    labels(loc) = [];
    ecga(loc,:)=[];
            
    processed_vfdb(i).name  = num2str(signal_ref(i));
    processed_vfdb(i).ecg   = ecga;
    processed_vfdb(i).label = labels;
    processed_vfdb(i).fs    = fs;
    processed_vfdb(i).leads = {'ECG0'};       
end
savepath = 'S:/public_codes/data/';
filename = 'processed_vfdb.mat';
save([savepath filename],'processed_vfdb');
