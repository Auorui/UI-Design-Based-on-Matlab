function key = dtmfdeco(xx, L, fs)
% @ 夏天是冰红茶
% DTMFDECO key = dtmfdeco(xx, [fs])
% returns the key number corresponding to the DTMF waveform, xx
% fs = sampling freq (default = 8k Hz if not specified)

if nargin < 2
    fs = 8000;
end

% 定义DTMF音调的频率
low_freqs = [697, 770, 852, 941];  
high_freqs = [1209, 1336, 1477, 1633];

% 数字序列行列索引
dtmf_map = [1, 1; 1, 2; 1, 3;  % 1, 2, 3
            2, 1; 2, 2; 2, 3;  % 4, 5, 6
            3, 1; 3, 2; 3, 3;  % 7, 8, 9
            4, 2; 4, 1; 4, 3]; % 0, *, #

% 初始化检测结果
low_detected = false(length(low_freqs), 1);
high_detected = false(length(high_freqs), 1);

% 检测低频分量
for i = 1:length(low_freqs)
    if dtmfscor(xx, low_freqs(i), L, fs)
        low_detected(i) = true;
    end
end

% 检测高频分量
for i = 1:length(high_freqs)
    if dtmfscor(xx, high_freqs(i), L, fs)
        high_detected(i) = true;
    end
end

% 找到检测到的低频和高频索引
low_idx = find(low_detected);
high_idx = find(high_detected);

% 确保每次只检测到一个低频和一个高频
if isscalar(low_idx) && isscalar(high_idx)
    key = find(ismember(dtmf_map, [low_idx, high_idx], 'rows'));
else
    key = [];
end

end
