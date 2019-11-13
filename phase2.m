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

    %downsample if sample rate is over 16000
    if sampleRate < 16000
        fprintf("sample rate too small");
    else
        data = resample(data, 16000, sampleRate); %resample into 16kHz
        sampleRate = 16000;
        [numSamples, ~] = size(data);
    end
     
    for i=1:7
        rangeStart = (i-1) .* 987.5 + 100;
        rangeEnd = rangeStart + 987.5;
        freqRange = [rangeStart rangeEnd];

        %task 5
        %filter out non-bandpass frequencies
        outFilter = bandpass(data, freqRange, sampleRate);
        
        %task 6
        if i==1 || i==7
            figure()
            bandpass(data, freqRange, sampleRate);
        end
        
        %task 7 
        rectifiedOut = abs(outFilter);
        
        %task 8
        lowpassOut = lowpass(rectifiedOut, 400, sampleRate);
        
        %task 9
        if i==1 || i==7
            figure()
            lowpass(rectifiedOut, 400, sampleRate);
        end
    end

end