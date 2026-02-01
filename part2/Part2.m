[fileName, filePath] = uigetfile('*.mat', 'Select the ECG Data File');

if isequal(fileName, 0)
    disp('File selection cancelled. Exiting program.');
    return;
else
    fullFilePath = fullfile(filePath, fileName);
    disp(['File selected: ', fullFilePath]);
end

load (fullFilePath);

t=(0: length(ecg)-1)/samplingrate;
plot(t,ecg,'red');
title('ECG Signal');
xlabel('Time');
ylabel('ECG');
grid on;

[~,peaksLocations]=findpeaks(ecg,'MinPeakHeight', max(ecg) * 0.7, 'MinPeakDistance', 0.6 * samplingrate); %

RR=diff(peaksLocations);
Rate=60*(samplingrate/mean(RR))
RateInSeconds=Rate/60