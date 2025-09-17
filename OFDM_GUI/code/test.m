clear all;
close all;

% OFDM仿真参数
carrier_count = 200;    % 子载波数
symbol_count = 100;     % 总符号数
ifft_length = 512;      % IFFT长度
CP_length = 128;        % 循环前缀长度
CS_length = 20;         % 循环后缀长度
alpha = 7/32;           % 升余弦窗系数
SNR = 20;               % 信噪比
rate = [];

% 选择调制方式：'QPSK'、'16QAM'、'64QAM'、'256QAM'
modulation_type = 'QPSK'; % 可以修改为 'QPSK', '64QAM', '256QAM'

switch modulation_type
    case 'QPSK'
        M = 4;
    case '16QAM'
        M = 16;
    case '64QAM'
        M = 64;
    case '256QAM'
        M = 256;
    otherwise
        error('Unsupported modulation type');
end

bit_per_symbol = log2(M);
bit_length = carrier_count * symbol_count * bit_per_symbol;

bit_sequence = randi([0, 1], bit_length, 1); 

% 绘制生成随机二进制序列
figure(1);
bar(bit_sequence(1:50), 'b');
xlabel('Bit Index');
ylabel('Bit Value');
title('Binary Source Code Distribution');
grid on;

% ================子载波调制方式========================
bit_moded = qammod(bit_sequence, M, 'InputType', 'bit', 'UnitAveragePower', true);
figure('position', [0 0 400 400]);
scatter(real(bit_moded), imag(bit_moded));
title(['调制后的散点图 - ', modulation_type]);
grid on;
% ===================IFFT===========================
% =================串并转换==========================
ifft_position = zeros(ifft_length, symbol_count);
bit_moded = reshape(bit_moded, carrier_count, []);
figure('position', [400 0 400 400]);
stem(abs(bit_moded(:, 1)));
grid on;

% 1-28置零 29-228有效 229-285置零 286-485共轭 486-512置零
carrier_position = 29:228;
conj_position = 485:-1:286;
ifft_position(carrier_position, :) = bit_moded;
ifft_position(conj_position, :) = conj(bit_moded);
signal_time = ifft(ifft_position, ifft_length);   % 512   100
figure('position', [0 400 400 400]);
subplot(3,1,1);
plot(signal_time(:, 1), 'b');
title('原始单个OFDM符号');
xlabel('Time');
ylabel('Amplitude');

% ==================加循环前缀和后缀==================
signal_time_C = [signal_time(end-CP_length+1:end, :); signal_time];
signal_time_C = [signal_time_C; signal_time_C(1:CS_length, :)];
subplot(3,1,2); % 单个完整符号为512+128+20=660
plot(signal_time_C(:, 1));
xlabel('Time');
ylabel('Amplitude');
title('加CP和CS的单个OFDM符号');

% =======================加窗========================
signal_window = signal_time_C .* repmat(rcoswindow(alpha, size(signal_time_C, 1)), 1, symbol_count);
subplot(3,1,3);
plot(signal_window(:, 1));
title('加窗后的单个OFDM符号');
xlabel('Time');
ylabel('Amplitude');
% ===================发送信号，多径信道====================
signal_Tx = reshape(signal_window, 1, []); % 时域完整信号
signal_origin = reshape(signal_time_C, 1, []); % 未加窗完整信号
mult_path_am = [1 0.2 0.1]; % 多径幅度
mutt_path_time = [0 20 50]; % 多径时延
path2 = 0.2 * [zeros(1, 20) signal_Tx(1:end-20)];
path3 = 0.1 * [zeros(1, 50) signal_Tx(1:end-50)];
signal_Tx_mult = signal_Tx + path2 + path3; % 多径信号

figure(5);
subplot(2,1,1);
plot(signal_Tx_mult);
title('多径下OFDM信号');
xlabel('Time/samples');
ylabel('Amplitude');
subplot(2,1,2);
plot(signal_Tx);
title('单径下OFDM信号');
xlabel('Time/samples');
ylabel('Amplitude');

% =====================发送信号频谱========================
% ====================未加窗信号频谱=======================
% 每个符号求频谱再平均，功率取对数
figure(6);
orgin_aver_power = 20 * log10(mean(abs(fft(signal_time_C'))));
subplot(2,1,1);
plot((1:length(orgin_aver_power)) / length(orgin_aver_power), orgin_aver_power);
hold on;
plot(0:1/length(orgin_aver_power):1, -35, 'rd');
hold off;
axis([0 1 -40 max(orgin_aver_power)]);
grid on;
title('未加窗信号频谱');
% ====================加窗信号频谱=========================
orgin_aver_power = 20 * log10(mean(abs(fft(signal_window'))));
subplot(2,1,2);
plot((1:length(orgin_aver_power)) / length(orgin_aver_power), orgin_aver_power);
hold on;
plot(0:1/length(orgin_aver_power):1, -35, 'rd');
hold off;
axis([0 1 -40 max(orgin_aver_power)]);
grid on;
title('加窗信号频谱');

% ========================加AWGN==========================
Rx_data_sig = awgn(signal_Tx, SNR, 'measured'); % 向单径信号添加噪声
Rx_data_mut = awgn(signal_Tx_mult, SNR, 'measured'); % 向多径信号添加噪声

% =======================串并转换==========================
Rx_data_mut = reshape(Rx_data_mut, ifft_length + CS_length + CP_length, []);
Rx_data_sig = reshape(Rx_data_sig, ifft_length + CS_length + CP_length, []);

% ====================去循环前缀和后缀======================
Rx_data_sig(1:CP_length, :) = [];
Rx_data_sig(end-CS_length+1:end, :) = [];
Rx_data_mut(1:CP_length, :) = [];
Rx_data_mut(end-CS_length+1:end, :) = [];

% FFT
fft_sig = fft(Rx_data_sig);
fft_mut = fft(Rx_data_mut);

% 降采样
data_sig = fft_sig(carrier_position, :);
data_mut = fft_mut(carrier_position, :);

figure;
scatter(real(reshape(data_sig, 1, [])), imag(reshape(data_sig, 1, [])), '.');
grid on;
title('单径下接收信号星座图');

figure;
scatter(real(reshape(data_mut, 1, [])), imag(reshape(data_mut, 1, [])), '.');
grid on;
title('多径下接收信号星座图');

% =========================逆映射===========================
bit_demod_sig = reshape(qamdemod(data_sig, M, 'OutputType', 'bit'), [], 1);
bit_demod_mut = reshape(qamdemod(data_mut, M, 'OutputType', 'bit'), [], 1);

% =========================误码率===========================
error_bit_sig = sum(bit_demod_sig ~= bit_sequence);
error_bit_mut = sum(bit_demod_mut ~= bit_sequence);
error_rate_sig = error_bit_sig / bit_length;
error_rate_mut = error_bit_mut / bit_length;
rate = [rate; error_rate_sig error_rate_mut];

% 打印误码率
fprintf('单径误码率: %f\n', error_rate_sig);
fprintf('多径误码率: %f\n', error_rate_mut);





