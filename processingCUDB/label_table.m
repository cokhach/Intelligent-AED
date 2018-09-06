function label = label_table(slabel) 

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

label = find( strcmp(cases,slabel) );

% Special cases: 10, 19 and 13 can be also referred as 
if isempty(label)
    
    if strcmp('(NSR',slabel) || strcmp('(N',slabel)
        label = 10;
    elseif strcmp('(VF',slabel) || strcmp('(VFIB',slabel)
        label = 19;
    elseif strcmp('(VT',slabel)
        label = 21;    
     elseif strcmp('(sTV',slabel)
        label = 22;        
    elseif strcmp('(PM',slabel)
        label = 13;
    elseif strcmp('(AF',slabel) || strcmp('(AFIB',slabel)  % for CUDB
        label = 2;
    elseif strcmp('(NOISE',slabel)
        label = 12;  
     elseif strcmp('(ASYS',slabel)
        label = 4;        
    else
        msg = sprintf('This is classified as other rythms %s',slabel);
        disp(msg)
        label = 23;
        % others, not really rhythms: PSE, MISSB at MITDB
    end
end