function displaySpectrum(app, signal)
    cla(app.Axes_1);
    Fs = 8000; 
    L = length(signal);
    Y = fft(signal);
    P2 = abs(Y/L);
    P1 = P2(1:floor(L/2)+1);
    P1(2:end-1) = 2*P1(2:end-1);
    f = Fs*(0:floor(L/2))/L;

    % 在 Axes_1 上绘制频谱图
    plot(app.Axes_1, f, P1);
    % title(app.Axes_1, '拨号频谱图');
    % xlabel(app.Axes_1, '频率 (Hz)');
    % ylabel(app.Axes_1, '幅度');

    % 设置显示频率范围
    xlim(app.Axes_1, [0 2000]);
end
