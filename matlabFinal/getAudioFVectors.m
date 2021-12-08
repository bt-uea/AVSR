function [featureVectors] = getFVectors(audioFile, fs, vectorSamplePeriod, numChannels, overlapPercent)

    y = audioFile;
    
    % y = WienerScalart96(y, fs);
    
    featureVectors = [];

    numSamples=length(y);

    % totaldurationinseconds = length(y)/fs = 1118 - number frames
    numSamplesInFrame = vectorSamplePeriod * fs;
    numFrames = floor((numSamples / numSamplesInFrame) * (1 / (1 - overlapPercent)));

    % window = hamming(round(fs*0.3),'periodic');
    window = hamming(round(numSamplesInFrame),'periodic');

    firstSample = 1;

    for frame = 1:numFrames-1
        lastSample = firstSample + numSamplesInFrame - 1;

        % get small sample
        % this returns 1 x 480 - double for some files - Bruce's files
        % this returns 480 x 1 - double for some files - Ben's files
        % deal with inversion of matrix
        shortTimeFrame = y(firstSample:lastSample);
        [numRows,numCols] = size(shortTimeFrame);
        if (numCols>numRows)
            shortTimeFrame = shortTimeFrame.';
        end

        % compute dft to transfer from time signal to frequency signal
        % ft = fft(shortTimeFrame'.*window);
        ft = fft(shortTimeFrame.*window);

        % compute magnitude spectrum
        magSpec = abs(ft);

        % remove mirror after fft
        nonMirrorMagSpec = magSpec(1:length(magSpec) / 2);

        filterBank = applyMelTriangular(nonMirrorMagSpec, numChannels, fs, length(magSpec));
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

        firstSample = lastSample - floor(numSamplesInFrame * overlapPercent) + 1;
    end

    % Add deltas as extra vectors?

end