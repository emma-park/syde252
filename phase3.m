close all;
clear all;
clc;

close all;
clear all;
clc

readFile('File1.wav', 'newFile1.wav');
% readFile('File2.wav', 'newFile2.wav');
% readFile('File3.wav', 'newFile3.wav');
% readFile('File4.wav', 'newFile4.wav');
% readFile('File5.wav', 'newFile5.wav');
% readFile('File6.wav', 'newFile6.wav');
% readFile('File7.wav', 'newFile7.wav');
% readFile('File8.wav', 'newFile8.wav');
% readFile('File9.wav', 'newFile9.wav');


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
 
    %this is probably wrong lol idk???
    time=numSamples/sampleRate;
    t=0:1/sampleRate:1/time;
    
    for i=1:7
        rangeStart = (i-1) .* 987.5 + 100;
        rangeEnd = rangeStart + 987.5;
        
        %task 10
        centralFreq=(rangeStart+rangeEnd)/2;
        Sig=cos(2*pi*centralFreq*t);
%         figure()
%         plot(t,a)

        % task 11
        ampModSig=lowpass(Sig,400,sampleRate)
        
        %task12
        if i==1
            outputSig=ampModSig;
        else
            outputSig=outputSig+ampModSig;
        end
    end  
    
    %task 13
    sound(outputSig, sampleRate);
    %probably should figure out a way to change the name? maybe function
    %param or something
    audiowrite('sound.wav',outputSig,sampleRate)


end