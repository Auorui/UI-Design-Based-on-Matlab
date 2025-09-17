function tones = dtmfdial(nums)
% @ 夏天是冰红茶
% DTMFDIAL Create a vector of tones which will dial 
% a DTMF (Touch Tone) telephone system
% usage: tones = dtmfdial(nums)
% nums = vector of numbers ranging from 1 to 12
% tones = vector containing the corresponding tones

if nargin < 1
    error('DTMFDIAL requires one input');
end 

output_signal = [];

% 定义DTMF音调的频率
low_freqs = [697, 770, 852, 941];  
high_freqs = [1209, 1336, 1477, 1633];

% 数字序列行列索引
dtmf_map = [1, 1; 1, 2; 1, 3;  % 1, 2, 3
            2, 1; 2, 2; 2, 3;  % 4, 5, 6
            3, 1; 3, 2; 3, 3;  % 7, 8, 9
            4, 2; 4, 1; 4, 3]; % 0, *, #

% Define parameters
fs = 8000;         
duration = 0.5; 
pause_time = 0.1;

t_tone = 0:1/fs:duration - 1/fs;
t_pause = 0:1/fs:pause_time - 1/fs;

% 暂停静音
silence = zeros(size(t_pause));

% 给每个号码生成DTMF音调
for i = 1:length(nums)
    num = nums(i);
    if num < 1 || num > 12
        error('Number sequence must contain values between 1 and 12');
    end
    % 获取DTMF映射的相应行、列索引
    row = dtmf_map(num, 1);
    col = dtmf_map(num, 2);
    % 生成DTMF音调
    tone = sin(2*pi*low_freqs(row)*t_tone) + sin(2*pi*high_freqs(col)*t_tone);
    
    output_signal = [output_signal, tone, silence];
end
tones = output_signal;
end
