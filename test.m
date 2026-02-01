function audio_signal_gui()
  
    mainFigure = figure('name', 'Hello, Eng.Asmaa', 'position', [100, 100, 1000, 600], 'numbertitle', 'off');

   
    uicontrol('style', 'pushbutton', 'string', 'Generate Beep', 'position', [20,500,150,30],'callback',@generateBeep);

    uicontrol('style','pushbutton','string','Generate White Noise','position',[20,450,150,30],'callback',@generateWhiteNoise);
    
    uicontrol('style','pushbutton','string','Read and Play Audio','position',[20,400,150,30],'callback',@readAndPlayAudio);

    uicontrol('style','pushbutton','string','Add Noise','position',[20,350,150,30],'Callback',@addNoise);

    uicontrol('style','pushbutton','string','Record Audio','position',[20,300,150,30],'callback',@recordAudio);

    uicontrol('style','pushbutton','string','Increase Volume','position',[20,250,150,30],'callback',@(~,~)adjustVolume(10));
    uicontrol('style','pushbutton','string','Decrease Volume','position',[20,200,150,30],'callback',@(~,~)adjustVolume(0.1));

    uicontrol('style','pushbutton','string','Increase Speed','position',[20,150,150,30],'callback',@(~,~)adjustSpeed(1.5));
    uicontrol('style','pushbutton','string','Decrease Speed','position',[20,100,150,30],'callback',@(~,~)adjustSpeed(0.7));

    uicontrol('style','pushbutton','string','Echo','position',[200,500,150,30],'callback',@applyEcho);

    uicontrol('style','pushbutton','string','Remove Noise','position',[200,450,150,30],'callback',@removeNoise);

    uicontrol('style','pushbutton','string','Subtract Signals','position',[200,400,150,30],'callback',@subtractSignals);
    uicontrol('style','pushbutton','string','Multiply Signals','position',[200,350,150,30],'callback',@multiplySignals);

    uicontrol('style','pushbutton','string','Plot Signal','position',[200,300,150,30],'callback',@plotSignal);

    mainFigurePlace = axes('parent',mainFigure,'position',[0.43,0.1,0.55,0.8]);

    global audioData fs;
    audioData = [];
    fs = 44100; 

   
    function generateBeep(~)
        beep;
    end

    function generateWhiteNoise(~, ~)
        noise = randn(1, fs * 2); 
        sound(noise, fs);
    end

    function readAndPlayAudio(~, ~)
        [file, path] = uigetfile({'*.wav;*.mp3', 'Audio Files (*.wav, *.mp3)'});
        
        [audioData, fs] = audioread(fullfile(path, file));
        sound(audioData, fs);
    end

    function addNoise(~, ~)
        noise = 0.02 * randn(size(audioData));
        audioData = audioData + noise;
        sound(audioData, fs);
    end

    function recordAudio(~, ~)
        recObj = audiorecorder(fs, 16, 1);
        disp('Recording started...');
        recordblocking(recObj, 5); % Record for 5 seconds
        disp('Recording is finished!');
        audioData = getaudiodata(recObj);
        audiowrite('recorded_audio.wav', audioData, fs);
    end

    function adjustVolume(scale)
        
        audioData = audioData * scale;
        sound(audioData, fs);
    end

    function adjustSpeed(scale)
        
        sound(audioData, fs * scale);
    end

    function applyEcho(~, ~)
        
        delay = round(0.3 * fs); 
        echoSignal = [audioData; zeros(delay, 1)] + [zeros(delay, 1); 0.6 * audioData];
        audioData = echoSignal;
        sound(audioData, fs);
    end

    function removeNoise(~, ~)
        
       
        filteredData = lowpass(audioData, 0.1 * fs, fs);
        audioData = filteredData;
        sound(audioData, fs);
    end

    function subtractSignals(~, ~)
        x1=[3 4 6 9 0];
n1=-1:3;
x2=[1 0 5 8 4 2 7];
n2=-2:4;
% n= -2: 4 ;
        subplot(2,2,1);
stem(n1,x1); 
title('First Signal')
xlabel('n1');
ylabel('x1(n1)');

subplot(2,2,2);
stem(n2,x2);
title('Second Signal');
xlabel('n2');
ylabel('x2(n2)');



subplot(2,2,[3 4]);
% x1=[3 4 6 9 0];
% n1=[-1 0 1 2 3];
% y1 = [0 0 0 0 0 0 0]
% y2 = [0 0 0 0 0 0 0]
% y  = []
n=min(min(n1),min(n2)):max(max(n1),max(n2));
y1=zeros(1,length(n));
y2=zeros(1,length(n)); 
y1(  find( (n>=min(n1)  )  & (n<=max(n1)) )   )=x1; %
y2 (  find( (n>=min(n2))  & (n<=max(n2)) )   )=x2;
y=y1-y2;

stem(n,y);
title('Result Signal of the subtraction')
xlabel('n');
ylabel('y(n)');

    end

    function multiplySignals(~, ~)
x1=[3 4 6 9 0];
n1=-1:3;
x2=[1 0 5 8 4 2 7];
n2=-2:4;

subplot(2,2,1);
stem(n1,x1);
title('First Signal')
xlabel('n1');
ylabel('x1(n1)');

subplot(2,2,2);
stem(n2,x2);
title('Second Signal')
xlabel('n2');
ylabel('x2(n2)');

n=min(min(n1),min(n2)):max(max(n1),max(n2));
y1=zeros(1,length(n));
y2=zeros(1,length(n));
y1(  find( (n>=min(n1))  & (n<=max(n1)) )   )=x1;
y2 (  find( (n>=min(n2))  & (n<=max(n2)) )   )=x2;
y=y1.*y2;

subplot(2,2,[3 4]);
stem(n,y);
title('Result Signal of the Multiplication')
xlabel('n');
ylabel('y(n)');

    end





    function plotSignal(~, ~)
        
        
        axes(mainFigurePlace);
       
        plot(audioData);
        title('Signal graph');
        xlabel('Samples');
        ylabel('Amplitude');

    end
end