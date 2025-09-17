classdef zjr_dialing < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure              matlab.ui.Figure
        Menu                  matlab.ui.container.Menu
        Menu_open_wav         matlab.ui.container.Menu
        Menu_quite_app        matlab.ui.container.Menu
        Hyperlink             matlab.ui.control.Hyperlink
        Key_Dialing_Decoding  matlab.ui.control.StateButton
        Decoding_path         matlab.ui.control.EditField
        Label                 matlab.ui.control.Label
        BackgroundColorChooserColorPicker  matlab.ui.control.ColorPicker
        BackgroundColorChooserColorPickerLabel  matlab.ui.control.Label
        Text_Dialing          matlab.ui.control.TextArea
        Key_Quite             matlab.ui.control.StateButton
        Key_HangingUp         matlab.ui.control.StateButton
        Key_Dialing           matlab.ui.control.StateButton
        KeyD                  matlab.ui.control.Button
        Key12                 matlab.ui.control.Button
        Key10                 matlab.ui.control.Button
        Key11                 matlab.ui.control.Button
        KeyC                  matlab.ui.control.Button
        KeyB                  matlab.ui.control.Button
        KeyA                  matlab.ui.control.Button
        Key9                  matlab.ui.control.Button
        Key8                  matlab.ui.control.Button
        Key7                  matlab.ui.control.Button
        Key6                  matlab.ui.control.Button
        Key5                  matlab.ui.control.Button
        Key4                  matlab.ui.control.Button
        Key3                  matlab.ui.control.Button
        Key2                  matlab.ui.control.Button
        Key1                  matlab.ui.control.Button
        Axes_1                matlab.ui.control.UIAxes
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: Key1
        function Key1ButtonPushed(app, event)
            % 按键1的回调函数，按下后在文本框中显示
            currentText = app.Text_Dialing.Value; % 当前文本区域的值
            if isempty(currentText)
                newText = '1';
            else
                newText = strcat(currentText{1}, '1'); 
            end
            app.Text_Dialing.Value = {newText}; 
            encoded_tones = dtmfdial([1]);
            sound(encoded_tones, 8000);
            displaySpectrum(app, encoded_tones);

        end

        % Button pushed function: Key2
        function Key2ButtonPushed(app, event)
            % 按键2的回调函数，按下后在文本框中显示
            currentText = app.Text_Dialing.Value; % 获取当前文本区域的值
            if isempty(currentText)
                newText = '2';
            else
                newText = strcat(currentText{1}, '2'); 
            end
            app.Text_Dialing.Value = {newText}; 
            encoded_tones = dtmfdial([2]);
            sound(encoded_tones, 8000);

            displaySpectrum(app, encoded_tones);
        end

        % Button pushed function: Key3
        function Key3ButtonPushed(app, event)
            % 按键3的回调函数，按下后在文本框中显示
            currentText = app.Text_Dialing.Value; % 获取当前文本区域的值
            if isempty(currentText)
                newText = '3';
            else
                newText = strcat(currentText{1}, '3'); 
            end
            app.Text_Dialing.Value = {newText}; 
            encoded_tones = dtmfdial([3]);
            sound(encoded_tones, 8000);

            displaySpectrum(app, encoded_tones);
        end

        % Button pushed function: Key4
        function Key4ButtonPushed(app, event)
            % 按键4的回调函数，按下后在文本框中显示
            currentText = app.Text_Dialing.Value; % 获取当前文本区域的值
            if isempty(currentText)
                newText = '4';
            else
                newText = strcat(currentText{1}, '4'); 
            end
            app.Text_Dialing.Value = {newText}; 
            encoded_tones = dtmfdial([4]);
            sound(encoded_tones, 8000);

            displaySpectrum(app, encoded_tones);
        end

        % Button pushed function: Key5
        function Key5ButtonPushed(app, event)
            % 按键5的回调函数，按下后在文本框中显示
            currentText = app.Text_Dialing.Value; % 获取当前文本区域的值
            if isempty(currentText)
                newText = '5';
            else
                newText = strcat(currentText{1}, '5'); 
            end
            app.Text_Dialing.Value = {newText}; 
            encoded_tones = dtmfdial([5]);
            sound(encoded_tones, 8000);

            displaySpectrum(app, encoded_tones);
        end

        % Button pushed function: Key6
        function Key6ButtonPushed(app, event)
            % 按键6的回调函数，按下后在文本框中显示
            currentText = app.Text_Dialing.Value; % 获取当前文本区域的值
            if isempty(currentText)
                newText = '6';
            else
                newText = strcat(currentText{1}, '6'); 
            end
            app.Text_Dialing.Value = {newText}; 
            encoded_tones = dtmfdial([6]);
            sound(encoded_tones, 8000);

            displaySpectrum(app, encoded_tones);
        end

        % Button pushed function: Key7
        function Key7ButtonPushed(app, event)
            % 按键7的回调函数，按下后在文本框中显示
            currentText = app.Text_Dialing.Value; % 获取当前文本区域的值
            if isempty(currentText)
                newText = '7';
            else
                newText = strcat(currentText{1}, '7'); 
            end
            app.Text_Dialing.Value = {newText}; 
            encoded_tones = dtmfdial([7]);
            sound(encoded_tones, 8000);

            displaySpectrum(app, encoded_tones);
        end

        % Button pushed function: Key8
        function Key8ButtonPushed(app, event)
            % 按键8的回调函数，按下后在文本框中显示
            currentText = app.Text_Dialing.Value; % 获取当前文本区域的值
            if isempty(currentText)
                newText = '8';
            else
                newText = strcat(currentText{1}, '8'); 
            end
            app.Text_Dialing.Value = {newText}; 
            encoded_tones = dtmfdial([8]);
            sound(encoded_tones, 8000);

            displaySpectrum(app, encoded_tones);
        end

        % Button pushed function: Key9
        function Key9ButtonPushed(app, event)
            % 按键9的回调函数，按下后在文本框中显示
            currentText = app.Text_Dialing.Value; % 获取当前文本区域的值
            if isempty(currentText)
                newText = '9';
            else
                newText = strcat(currentText{1}, '9'); 
            end
            app.Text_Dialing.Value = {newText}; 
            encoded_tones = dtmfdial([9]);
            sound(encoded_tones, 8000);

            displaySpectrum(app, encoded_tones);
        end

        % Button pushed function: Key11
        function Key11ButtonPushed(app, event)
            % 按键*的回调函数，按下后在文本框中显示
            currentText = app.Text_Dialing.Value; % 获取当前文本区域的值
            if isempty(currentText)
                newText = '*';
            else
                newText = strcat(currentText{1}, '*'); 
            end
            app.Text_Dialing.Value = {newText}; 
            encoded_tones = dtmfdial([11]);
            sound(encoded_tones, 8000);

            displaySpectrum(app, encoded_tones);
        end

        % Button pushed function: Key10
        function Key10ButtonPushed(app, event)
            % 按键0的回调函数，按下后在文本框中显示
            currentText = app.Text_Dialing.Value; % 获取当前文本区域的值
            if isempty(currentText)
                newText = '0';
            else
                newText = strcat(currentText{1}, '0'); 
            end
            app.Text_Dialing.Value = {newText}; 
            encoded_tones = dtmfdial([10]);
            sound(encoded_tones, 8000);

            displaySpectrum(app, encoded_tones);
        end

        % Button pushed function: Key12
        function Key12ButtonPushed(app, event)
            % 按键#的回调函数，按下后在文本框中显示
            currentText = app.Text_Dialing.Value; % 获取当前文本区域的值
            if isempty(currentText)
                newText = '#';
            else
                newText = strcat(currentText{1}, '#'); 
            end
            app.Text_Dialing.Value = {newText}; 
            encoded_tones = dtmfdial([12]);
            sound(encoded_tones, 8000);

            displaySpectrum(app, encoded_tones);
        end

        % Value changed function: Key_HangingUp
        function Key_HangingUpValueChanged(app, event)
            value = app.Key_HangingUp.Value;
            cla(app.Axes_1);
            if value 
                app.Text_Dialing.Value = ''; % 清空文本区域的值，就是重新的输入我们的号码
            end
        end

        % Value changed function: Key_Dialing
        function Key_DialingValueChanged(app, event)
            value = app.Key_Dialing.Value;
            currentText = app.Text_Dialing.Value;

            % 将当前文本区域的值转换为字符数组
            if ~isempty(currentText)
                currentText = currentText{1}; % 转换为字符串
                dialedNumbers = [];

                % 遍历当前文本的每个字符
                for i = 1:length(currentText)
                    char = currentText(i);
                    if ismember(char, ['0':'9', '*', '#'])
                        switch char
                            case '0'
                                num = 10;
                            case '*'
                                num = 11;
                            case '#'
                                num = 12;
                            otherwise
                                num = str2double(char); 
                        end
                    dialedNumbers(end+1) = num;
                    end 
                end
                disp(dialedNumbers);
                encoded_tones = dtmfdial(dialedNumbers);
                sound(encoded_tones, 8000);

                duration = length(encoded_tones) / 8000; 
                % 暂停等待拨号音结束
                pause(duration);
                choice = questdlg('是否保存该音调?', ...
                '保存音调', ...
                '是', '否', '否');
                switch choice
                    case '是'
                        [file, path] = uiputfile('*.wav', '保存音调为');
                        if ischar(file) && ischar(path)
                            filename = fullfile(path, file);
                            normalized_tones = encoded_tones / max(abs(encoded_tones));

                            audiowrite(filename, normalized_tones, 8000);
                            msgbox('音调已保存', '保存成功');
                        else
                            msgbox('保存已取消', '取消');
                        end
                    case '否'
                        % 不做任何处理
                end
            end
        end

        % Value changed function: Key_Quite
        function Key_QuiteValueChanged(app, event)
            value = app.Key_Quite.Value;
            close all;
            clc;
            delete(app.UIFigure)
        end

        % Callback function: BackgroundColorChooserColorPicker
        function BackgroundColorChooserColorPickerValueChanged(app, event)
            value = app.BackgroundColorChooserColorPicker.Value;
            app.UIFigure.Color = value;
        end

        % Menu selected function: Menu_quite_app
        function Menu_quite_appSelected(app, event)
            Key_QuiteValueChanged(app, event)
        end

        % Menu selected function: Menu_open_wav
        function Menu_open_wavSelected(app, event)
            % 打开文件选择对话框,选择一个 .wav 文件, 将文件路径显示在 app.Decoding_path 文本框中
            [file, path] = uigetfile('*.wav', '选择 WAV 文件');
            if isequal(file, 0)
                disp('用户取消选择');
            else
                fullPath = fullfile(path, file);
                app.Decoding_path.Value = fullPath;
                disp(['用户选择了文件: ', fullPath]);
            end
        end

        % Value changed function: Key_Dialing_Decoding
        function Key_Dialing_DecodingValueChanged(app, event)
            wavPath = app.Decoding_path.Value;
    
            if isempty(wavPath) || ~isfile(wavPath)
                msgbox('请选择有效的 WAV 文件路径');
                return;
            end
            decoded_numbers = convert_wav2num(wavPath, 64, 0.5, 0.1);
            encoded_tones = dtmfdial(decoded_numbers);
            sound(encoded_tones, 8000);

            decoded_numbers_str = {};
            for i = 1:length(decoded_numbers)
                switch decoded_numbers(i)
                    case 10
                        decoded_numbers_str{end+1} = '0';
                    case 11
                        decoded_numbers_str{end+1} = '*';
                    case 12
                        decoded_numbers_str{end+1} = '#';
                    otherwise
                        decoded_numbers_str{end+1} = num2str(decoded_numbers(i));
                end
            end
            if ~isempty(decoded_numbers_str)
                msgbox(['解码结果: ', strjoin(decoded_numbers_str)], '解码结果');
            else
                msgbox('解码失败', '解码结果');
            end

        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 807 449];
            app.UIFigure.Name = 'MATLAB App';

            % Create Menu
            app.Menu = uimenu(app.UIFigure);
            app.Menu.Text = '选择';

            % Create Menu_open_wav
            app.Menu_open_wav = uimenu(app.Menu);
            app.Menu_open_wav.MenuSelectedFcn = createCallbackFcn(app, @Menu_open_wavSelected, true);
            app.Menu_open_wav.Text = '打开';

            % Create Menu_quite_app
            app.Menu_quite_app = uimenu(app.Menu);
            app.Menu_quite_app.MenuSelectedFcn = createCallbackFcn(app, @Menu_quite_appSelected, true);
            app.Menu_quite_app.Text = '退出';

            % Create Axes_1
            app.Axes_1 = uiaxes(app.UIFigure);
            title(app.Axes_1, '拨号键频谱图')
            xlabel(app.Axes_1, '频率 (Hz)')
            ylabel(app.Axes_1, '幅度')
            zlabel(app.Axes_1, 'Z')
            app.Axes_1.TitleFontWeight = 'bold';
            app.Axes_1.Position = [40 96 347 247];

            % Create Key1
            app.Key1 = uibutton(app.UIFigure, 'push');
            app.Key1.ButtonPushedFcn = createCallbackFcn(app, @Key1ButtonPushed, true);
            app.Key1.Position = [466 242 49 44];
            app.Key1.Text = '1';

            % Create Key2
            app.Key2 = uibutton(app.UIFigure, 'push');
            app.Key2.ButtonPushedFcn = createCallbackFcn(app, @Key2ButtonPushed, true);
            app.Key2.Position = [522 242 49 44];
            app.Key2.Text = '2';

            % Create Key3
            app.Key3 = uibutton(app.UIFigure, 'push');
            app.Key3.ButtonPushedFcn = createCallbackFcn(app, @Key3ButtonPushed, true);
            app.Key3.Position = [580 242 49 44];
            app.Key3.Text = '3';

            % Create Key4
            app.Key4 = uibutton(app.UIFigure, 'push');
            app.Key4.ButtonPushedFcn = createCallbackFcn(app, @Key4ButtonPushed, true);
            app.Key4.Position = [466 187 49 44];
            app.Key4.Text = '4';

            % Create Key5
            app.Key5 = uibutton(app.UIFigure, 'push');
            app.Key5.ButtonPushedFcn = createCallbackFcn(app, @Key5ButtonPushed, true);
            app.Key5.Position = [522 187 49 44];
            app.Key5.Text = '5';

            % Create Key6
            app.Key6 = uibutton(app.UIFigure, 'push');
            app.Key6.ButtonPushedFcn = createCallbackFcn(app, @Key6ButtonPushed, true);
            app.Key6.Position = [580 187 49 44];
            app.Key6.Text = '6';

            % Create Key7
            app.Key7 = uibutton(app.UIFigure, 'push');
            app.Key7.ButtonPushedFcn = createCallbackFcn(app, @Key7ButtonPushed, true);
            app.Key7.Position = [466 130 49 44];
            app.Key7.Text = '7';

            % Create Key8
            app.Key8 = uibutton(app.UIFigure, 'push');
            app.Key8.ButtonPushedFcn = createCallbackFcn(app, @Key8ButtonPushed, true);
            app.Key8.Position = [522 130 49 44];
            app.Key8.Text = '8';

            % Create Key9
            app.Key9 = uibutton(app.UIFigure, 'push');
            app.Key9.ButtonPushedFcn = createCallbackFcn(app, @Key9ButtonPushed, true);
            app.Key9.Position = [580 130 49 44];
            app.Key9.Text = '9';

            % Create KeyA
            app.KeyA = uibutton(app.UIFigure, 'push');
            app.KeyA.Position = [640 242 49 44];
            app.KeyA.Text = 'A';

            % Create KeyB
            app.KeyB = uibutton(app.UIFigure, 'push');
            app.KeyB.Position = [640 187 49 44];
            app.KeyB.Text = 'B';

            % Create KeyC
            app.KeyC = uibutton(app.UIFigure, 'push');
            app.KeyC.Position = [640 130 49 44];
            app.KeyC.Text = 'C';

            % Create Key11
            app.Key11 = uibutton(app.UIFigure, 'push');
            app.Key11.ButtonPushedFcn = createCallbackFcn(app, @Key11ButtonPushed, true);
            app.Key11.Position = [466 76 49 44];
            app.Key11.Text = '*';

            % Create Key10
            app.Key10 = uibutton(app.UIFigure, 'push');
            app.Key10.ButtonPushedFcn = createCallbackFcn(app, @Key10ButtonPushed, true);
            app.Key10.Position = [522 76 49 44];
            app.Key10.Text = '0';

            % Create Key12
            app.Key12 = uibutton(app.UIFigure, 'push');
            app.Key12.ButtonPushedFcn = createCallbackFcn(app, @Key12ButtonPushed, true);
            app.Key12.Position = [580 76 49 44];
            app.Key12.Text = '#';

            % Create KeyD
            app.KeyD = uibutton(app.UIFigure, 'push');
            app.KeyD.Position = [640 76 49 44];
            app.KeyD.Text = 'D';

            % Create Key_Dialing
            app.Key_Dialing = uibutton(app.UIFigure, 'state');
            app.Key_Dialing.ValueChangedFcn = createCallbackFcn(app, @Key_DialingValueChanged, true);
            app.Key_Dialing.Text = '拨号';
            app.Key_Dialing.Position = [466 33 105 25];

            % Create Key_HangingUp
            app.Key_HangingUp = uibutton(app.UIFigure, 'state');
            app.Key_HangingUp.ValueChangedFcn = createCallbackFcn(app, @Key_HangingUpValueChanged, true);
            app.Key_HangingUp.Text = '挂断';
            app.Key_HangingUp.Position = [580 32 109 26];

            % Create Key_Quite
            app.Key_Quite = uibutton(app.UIFigure, 'state');
            app.Key_Quite.ValueChangedFcn = createCallbackFcn(app, @Key_QuiteValueChanged, true);
            app.Key_Quite.Text = '退出';
            app.Key_Quite.BackgroundColor = [1 0 0];
            app.Key_Quite.FontSize = 18;
            app.Key_Quite.Position = [711 390 62 31];

            % Create Text_Dialing
            app.Text_Dialing = uitextarea(app.UIFigure);
            app.Text_Dialing.Position = [466 306 223 60];

            % Create BackgroundColorChooserColorPickerLabel
            app.BackgroundColorChooserColorPickerLabel = uilabel(app.UIFigure);
            app.BackgroundColorChooserColorPickerLabel.HorizontalAlignment = 'right';
            app.BackgroundColorChooserColorPickerLabel.Position = [13 23 150 22];
            app.BackgroundColorChooserColorPickerLabel.Text = 'Background Color Chooser';

            % Create BackgroundColorChooserColorPicker
            app.BackgroundColorChooserColorPicker = uicolorpicker(app.UIFigure);
            app.BackgroundColorChooserColorPicker.ValueChangedFcn = createCallbackFcn(app, @BackgroundColorChooserColorPickerValueChanged, true);
            app.BackgroundColorChooserColorPicker.Position = [178 23 38 22];

            % Create Label
            app.Label = uilabel(app.UIFigure);
            app.Label.HorizontalAlignment = 'right';
            app.Label.Position = [16 405 89 22];
            app.Label.Text = '解码音频路径：';

            % Create Decoding_path
            app.Decoding_path = uieditfield(app.UIFigure, 'text');
            app.Decoding_path.Position = [120 394 274 33];

            % Create Key_Dialing_Decoding
            app.Key_Dialing_Decoding = uibutton(app.UIFigure, 'state');
            app.Key_Dialing_Decoding.ValueChangedFcn = createCallbackFcn(app, @Key_Dialing_DecodingValueChanged, true);
            app.Key_Dialing_Decoding.Text = '解码';
            app.Key_Dialing_Decoding.Position = [419 398 105 25];

            % Create Hyperlink
            app.Hyperlink = uihyperlink(app.UIFigure);
            app.Hyperlink.URL = 'https://blog.csdn.net/m0_62919535/article/details/139704500';
            app.Hyperlink.Position = [714 14 56 22];
            app.Hyperlink.Text = 'Blog link';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = zjr_dialing

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