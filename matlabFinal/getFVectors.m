function [combinedVectors] = getFVectors(vidFileName)

% Get audio from file and downsample to 16kHz from mp4 64?
[audio, audioFreq] = audioread(vidFileName);
audio = resample(audio, 16000, audioFreq);
audioFreq = 16000;

% Read video and store each fram in s struct
v = VideoReader(vidFileName);
vidHeight = v.Height;
vidWidth = v.Width;
s = struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'),'colormap',[]);

k = 1;
while hasFrame(v)
    s(k).cdata = readFrame(v);
    k = k+1;
end

% Need to measure frame every 10 - 50 ms
% 0.02 secs = 20 ms
vectorSamplePeriod = 0.02;

% overlap percent is the % that a frame will overlap the next /
% previous
overlapPercent = 0.5;
numChannels = 40;

% Get audio features
% (audioFile, fs, vectorSamplePeriod, numChannels, overlapPercent)
audioFs = getAudioFVectors(audio, audioFreq, vectorSamplePeriod, numChannels, overlapPercent);
numAudioFs = length(audioFs)

% Get Video features
videoFs = getVideoFVectors(s);

% Interp Combine and return vectors
numVideoFs = length(videoFs)
period = (numVideoFs / numAudioFs)

% currentVec = 1:sampleTime:(sampleTime * numVideoFs)); - current spacing
interpolatedVideoFs = interp1(videoFs, 1:  period : numVideoFs);
interpVideo = length(interpolatedVideoFs)

removeIfValsNotAdded = min([interpVideo, numAudioFs]);

combinedVectors = cat(2, audioFs(1:removeIfValsNotAdded, :), interpolatedVideoFs(1:removeIfValsNotAdded, :));

end

