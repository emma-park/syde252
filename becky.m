clear all

myWav = 'becky.wav';
newWavFile = 'newFile.wav';
[x, Fs] = audioread(myWav);

[m, n] = size(x); %gives dimensions of array where n is the number of stereo channels

if n == 2
    y = x(:, 1) + x(:, 2); %sum(y, 2) also accomplishes this
end

player = audioplayer(y, Fs);
play(player);

audiowrite(newWavFile, y, Fs); 

h = stem(y);
set(h, 'Marker', 'none')

%downsample
S1 = resample(x, 16000, Fs); %resample into 16kHz

