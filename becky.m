close all
clear all
clc

[sample, rate] = readFile('becky.wav', 'newFile.wav');

function [data, sampleRate] = readFile(wavFile, newWavFile)
    [data, sampleRate] = audioread(wavFile);

    [numSamples, n] = size(data); %gives dimensions of array where n is the number of stereo channels
    
    %if stereo, combine to create single channel
    if n == 2
        data = data(:, 1) + data(:, 2); %sum(y, 2) also accomplishes this
    end

%     player = audioplayer(data, sampleRate);
%     play(player);

    audiowrite(newWavFile, data, sampleRate);
    %clear y sampleRate
    
%     %plot soundfile
%     h = stem(data);
%     set(h, 'Marker', 'none')

    %downsample
    resampledData = resample(data, 16000, sampleRate); %resample into 16kHz    
    
    time = numSamples/sampleRate

    amp = 5; 
    freq = 1000;
    t = 0:1/sampleRate:time;
    a=amp.*cos(2 .* pi .* freq .* t);
    sound(a);   
    
    %plot(t,a)

end

