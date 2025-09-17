function ss = dtmfscor(xx, freq, L, fs)
% @ 夏天是冰红茶
% DTMFSCOR
% ss = dtmfscor(xx, freq, L, [fs])
% return 1(true) if freq is present in xx
% 0(false) if freq is not present in xx
% xx = input DTMF signal
% freq = test frequency
% L = length of FIR bandpass filter
% fs = sampling frequency (default is 8k)
% The signal detection is done by filtering xx with a length-L
% BPF, hh, squaring the output, and comparing with an arbitrary
% set point based on the average power of xx

if nargin < 4
    fs = 8000;
end

hh = Zjr_Bandpass_Filter(freq, L, fs);
filtered_signal = conv(xx, hh, 'same');
% 计算平方滤波信号的平均功率
squared_signal = filtered_signal .^ 2;
mean_squared_signal = mean(squared_signal);
% 计算原始信号的平均功率
mean_original_signal = mean(xx .^ 2);
% 滤波信号的平均功率与阈值进行比较
threshold = mean_original_signal / 5;
ss = (mean_squared_signal > threshold);

end
