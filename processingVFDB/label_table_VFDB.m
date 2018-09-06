function label = label_table_VFDB(sslabel) 


    if strcmp('(AFIB',sslabel)
        slabel = '(AF';
    elseif strcmp('(NSR',sslabel)   
        slabel = '(N';
    elseif strcmp('(P',sslabel)
        slabel = '(PM';
    elseif strcmp('(VFIB',sslabel) 
        slabel = '(VF'; %#ok<*AGROW>
    else
        slabel = sslabel;
    end


cases = {...
    '(AB';...       %1
    '(AF';...       %2
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
    '(PM';...       %13     
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

%    '(AFIB';...     %25
%    '(NSR';...      %26
%    '(P';...       %27
%    '(VFIB'};       %28

label = find( strcmp(cases,slabel) );

 
if isempty(label)
    
    if strcmp('(AB',slabel)
        label = 1;
    elseif strcmp('(AF',slabel)
        label = 2;   
%    elseif strcmp('AFIB',slabel)
%        label = 2;        
    elseif strcmp('(AFL',slabel)
        label = 3;
    elseif strcmp('(ASYS',slabel)
        label = 4;    
    elseif strcmp('(B',slabel)
        label = 5;
    elseif strcmp('(BI',slabel)
        label = 6;        
    elseif strcmp('(BII',slabel)
        label = 7;
    elseif strcmp('(HGEA',slabel)
        label = 8;    
    elseif strcmp('(IVR',slabel)
        label = 9;
 %   elseif strcmp('(NSR',slabel)
 %       label = 26;   
    elseif strcmp('(N',slabel)
        label = 10;        
    elseif strcmp('(NOD',slabel)
        label = 11;
    elseif strcmp('(NOISE',slabel)
        label = 12;    
%    elseif strcmp('(P',slabel)
%        label = 13;
    elseif strcmp('PM',slabel)
        label = 13;
    elseif strcmp('(PREX',slabel)
        label = 14;        
    elseif strcmp('(SBR',slabel)
        label = 15;
    elseif strcmp('(SVTA',slabel)
        label = 16;    
    elseif strcmp('(T',slabel)
        label = 17;    
    elseif strcmp('(VER',slabel)
        label = 18;        
%    elseif strcmp('(VFIB',slabel)
%        label = 28;    
    elseif strcmp('(VF',slabel)
        label = 19;    
    elseif strcmp('(VFL',slabel)
        label = 20;    
    elseif strcmp('(VT',slabel)
        label = 21;     
    elseif strcmp('(sTV',slabel)
        label = 22;          
    elseif strcmp('(fineVF',slabel)
        label = 24;       
    else
        msg = sprintf('This is classified as other rythms %s',slabel);
        disp(msg)
        label = 23;
        % others, not really rhythms: PSE, MISSB at MITDB    
    end
 
end