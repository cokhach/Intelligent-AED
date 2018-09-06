function [signal] = filtering(data,sampfreq)

% 5 order moving average filtering
   B = 1/5*ones(5,1);   
% 1 Hz high-pass to remove baseline wander
  [b a]=butter(1,1/(sampfreq/2),'high');
% 30 Hz low-pass to remove high frequency noise
  [bb aa]=butter(2,30/(sampfreq/2));

%-------------------------PRE-PROCESSING-----------------------------------
% 1) Mean subtraction
  %signal = detrend(signal);
% 2) 5-order moving average filtering to smooth the signals
  data = filtfilt(B,1,data);  
% 3) Order 1th Butterworth low pass filter to remove noise, asytole ...
  data = filtfilt(b,a,data);
% 4) high-pass filter to remove high interference
  signal = filtfilt(bb,aa,data);
