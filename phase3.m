close all;
clear all;
clc;

readFile('File1.wav', 'newFile1.wav');
readFile('File2.wav', 'newFile2.wav');
readFile('File3.wav', 'newFile3.wav');
readFile('File4.wav', 'newFile4.wav');
readFile('File5.wav', 'newFile5.wav');
readFile('File6.wav', 'newFile6.wav');
readFile('File7.wav', 'newFile7.wav');
readFile('File8.wav', 'newFile8.wav');
readFile('File9.wav', 'newFile9.wav');
 

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
   numChannels=16;   

    for i=1:numChannels-1

        rangeStart = (i-1) .* (7900/numChannels) + 100;
        rangeEnd = rangeStart + (7900/numChannels);
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
    sound(outputSig, sampleRate)
    audiowrite(newWaveFile,outputSig,sampleRate)


end