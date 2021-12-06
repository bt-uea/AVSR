function [featureVector] = createFeaturesForMP4(filename, vectorSamplePeriod, numChannels, overlapPercent)

[audio, audioFreq] = audioread(filename);
audio = resample(audio, 16000, audioFreq);
audioFreq = 16000;

v = VideoReader(filename);
vidHeight = v.Height;
vidWidth = v.Width;
s = struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'),'colormap',[]);

k = 1;
while hasFrame(v)
    s(k).cdata = readFrame(v);
    k = k+1;
end

vidFrameRate = v.FrameRate;

featureVectors = [];

numAudioSamples=length(audio);

% totaldurationinseconds = length(y)/fs = 1118 - number frames
numSamplesInAudioFrame = vectorSamplePeriod * audioFreq;
numAudioFrames = floor((numAudioSamples / numSamplesInAudioFrame) * (1 / (1 - overlapPercent)));

% window = hamming(round(fs*0.3),'periodic');
window = hamming(round(numSamplesInAudioFrame),'periodic');

firstAudioSample = 1;

% TODO Make Sure Vectors Created At Same Rate For Audio & Vid 30.0036fps = 1
% frame every 33.3ms - we favoured 20ms with 50% overlap in testing for audio.
% So for a vector every 10ms each audio vector the corresponding vid vector
% will be used for 3.33 audio vectors.

frameToUse = 0;
frameNumber = 1;

for frame = 1:numAudioFrames-1
    lastAudioSample = firstAudioSample + numSamplesInAudioFrame - 1;

    % Get audio frame
    shortTimeFrame = audio(firstAudioSample:lastAudioSample);
    [numRows,numCols] = size(shortTimeFrame);
    if (numCols>numRows)
        shortTimeFrame = shortTimeFrame.';
    end


    % Specific to 20ms frames with 10ms overlap
    if(frameToUse == 9)
        % Extra frame for final so dont get next frame
        frameToUse = -1;
    elseif(mod(frameToUse, 3) == 0)
        % Get next frame for processing
        if(frameNumber <= length(s))
            frameFeatures = getVectorsImage(s(frameNumber));
            frameNumber = frameNumber + 1;
        else
            disp("ERROR");
        end
    end

    frameToUse = frameToUse + 1;

    % Get audio features

    % compute dft to transfer from time signal to frequency signal
    % ft = fft(shortTimeFrame'.*window);
    ft = fft(shortTimeFrame.*window);

    % compute magnitude spectrum
    magSpec = abs(ft);

    % remove mirror after fft
    nonMirrorMagSpec = magSpec(1:length(magSpec) / 2);

    filterBank = applyMelTriangular(nonMirrorMagSpec, numChannels, audioFreq, length(magSpec));
    % filterBank = applyMelRectangular(nonMirrorMagSpec, numChannels, fs, length(magSpec));
    % filterBank = applyLinRectangular(nonMirrorMagSpec, numChannels);

    % Log & DCT & truncate
    logfb = log(filterBank);
    mfcc = dct(logfb);

    %truncate
    % general rule is to truncate to half of coefficents
    lenMFC= length(mfcc);
    truncateSize = floor(lenMFC * (30 / numChannels));
    %fprintf('Truncating from %d to %d vectors', lenMFC,truncateSize)
    mfcc = mfcc(1:truncateSize);

    % add Energy component for frame
    mfcc(end + 1) = log(sum(mfcc.^2, 'all'));

    % consider velocity acceleration vectors?
    featureVectors = [featureVectors; mfcc];

    firstAudioSample = lastAudioSample - floor(numSamplesInAudioFrame * overlapPercent) + 1;
end

end

