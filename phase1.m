close all;
clear all;
clc

readFile('File1.wav', 'newFile1.wav');
readFile('File2.wav', 'newFile2.wav');
readFile('File3.wav', 'newFile3.wav');
readFile('File4.wav', 'newFile4.wav');
readFile('File5.wav', 'newFile5.wav');
readFile('File6.wav', 'newFile6.wav');
readFile('File7.wav', 'newFile7.wav');
readFile('File8.wav', 'newFile8.wav');
readFile('File9.wav', 'newFile9.wav');

function readFile(wavFile, newWavFile)
    [data, sampleRate] = audioread(wavFile);

    [numSamples, n] = size(data); %gives dimensions of array where n is the number of stereo channels
    
    %if stereo, combine to create single channel
    if n == 2
        data = sum(data,2)/2;
    end

    audiowrite(newWavFile, data, sampleRate);

    %set() plots soundfile
    figure();
    h = stem(data);
    set(h, 'Marker', 'none');
    name = wavFile(1:end-4); %new name for use in title and figure name
    title(name);
    savefig(join([name, 'sound']));
    
    %downsample if sample rate is over 16000
    if sampleRate < 16000
        fprintf("sample rate too small");
    else
        data = resample(data, 16000, sampleRate); %resample into 16kHz
        sampleRate = 16000;
        [numSamples, ~] = size(data);
    end
    
    time = numSamples/sampleRate;
    freq = 1000;
    t = 0:1/sampleRate:time/10;
    a=cos(2 .* pi .* freq .* t);
    %play sound
    sound(a, sampleRate);
    
    %change range of t to plot only 2 periods
    t = 0:1/sampleRate:1/500; % where T=1/f, so 2T=1/500
    a=cos(2 .* pi .* freq .* t);
    figure();
    plot(t,a);
    title (name);
    savefig(join([name, 'cos']));

end

