close all;
clear all;
clc;

readFile('File1.wav', 'newFile116.wav');
readFile('File2.wav', 'newFile216.wav');
readFile('File3.wav', 'newFile316.wav');
readFile('File4.wav', 'newFile416.wav');
readFile('File5.wav', 'newFile516.wav');
readFile('File6.wav', 'newFile616.wav');
readFile('File7.wav', 'newFile716.wav');
readFile('File8.wav', 'newFile816.wav');
readFile('File9.wav', 'newFile916.wav');


function readFile(wavFile, newWaveFile)
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
 
    
   % task 11
   %filter out non-bandpass frequencies

    for i=1:15

        rangeStart = (i-1) .* 493.75 + 100;
        rangeEnd = rangeStart + 493.75;
        freqRange = [rangeStart rangeEnd];
        outFilter = abs(bandpass(data, freqRange, sampleRate, 'ImpulseResponse', 'fir'));
        [numSamples, ~] = size(outFilter);
        t=0:1:numSamples-1;
        
        %task 10
        centralFreq=(rangeStart+rangeEnd)/2;
        Sig=cos(2*pi*centralFreq*t);
%         figure()
%         plot(t,a)


        %task 8
        outFilter = lowpass(outFilter, 400, sampleRate);
        
        ampModSig= Sig .*outFilter.';
        
        %task12
        if i==1
            outputSig=ampModSig;
        else
            outputSig=outputSig+ampModSig;
        end
    end  
    
    %task 13
 %   sound(outputSig, sampleRate)

    audiowrite(newWaveFile,outputSig,sampleRate)


end