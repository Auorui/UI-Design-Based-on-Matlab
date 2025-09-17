function decoded_numbers = convert_wav2num(filename, L, sample_duration, gap_duration)
    [y, fs] = audioread(filename);
    decoded_numbers = [];
    start_index = 1;

    % 分割音频信号并解码
    while start_index <= length(y)
        end_index = start_index + round(sample_duration * fs) - 1;
        if end_index > length(y)
            end_index = length(y);
        end

        % 提取当前拨号音段
        current_tone = y(start_index:end_index);
        decoded_key = dtmfdeco(current_tone, L, fs);
        if ~isempty(decoded_key)
            decoded_numbers = [decoded_numbers, decoded_key];
        end
        start_index = end_index + round(gap_duration * fs);
    end
end
