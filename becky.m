close all;
clear all;
clc

[sample, rate] = readFile('becky.wav', 'newFile.wav');

function [data, sampleRate] = readFile(wavFile, newWavFile)
    [data, sampleRate] = audioread(wavFile);

    [numSamples, n] = size(data); %gives dimensions of array where n is the number of stereo channels
    
    %if stereo, combine to create single channel
    if n == 2
        data = data(:, 1) + data(:, 2); %sum(y, 2) also accomplishes this
    end

    audiowrite(newWavFile, data, sampleRate);
    
    %plot soundfile
    figure();
    h = stem(data);
    set(h, 'Marker', 'none');
    
    %downsample if sample rate is over 16000
    if sampleRate < 16000
        fprintf("sample rate too small");
    else
        data = resample(data, 16000, sampleRate); %resample into 16kHz
        sampleRate = 16000;
        [numSamples, n] = size(data);
    end
    
    time = numSamples/sampleRate;
    freq = 1000;
    t = 0:1/sampleRate:time/10;
    a=cos(2 .* pi .* freq .* t);
    %play sound
    sound(a, 1600);
    
    %change range of t to plot only 2 periods
    t = 0:1/sampleRate:1/500; % where T=1/f, so 2T=1/500
    a=cos(2 .* pi .* freq .* t);
    figure();
    plot(t,a);
end

