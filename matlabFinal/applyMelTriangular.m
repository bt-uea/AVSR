function [filterBank] = applyMelTriangular(nonMirrorMagSpec, numChannels, fs, magSpecLen)

% Get the range of freqs present in
freqs = 1 : fs / magSpecLen : fs/2;

% map 1st & final freq value to mel scale
melMinMax = hz2mel([1, fs/2]);

% take even distribution of mel freq (K + 1 to give K gaps between
% values if that makes sense)
spacedVals = linspace(melMinMax(1), melMinMax(2), numChannels + 2);

% convert values back to freq
convertedSpaced = mel2hz(spacedVals);

% numChannels
for channel = 1:numChannels

    % find closest val in freq (get the max after applying negation on all
    % values in arr)
    [valMin, idxMin] = min(abs(freqs - convertedSpaced(channel)));
    [valMax, idxMax] = min(abs(freqs - convertedSpaced(channel + 2)));

    % Just make sure idx not wrong
    if(idxMax < idxMin)
        disp('Max < Min Filterbank');
        idxMax = idxMin;
    end

    % select channel
    r = zeros(1, length(nonMirrorMagSpec));
    r(idxMin : idxMax) = abs(abs(linspace(-1, 1, (idxMax - idxMin) + 1)) - 1);
    % plot(r);
    % hold on;

    % sum all magnitude spectrum points
    filterBank(channel) = r*nonMirrorMagSpec;

end

% hold off;

end

