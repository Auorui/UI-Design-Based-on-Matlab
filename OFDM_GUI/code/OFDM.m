classdef OFDM < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                matlab.ui.Figure
        SNRdBSpinner            matlab.ui.control.Spinner
        SNRdBSpinnerLabel       matlab.ui.control.Label
        CS_lengthSpinner        matlab.ui.control.Spinner
        Label_4                 matlab.ui.control.Label
        CP_lengthSpinner        matlab.ui.control.Spinner
        Label_3                 matlab.ui.control.Label
        ifft_lengthSpinner      matlab.ui.control.Spinner
        IFFTSpinnerLabel        matlab.ui.control.Label
        symbol_countSpinner     matlab.ui.control.Spinner
        Label                   matlab.ui.control.Label
        carrier_countSpinner    matlab.ui.control.Spinner
        Label_2                 matlab.ui.control.Label
        ModulationTypeDropDown  matlab.ui.control.DropDown
        ModulationTypeLabel     matlab.ui.control.Label
        ButtonGroup             matlab.ui.container.ButtonGroup
        multipath               matlab.ui.control.ToggleButton
        singlepath              matlab.ui.control.ToggleButton
        ErrorRateShow           matlab.ui.control.EditField
        Label_5                 matlab.ui.control.Label
        ErrorRateCheckBox       matlab.ui.control.CheckBox
        quit                    matlab.ui.control.StateButton
        run                     matlab.ui.control.StateButton
        suspend                 matlab.ui.control.StateButton
        axes2                   matlab.ui.control.UIAxes
        axes1                   matlab.ui.control.UIAxes
    end

    
    properties (Access = private)
        isRunning logical = true; % 控制循环的变量
    end
    
    methods (Access = public)
        function error_rate = ofdm_test(app)
            carrier_count = app.carrier_countSpinner.Value;      % 子载波数
            symbol_count = app.symbol_countSpinner.Value;        % 总符号数
            ifft_length = app.ifft_lengthSpinner.Value;          % IFFT长度
            CP_length = app.CP_lengthSpinner.Value;              % 循环前缀长度
            CS_length = app.CS_lengthSpinner.Value;              % 循环后缀长度
            alpha = 7/32;                                        % 升余弦窗系数
            SNR = app.SNRdBSpinner.Value;                        % 信噪比
            modulation_type = app.ModulationTypeDropDown.Value;

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
            bit_moded = qammod(bit_sequence, M, 'InputType', 'bit', 'UnitAveragePower', true);
            ifft_position = zeros(ifft_length, symbol_count);
            bit_moded = reshape(bit_moded, carrier_count, []);
            carrier_position = 29:228;
            conj_position = 485:-1:286;
            ifft_position(carrier_position, :) = bit_moded;
            ifft_position(conj_position, :) = conj(bit_moded);
            signal_time = ifft(ifft_position, ifft_length);   % 512   100
    
            signal_time_C = [signal_time(end-CP_length+1:end, :); signal_time];
            signal_time_C = [signal_time_C; signal_time_C(1:CS_length, :)];
            signal_window = signal_time_C .* repmat(rcoswindow(alpha, size(signal_time_C, 1)), 1, symbol_count);
            signal_Tx = reshape(signal_window, 1, []);
            
            if app.multipath.Value
                path2 = 0.2 * [zeros(1, 20) signal_Tx(1:end-20)]; % 模拟延迟20个样本的路径
                path3 = 0.1 * [zeros(1, 50) signal_Tx(1:end-50)]; % 模拟延迟50个样本的路径
                signal_Txs = signal_Tx + path2 + path3; % 多径信号
            else
                signal_Txs = signal_Tx; 
            end
            Rx_data = awgn(signal_Txs, SNR, 'measured');
            Rx_data = reshape(Rx_data, ifft_length + CS_length + CP_length, []);
            Rx_data(1:CP_length, :) = [];
            Rx_data(end-CS_length+1:end, :) = [];
            % FFT
            fft_Rx_data = fft(Rx_data);
            data = fft_Rx_data(carrier_position, :);
            bit_demod = reshape(qamdemod(data, M, 'OutputType', 'bit'), [], 1);
            error_bit = sum(bit_demod ~= bit_sequence);
            error_rate = error_bit / bit_length;
        end
    
    
        function updateAndPlot(app)
            carrier_count = app.carrier_countSpinner.Value;      % 子载波数
            symbol_count = app.symbol_countSpinner.Value;        % 总符号数
            ifft_length = app.ifft_lengthSpinner.Value;          % IFFT长度
            CP_length = app.CP_lengthSpinner.Value;              % 循环前缀长度
            CS_length = app.CS_lengthSpinner.Value;              % 循环后缀长度
            alpha = 7/32;                                        % 升余弦窗系数
            SNR = app.SNRdBSpinner.Value;                        % 信噪比
            modulation_type = app.ModulationTypeDropDown.Value;

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
    
            while app.isRunning
                bit_sequence = randi([0, 1], bit_length, 1); 
                % ================子载波调制方式========================
                bit_moded = qammod(bit_sequence, M, 'InputType', 'bit', 'UnitAveragePower', true);
                % ===================IFFT===========================
                % =================串并转换==========================
                ifft_position = zeros(ifft_length, symbol_count);
                bit_moded = reshape(bit_moded, carrier_count, []);
                carrier_position = 29:228;
                conj_position = 485:-1:286;
                ifft_position(carrier_position, :) = bit_moded;
                ifft_position(conj_position, :) = conj(bit_moded);
                signal_time = ifft(ifft_position, ifft_length);   % 512   100
        
                signal_time_C = [signal_time(end-CP_length+1:end, :); signal_time];
                signal_time_C = [signal_time_C; signal_time_C(1:CS_length, :)];
                signal_window = signal_time_C .* repmat(rcoswindow(alpha, size(signal_time_C, 1)), 1, symbol_count);
        
                % ===================发送信号，多径信道====================
                signal_Tx = reshape(signal_window, 1, []); % 时域完整信号
                mult_path_am = [1 0.2 0.1]; % 多径幅度
                mutt_path_time = [0 20 50]; % 多径时延
                path2 = 0.2 * [zeros(1, 20) signal_Tx(1:end-20)]; % 模拟延迟20个样本的路径
                path3 = 0.1 * [zeros(1, 50) signal_Tx(1:end-50)]; % 模拟延迟50个样本的路径
                signal_Tx_mult = signal_Tx + path2 + path3; % 多径信号
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
        
                if app.singlepath.Value
                    % 显示单径信号
                    plot(app.axes1, signal_Tx);
                    title(app.axes1, '单径下OFDM信号');
    
                    cla(app.axes2); % 清除之前的图像
                    scatter(app.axes2, real(reshape(data_sig, 1, [])), imag(reshape(data_sig, 1, [])), '.');
                    grid(app.axes2, 'on');
                    title(app.axes2, '单径下接收信号星座图');
                    axis(app.axes2, [-3.5 3.5 -3.5 3.5]); % 固定坐标轴范围
                elseif app.multipath.Value
                    % 显示多径信号
                    plot(app.axes1, signal_Tx_mult);
                    title(app.axes1, '多径下OFDM信号');
    
                    cla(app.axes2); % 清除之前的图像
                    scatter(app.axes2, real(reshape(data_mut, 1, [])), imag(reshape(data_mut, 1, [])), '.');
                    grid(app.axes2, 'on');
                    title(app.axes2, '多径下接收信号星座图');
                    axis(app.axes2, [-3.5 3.5 -3.5 3.5]); % 固定坐标轴范围
                end
                drawnow; % 刷新图像
    
                % 确保暂停时循环退出
                if ~app.isRunning
                    break;
                end
            end
        end
    end


    % Callbacks that handle component events
    methods (Access = private)

        % Value changed function: run
        function runValueChanged(app, event)
            if ~isfield(app, 'isRunning') || ~app.isRunning
                app.isRunning = true;
                updateAndPlot(app); % 开始更新和绘图
            end
        end

        % Value changed function: suspend
        function suspendValueChanged(app, event)
            app.isRunning = ~app.isRunning; % 切换运行状态
        
            if app.isRunning
                app.suspend.Text = '暂停';
                runValueChanged(app, event); % 重新开始更新图像
            else
                app.suspend.Text = '恢复';
            end
        end

        % Value changed function: quit
        function quitValueChanged(app, event)
            if app.quit.Value
                app.isRunning = false;
                delete(app.UIFigure);
            end
        end

        % Value changed function: ErrorRateCheckBox, ErrorRateShow
        function ErrorRateCheckBoxValueChanged(app, event)

            app.ErrorRateShow.Value = '';
            if app.ErrorRateCheckBox.Value
                error_rate = ofdm_test(app);
                app.ErrorRateShow.Value = sprintf('%.7f', error_rate);
            else
                app.ErrorRateShow.Value = "0";
            end

        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 737 588];
            app.UIFigure.Name = 'MATLAB App';

            % Create axes1
            app.axes1 = uiaxes(app.UIFigure);
            title(app.axes1, 'OFDM信号')
            xlabel(app.axes1, 'Time/samples')
            ylabel(app.axes1, 'Amplitude')
            zlabel(app.axes1, 'Z')
            app.axes1.TitleFontWeight = 'bold';
            app.axes1.Position = [285 313 445 259];

            % Create axes2
            app.axes2 = uiaxes(app.UIFigure);
            title(app.axes2, '接收信号星座图')
            xlabel(app.axes2, 'X')
            ylabel(app.axes2, 'Y')
            zlabel(app.axes2, 'Z')
            app.axes2.TitleFontWeight = 'bold';
            app.axes2.Position = [286 54 445 250];

            % Create suspend
            app.suspend = uibutton(app.UIFigure, 'state');
            app.suspend.ValueChangedFcn = createCallbackFcn(app, @suspendValueChanged, true);
            app.suspend.Text = '暂停';
            app.suspend.Position = [372 17 68 29];

            % Create run
            app.run = uibutton(app.UIFigure, 'state');
            app.run.ValueChangedFcn = createCallbackFcn(app, @runValueChanged, true);
            app.run.Text = '开始';
            app.run.Position = [493 17 68 29];

            % Create quit
            app.quit = uibutton(app.UIFigure, 'state');
            app.quit.ValueChangedFcn = createCallbackFcn(app, @quitValueChanged, true);
            app.quit.Text = '退出';
            app.quit.Position = [619 17 68 29];

            % Create ErrorRateCheckBox
            app.ErrorRateCheckBox = uicheckbox(app.UIFigure);
            app.ErrorRateCheckBox.ValueChangedFcn = createCallbackFcn(app, @ErrorRateCheckBoxValueChanged, true);
            app.ErrorRateCheckBox.Text = '';
            app.ErrorRateCheckBox.Position = [45 536 17 22];

            % Create Label_5
            app.Label_5 = uilabel(app.UIFigure);
            app.Label_5.HorizontalAlignment = 'right';
            app.Label_5.Position = [60 536 42 22];
            app.Label_5.Text = '误码率';

            % Create ErrorRateShow
            app.ErrorRateShow = uieditfield(app.UIFigure, 'text');
            app.ErrorRateShow.ValueChangedFcn = createCallbackFcn(app, @ErrorRateCheckBoxValueChanged, true);
            app.ErrorRateShow.Position = [112 536 100 22];

            % Create ButtonGroup
            app.ButtonGroup = uibuttongroup(app.UIFigure);
            app.ButtonGroup.Title = '传播形式';
            app.ButtonGroup.Position = [46 45 166 84];

            % Create singlepath
            app.singlepath = uitogglebutton(app.ButtonGroup);
            app.singlepath.Text = '单径';
            app.singlepath.Position = [23 31 100 22];
            app.singlepath.Value = true;

            % Create multipath
            app.multipath = uitogglebutton(app.ButtonGroup);
            app.multipath.Text = '多径';
            app.multipath.Position = [23 10 100 22];

            % Create ModulationTypeLabel
            app.ModulationTypeLabel = uilabel(app.UIFigure);
            app.ModulationTypeLabel.HorizontalAlignment = 'right';
            app.ModulationTypeLabel.Position = [11 159 91 30];
            app.ModulationTypeLabel.Text = 'Modulation Type';

            % Create ModulationTypeDropDown
            app.ModulationTypeDropDown = uidropdown(app.UIFigure);
            app.ModulationTypeDropDown.Items = {'QPSK', '16QAM', '64QAM', '256QAM'};
            app.ModulationTypeDropDown.Position = [112 159 100 30];
            app.ModulationTypeDropDown.Value = 'QPSK';

            % Create Label_2
            app.Label_2 = uilabel(app.UIFigure);
            app.Label_2.HorizontalAlignment = 'right';
            app.Label_2.Position = [46 484 56 22];
            app.Label_2.Text = '载波数   ';

            % Create carrier_countSpinner
            app.carrier_countSpinner = uispinner(app.UIFigure);
            app.carrier_countSpinner.Position = [112 484 100 22];
            app.carrier_countSpinner.Value = 200;

            % Create Label
            app.Label = uilabel(app.UIFigure);
            app.Label.HorizontalAlignment = 'right';
            app.Label.Position = [46 431 56 22];
            app.Label.Text = '总符号数';

            % Create symbol_countSpinner
            app.symbol_countSpinner = uispinner(app.UIFigure);
            app.symbol_countSpinner.Position = [112 431 100 22];
            app.symbol_countSpinner.Value = 100;

            % Create IFFTSpinnerLabel
            app.IFFTSpinnerLabel = uilabel(app.UIFigure);
            app.IFFTSpinnerLabel.HorizontalAlignment = 'right';
            app.IFFTSpinnerLabel.Position = [46 378 56 22];
            app.IFFTSpinnerLabel.Text = 'IFFT长度';

            % Create ifft_lengthSpinner
            app.ifft_lengthSpinner = uispinner(app.UIFigure);
            app.ifft_lengthSpinner.Position = [112 378 100 22];
            app.ifft_lengthSpinner.Value = 512;

            % Create Label_3
            app.Label_3 = uilabel(app.UIFigure);
            app.Label_3.HorizontalAlignment = 'right';
            app.Label_3.Position = [11 326 91 22];
            app.Label_3.Text = '循环前缀长度';

            % Create CP_lengthSpinner
            app.CP_lengthSpinner = uispinner(app.UIFigure);
            app.CP_lengthSpinner.Position = [112 326 100 22];
            app.CP_lengthSpinner.Value = 128;

            % Create Label_4
            app.Label_4 = uilabel(app.UIFigure);
            app.Label_4.HorizontalAlignment = 'right';
            app.Label_4.Position = [11 273 91 22];
            app.Label_4.Text = '循环后缀长度';

            % Create CS_lengthSpinner
            app.CS_lengthSpinner = uispinner(app.UIFigure);
            app.CS_lengthSpinner.Position = [112 273 100 22];
            app.CS_lengthSpinner.Value = 20;

            % Create SNRdBSpinnerLabel
            app.SNRdBSpinnerLabel = uilabel(app.UIFigure);
            app.SNRdBSpinnerLabel.HorizontalAlignment = 'right';
            app.SNRdBSpinnerLabel.Position = [46 220 56 22];
            app.SNRdBSpinnerLabel.Text = 'SNR (dB)';

            % Create SNRdBSpinner
            app.SNRdBSpinner = uispinner(app.UIFigure);
            app.SNRdBSpinner.Position = [112 220 100 22];
            app.SNRdBSpinner.Value = 20;

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = OFDM

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end