function h = Zjr_Bandpass_Filter(fb, L, fs)
% @ 夏天是冰红茶
% Zjr_Bandpass_Filter Generate a bandpass filter based on given parameters
% fb: Center frequency of the bandpass filter
% L: Length of the filter
% fs: Sampling frequency
if nargin < 3  
   % 如果没有提供fs，则使用默认值8000  
   fs = 8000;  
end 
n = 0:L-1;
h = (2 / L) * cos(2 * pi * fb * n / fs);
end